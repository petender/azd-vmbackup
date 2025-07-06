# AZD-based Azure VM Backup template

This template can be used as a demo scenario for Azure Backup to showcase a Windows VM backup protection. It deploys all necessary resources such as Azure Recovery Services Vault, a Windows Server 2022 Virtual Machine and the necessary backup job. 

This scenario is part of the larger Azure Training Demo Scenario Catalog at [Trainer-Demo-Deploy](https://aka.ms/trainer-demo-deploy). 

## ⬇️ Installation
- [Azure Developer CLI - AZD](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd)
    - When installing AZD, the above the following tools will be installed on your machine as well, if not already installed:
        - [GitHub CLI](https://cli.github.com)
        - [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
    - You need Owner or Contributor access permissions to an Azure Subscription to  deploy the scenario.

## 🚀 Cloning the scenario in 4 steps:

1. Create a new folder on your machine.
```
mkdir tdd-azd-vmbackup
```
2. Next, navigate to the new folder.
```
cd tdd-azd-vmbackup
```
3. Next, run `azd init` to initialize the deployment.
```
azd init -t petender/tdd-azd-vmbackup
```
4. This clones all scenario artifacts into the new folder.

5. Run the actual deployment by using `azd up`
```
azd up
```
6. Provide the necessary input parameters (environment name, VM admin credentials,...)

7. Clean up the resources when no longer needed using `azd down`
```
azd down --force --purge
```

Use the [GitHub Issues](https://github.com/petender/azd-vmbackup/issues) from this repo to provide your feedback or suggestions, or reach out if you see any issues with the deployment. 

 
