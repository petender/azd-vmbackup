targetScope = 'resourceGroup'

param environmentName string
param location string
param tags object
param vaultName string

resource recoveryServicesVault 'Microsoft.RecoveryServices/vaults@2020-02-02' = {
  name: vaultName
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

output vaultName string = recoveryServicesVault.name
output vaultId string = recoveryServicesVault.id
