targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that can be used as part of naming resource convention')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

@description('Specifies the administrator username for the Virtual Machine.')
param adminUsername string

@description('Specifies the administrator password for the Virtual Machine.')
@secure()
param adminPassword string

@description('Specifies the Windows version for the VM. This will pick a fully patched image of this given Windows version.')
@allowed([
  '2022-Datacenter'
  '2022-Datacenter-Core'
  '2022-Datacenter-Core-smalldisk'
  '2022-Datacenter-Core-with-Containers'
  '2022-Datacenter-Core-with-Containers-smalldisk'
  '2022-Datacenter-smalldisk'
  '2022-Datacenter-with-Containers'
  '2022-Datacenter-with-Containers-smalldisk'
])
param windowsOSVersion string = '2022-Datacenter'
@description('Specifies the unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsLabelPrefix string

@description('Virtual machine size.')
param vmSize string = 'Standard_D4lds_v5'

var storageAccountName = '${environmentName}store'
var networkInterfaceName = '${environmentName}-nic'
var vNetAddressPrefix = '10.0.0.0/16'
var vNetSubnetName = 'default'
var vNetSubnetAddressPrefix = '10.0.0.0/24'
var publicIPAddressName = '${environmentName}-ip'
var vmName = 'winvm'
var vNetName = '${environmentName}-vnet'
var vaultName = '${environmentName}-vault'
var backupFabric = 'Azure'
var backupPolicyName = 'EnhancedPolicy'
var protectionContainer = 'IaasVMcontainer;iaasvmcontainerv2;${rg.name};${vmName}'
var protectedItem = 'vm;iaasvmcontainerv2;${rg.name};${vmName}'
var networkSecurityGroupName = 'default-NSG'




var abbrs = loadJsonContent('./abbreviations.json')

// Tags that should be applied to all resources.
// 
// Note that 'azd-service-name' tags should be applied separately to service host resources.
// Example usage:
//   tags: union(tags, { 'azd-service-name': <service name in azure.yaml> })
var tags = {
  'azd-env-name': environmentName
}
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

// This deploys the Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${environmentName}'
  location: location
  tags: tags
}

module storage './storage.bicep' = {
  name: 'storage'
  scope: rg
  params: {
    location: location
    tags: tags
    environmentName: environmentName
    storageAccountName: storageAccountName
  }
}

module publicIPAddress './public-ip-address.bicep' = {
  name: 'publicIPAddress'
  scope: rg
  params: {
    publicIPAddressName: 'piplab${resourceToken}'
    location: location
    tags: tags
    environmentName: environmentName
    dnsLabelPrefix: 'piplab${resourceToken}'

  }
}

module networkSecurityGroup './network-security-group.bicep' = {
  name: 'networkSecurityGroup'
  scope: rg
  params: {
    networkSecurityGroupName: networkSecurityGroupName
    location: location
    tags: tags
    environmentName: environmentName
  }
}

module virtualNetwork './virtual-network.bicep' = {
  name: 'virtualNetwork'
  scope: rg
  params: {
    vNetName: 'vnetlab${resourceToken}'
    location: location
    tags: tags
    environmentName: environmentName
    vNetAddressPrefix: vNetAddressPrefix
    vNetSubnetName: vNetSubnetName
    vNetSubnetAddressPrefix: vNetSubnetAddressPrefix
    networkSecurityGroupId: networkSecurityGroup.outputs.networkSecurityGroupId

  }
}

module networkInterface './network-interface.bicep' = {
  name: 'networkInterface'
  scope: rg
  params: {
    networkInterfaceName: networkInterfaceName
    location: location
    tags: tags
    environmentName: environmentName
    vNet: virtualNetwork.outputs.vNet
    vNetSubnetName: 'subnetlab${resourceToken}'
    publicIPAddressId: publicIPAddress.outputs.publicIPAddressId
  }
}

module virtualMachine './virtual-machine.bicep' = {
  name: 'virtualMachine'
  scope: rg
  params: {
    vmName: vmName
    vmSize: vmSize
    location: location
    tags: tags
    environmentName: environmentName
    adminUsername: adminUsername
    adminPassword: adminPassword // Use a secure method to handle passwords in production.
    networkInterface: networkInterface.outputs.nic
    storageAccount: storage.outputs.storageAccountId
    windowsOSVersion: windowsOSVersion
  }
}

module recoveryServicesVault './recovery-services-vault.bicep' = {
  name: 'recoveryServicesVault'
  scope: rg
  params: {
    vaultName: 'rsvlab${resourceToken}'
    location: location
    tags: tags
    environmentName: environmentName
  }
}

module recoveryProtectedItem './recovery-protected-item.bicep' = {
  name: 'recoveryProtectedItem'
  scope: rg
  params: {
    protectedItem: protectedItem
    location: location
    tags: tags
    environmentName: environmentName
    vaultName: recoveryServicesVault.outputs.vaultName
    virtualMachine: virtualMachine.outputs.vmId
    recoveryServicesVault: recoveryServicesVault.outputs.vaultId
    backupFabric: backupFabric
    backupPolicyName: backupPolicyName
    protectionContainer: protectionContainer
    
  }
}









// Add outputs from the deployment here, if needed.
//
// This allows the outputs to be referenced by other bicep deployments in the deployment pipeline,
// or by the local machine as a way to reference created resources in Azure for local development.
// Secrets should not be added here.
//
// Outputs are automatically saved in the local azd environment .env file.
// To see these outputs, run `azd env get-values`,  or `azd env get-values --output json` for json output.
output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId
