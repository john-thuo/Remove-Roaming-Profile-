# Remove-Roaming-Profile-
This scripts the Profile from roaming profile to Local profile and ensure that all the data in the server is returned and saved on the local user. 

Here's a PowerShell script that does the following:  

1. **Copies all files from redirected folders and the roaming profile** to your local profile (`C:\Users\YourUsername`).  
2. **Removes folder redirection** from the registry.  
3. **Disables roaming profiles** by modifying the registry.  
4. **Logs off the user** after completion to apply changes.  

### 🚨 **IMPORTANT NOTES:**  
- **Run this script as an administrator.**  
- **Replace `YourUsername` with your actual Windows username.**  
- **Ensure you have enough disk space before running this.**  
- If using Group Policy to enforce redirection, changes may revert after reboot unless GPO is modified.


### **How It Works:**
✅ **Copies** redirected files back to the local profile using `robocopy`  
✅ **Resets registry keys** for folder redirection  
✅ **Disables roaming profile** by clearing `CentralProfile` registry entry  
✅ **Logs off** the user to apply changes  

