targetScope = 'resourceGroup'

param environmentName string
param location string
param tags object
param vaultName string
param backupFabric string
param protectionContainer string
param protectedItem string
param recoveryServicesVault string
param backupPolicyName string
param virtualMachine string

resource vaultName_backupFabric_protectionContainer_protectedItem 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2020-02-02' = {
  name: '${vaultName}/${backupFabric}/${protectionContainer}/${protectedItem}'
  properties: {
    protectedItemType: 'Microsoft.Compute/virtualMachines'
    policyId: '${recoveryServicesVault}/backupPolicies/${backupPolicyName}'
    sourceResourceId: virtualMachine
  }
} 
