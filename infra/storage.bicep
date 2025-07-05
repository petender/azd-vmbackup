targetScope = 'resourceGroup'

param environmentName string
param location string
param tags object
param storageAccountName string


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
  properties: {}
}

output storageAccountId object = storageAccount
