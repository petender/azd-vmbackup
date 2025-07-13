[comment]: <> (please keep all comment items at the top of the markdown file)
[comment]: <> (please do not change the ***, as well as <div> placeholders for Note and Tip layout)
[comment]: <> (please keep the ### 1. and 2. titles as is for consistency across all demoguides)
[comment]: <> (section 1 provides a bullet list of resources + clarifying screenshots of the key resources details)
[comment]: <> (section 2 provides summarized step-by-step instructions on what to demo)


[comment]: <> (this is the section for the Note: item; please do not make any changes here)
***
### Azure Backup for Windows Server Virtual Machine

<div style="background: lightgreen; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** Below demo steps should be used **as a guideline** for doing your own demos. Please consider contributing to add additional demo steps.
</div>

[comment]: <> (this is the section for the Tip: item; consider adding a Tip, or remove the section between <div> and </div> if there is no tip)

***
### 1. What Resources are getting deployed
This scenario deploys an Azure Virtual Machine running Windows Server 2022, together with Azure Recovery Vault Services with Azure Backup and a pre-configured backup job for your Virtual Machine.

The following Resources are getting deployed:

* rg-%azdenvironmentname - Azure Resource Group.
* azbackupwinvm - Azure Virtual Machine running Windows Server 2022
* azbackupwinvm_Disk - OSDisk and Data Disk
* Default-NSG - Network Security Group, allowing RDP access to the VM
* %environmentname%-vnet - Virtual Network with subnet for VM
* %environmentname%-vault - Azure Recovery Services vault with backup job
* %environmentname%backupstore - Storage Account used by Azure Recovery Services Vault

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/ResourceGroup_Overview.png" alt="Azure Backup Resource Group" style="width:70%;">
<br></br>

### 2. What can I demo from this scenario after deployment

Although this scenario could be used for most of the Vnet and Virtual Machine demos, the focus is on showcasing Azure Recovery Vault - Virtual Machine backup.

1. From the deployed scenario Resource Group, navigate to the Recovery Services Vault resource and open it. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/RecoveryServicesVault_Overview.png" alt="Recovery Services Vault Overview" style="width:70%;">
<br></br>

2. Navigate to **Protected Items / Backup Items** 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/Backup_Items.png" alt="Protected Items / Backup Items" style="width:70%;">
<br></br>

3. From the **Backup Management Types** list, highlight **Azure Virtual Machine**, and select it to open more details.

4. This opens the **Backup Items** detailed pane. Depending on how much time passed between the scenario deployment and doing the demo, the **Last Backup Status** might indicate a different status. The time of backup is defined by the **Enhanced Policy**. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/BackupItem_VMDetails.png" alt="Backup Items - VM Details" style="width:70%;">
<br></br>

5. Navigate back to the **Recovery Services Vault Overview**, and select **Backup Policies**. This will show different backup policies, a **DefaultPolicy** and an **EnhancedPolicy**. The DefaultPolicy comes with the setup of Azure Backup, the Enhanced Policy is a customization from the demo scenario. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/BackupPolicies.png" alt="Backup Items - VM Details" style="width:70%;">
<br></br>

6. **Open** the **DefaultPolicy**; in the **Backup Schedule**, it shows a Daily backup at 3:00AM in UTC Time Zone. It also has a retention of 2 days for instant recovery snapshots. Also highlight you can customize this backup policy even more, allowing for a weekly, monthly and yearly backup point retention.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/DefaultRetentionPolicy.png" alt="Backup Policy - Default Retention" style="width:70%;">
<br></br>

7. Return to the **BackupPolicies** view and open the **EnhancedPolicy**. While the concept of scheduled backups and data retention is identical to the Default Policy, notice this backup policy is configured with more granularity: 

- With backup schedule set to Hourly, the default selection for start time is 8 AM, schedule is Every 4 hours, and duration is 24 Hours. Hourly backup has a minimum RPO of 4 hours and a maximum of 24 hours. You can set the backup schedule to 4, 6, 8, 12, and 24 hours respectively.

- Instant Restore: You can set the retention of recovery snapshot from 1 to 30 days. The default value is set to 7.

- Retention range: Options for retention range are autoselected based on backup frequency you choose. The default retention for daily, weekly, monthly, and yearly backup points are set to 180 days, 12 weeks, 60 months, and 10 years respectively. You can customize these values as required.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/EnhancedPolicy.png" alt="Backup Policy - Default Retention" style="width:70%;">
<br></br>

8. Return to the **Azure Recovery Services Vault** view, and select **Backup Jobs** under the **Monitoring** section. This is where you could see different Backup Jobs details.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/BackupJobs.png" alt="Backup Policy - Default Retention" style="width:70%;">
<br></br>

9. Navigate to **Protected Items / Backup Items** 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/Backup_Items.png" alt="Protected Items / Backup Items" style="width:70%;">
<br></br>

10. From the **Backup Management Types** list, highlight **Azure Virtual Machine**, and select it to open more details.

<div style="background: lightgreen; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** Depending on the time between scenario deployment and doing the demos, the resulting backup details might look different.
</div>

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/azbackupwinvm_details.png" alt="VM Backup details" style="width:70%;">
<br></br>

11. In my scenario, not enough time was in-between deployment and backup job validation, which means the configured backup policies didn't apply yet. Therefore, I have to start a **manual backup**, by clicking the **Backup Now** button. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/BackupNow.png" alt="Start manual backup" style="width:70%;">
<br></br>

12. **Return** to the **Backup Jobs** pane, which will show you the actual running backup job:

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/BackupNow_Running.png" alt="Start manual backup" style="width:70%;">
<br></br>

13. **Wait** for the backup job to complete. This is usually just a couple of minutes. 

14. With the backup job still running, to kill time, why not positioning the **new Business Continuity Center** in the Azure Portal. To get here, click the **purple banner** message on top of the **Azure Recovery Services Vault** blade.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/BusinessContinuity_Banner.png" alt="Business Continuity Center Banner" style="width:70%;">
<br></br>

15. This **will become** the new way of managing and navigating your Backup and Site Recovery resources in the near future. Feel free to highlight some of its views, until the VM Backup is completed successfully.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/BusinessContinuity_Details.png" alt="Business Continuity Center Banner" style="width:70%;">
<br></br>

16. Navigate back to the **Backup Items** view, and notice the **Last Backup Status** says **success**. Open the more detailed view for this backup item. Focus on the **Recovery Points** section of the management pane. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/RecoveryPoints.png" alt="Business Continuity Center Banner" style="width:70%;">
<br></br>

Azure Backup provides independent and isolated backups to guard against unintended destruction of the data on your VMs. Backups are stored in a Recovery Services vault with built-in management of recovery points. Configuration and scaling are simple, backups are optimized, and you can easily restore as needed.

As part of the backup process, a snapshot is taken, and the data is transferred to the Recovery Services vault with no impact on production workloads. The snapshot provides different levels of consistency:

**Application-consistent** is the default setting in the VM backup policy. App-consistent backups capture memory content and pending I/O operations. App-consistent snapshots use a VSS writer (or pre/post scripts for Linux) to ensure the consistency of the app data before a backup occurs.
**File-system consistent** is the default setting in the VM backup policy. File-system consistent backups provide consistency by taking a snapshot of all files at the same time.
**Crash-consistent** this snapshot-based backup is an opt-in setting in the VM backup policy. Azure Backup also takes crash-consistent backups if the VM is not running during backup and when application/file-consistent backups fail. Only the data that already exists on the disk at the time of the backup operation is captured and backed up; data in read/write host cache isn't captured.

17. From the **Backup Item** view, select **Restore VM** from the top menu. This opens the **Restore Virtual Machine** blade, asking you to **select a Recovery Point**. Select any from the list available, and confirm the restore by pressing OK. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/RestoreVM.png" alt="Restore a VM" style="width:70%;">
<br></br>

18. Complete the necessary parameters for the **Restore Job**, following below suggestions:

- Restore Type: Create new Virtual Machine
- Virtual Machine Name: <name of choice>
- Resource Group: select the same Resource Group as used for the Azure Backup scenario
- Virtual Network: select the same Virtual Network as used for the Azure Backup scenario
- Subnet: select the same Subnet as used for the Azure Backup scenario
- Staging Location: select the Storage Account from the Azure Backup scenario

and confirm by clicking the **Restore** button. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/RestoreVM_Parameters.png" alt="Restore a VM - parameters" style="width:70%;">
<br></br>

<div style="background: lightgreen; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** Inform the learner that in a real-life environment, those parameters might be totally different, depending on the use case.
</div>

19. While the VM Restore job is running, you have time to also demonstrate **File Recovery**. From the **Backup Item** view, select **File Recovery** from the top menu. This opens the **File Recovery** blade. Select a **Restore Point** of choice. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/FileRecovery.png" alt="File Recovery" style="width:70%;">
<br></br>

20. You are requested to **download an Executable**, to trigger the actual file restore. 

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/FileRecoveryExecutable.png" alt="Download Executable" style="width:70%;">
<br></br>

21. Click **Download Executable**. This will generate the download script and secured password to allow restores. Wait for the confirmation to download the file, and save the exe-file in your local machine's Download folder.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/FileRecoveryExecutablePrompt.png" alt="Download Executable" style="width:70%;">
<br></br>

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/FileRecoveryExecutableComplete.png" alt="Download Complete Prompt" style="width:70%;">
<br></br>

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/FileRecoveryExecutableDownload.png" alt="Execute the PowerShell" style="width:70%;">
<br></br>

22. **Run the executable**, which actually starts a PowerShell session in a Terminal window. You are prompted for the restore job password, which can be found in the Azure File Recovery Portal in meantime:

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/FileRecoveryExecutablePassword.png" alt="Prompt for Recovery Password" style="width:70%;">
<br></br>

23. **Copy/Paste the generated password** into the Terminal Window (The process might restart, prompting for Administrator Permissions, depending on the PowerShell security settings of your local machine).

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/PowerShellPrompt.png" alt="Enter Recovery Password" style="width:70%;">
<br></br>

24. In the **PowerShell window**, wait for the **script to complete successfully** and confirm the Volumes have been mounted.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/PowerShellComplete.png" alt="PowerShell Volume Mount complete" style="width:70%;">
<br></br>

25. Navigate to your local machine's File Explorer, navigate to the Mount Volume of the Restored VM and you will be able to copy files and folders for restore.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/MountedVolumes.png" alt="Mounted VOlume on local machine" style="width:70%;">
<br></br>

26. In meantime, the **VM Restore** will be completed as well; show this by navigating to the **Virtual Machines** overview in Azure, highlighting both the production-running VM is still running, together with the **restored VM**.

<img src="https://raw.githubusercontent.com/petender/azd-vmbackup/refs/heads/main/demoguide/RestoredVM
.png" alt="Restored VM is running" style="width:70%;">
<br></br>

This completes the demo of Azure VM backup using Azure Recovery Services Vault. 

[comment]: <> (this is the closing section of the demo steps. Please do not change anything here to keep the layout consistant with the other demoguides.)
<br></br>
***
<div style="background: lightgray; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** This is the end of the current demo guide instructions.
</div>




