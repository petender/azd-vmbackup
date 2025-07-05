targetScope = 'resourceGroup'

param environmentName string
param location string
param tags object
param publicIPAddressName string
param dnsLabelPrefix string

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
  }
}

output publicIPAddress object = publicIPAddress
output publicIPAddressId string = publicIPAddress.id
