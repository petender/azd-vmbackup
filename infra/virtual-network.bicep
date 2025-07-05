targetScope = 'resourceGroup'

param environmentName string
param location string
param tags object
param vNetName string
param vNetAddressPrefix string
param vNetSubnetName string
param vNetSubnetAddressPrefix string
param networkSecurityGroupId string

resource vNet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vNetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vNetAddressPrefix
      ]
    }
    subnets: [
      {
        name: vNetSubnetName
        properties: {
          addressPrefix: vNetSubnetAddressPrefix
          networkSecurityGroup: {
            id: networkSecurityGroupId
          }
        }
      }
    ]
  }
}

output vNet object = vNet
output vNetId string = vNet.id
