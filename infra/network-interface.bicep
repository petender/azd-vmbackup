targetScope = 'resourceGroup'

param environmentName string
param location string
param tags object
param networkInterfaceName string
param vNet object
param vNetSubnetName string
param publicIPAddressId string

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddressId
          }
          subnet: {
            id: vNet.properties.subnets[0].id
          }
        }
      }
    ]
  }
}

output nic string = networkInterface.id
