#This script assigns a Office 365 License to Users.This can be new users but also existing users.
#Fill in a Global Admin username and Password (this can be your own Office 365 account if you are a global admin in the Office 365 tenant)
#Scripts asks for the UserPrincipleName
#Afterwards choose the subscription you want to assign, commonly option A is the most used option
#Exit Script with X and the license will be assigned to the user, to check execute the followin Powershell command:
#Get-MsolUser -UserPrincipalName "Username" value under license must be set on TRUE. This way you know that the script worked..or check the Office 365 Portal
#Amanuyl Ok System Administrator\DevOps 18-12-2017, Last update 19-12-2017


$Usercredential = Get-Credential
Connect-MsolService -AzureEnvironment AzureCloud -Credential $Usercredential
$UserInOffice365 = READ-HOST -PROMPT 'Type in UserPrinciple Name'
Get-MsolUser -UserPrincipalName $UserInOffice365
Set-MsolUser -UserPrincipalName $UserInOffice365 -UsageLocation "TYPE IN YOUR COUNTRYCODE"

do {
    do {
        write-host ""
        write-host "A - Offic 365 Business Premium"
        write-host "B - Office 365 Enterprise"
        write-host "C - Visio"
        write-host "D - Exchange Online Only"
        write-host ""
        write-host "X - Exit"
        write-host ""
        write-host -nonewline "Type your choice and press Enter: "
        
        $choice = read-host
        
        write-host ""
        
        $ok = $choice -match '^[abcdx]+$'
        
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    
    switch -Regex ( $choice ) {
        "A"
        {
            write-host "You entered 'A'"
            Set-MsolUserLicense -UserPrincipalName $UserInOffice365 -addLicense "TENANTNAME:O365_BUSINESS_PREMIUM"
        }
        
        "B"
        {
            write-host "You entered 'B'"
            Set-MsolUserLicense -UserPrincipalName $UserInOffice365 -addLicense "TENANTNAME:ENTERPRISEPACK"
        }

        "C"
        {
            write-host "You entered 'C'"
            Set-MsolUserLicense -UserPrincipalName $UserInOffice365 -addLicense "TENANTNAME:VISIOCLIENT"
        }

        "D"
        {
            write-host "You entered 'D'"
            Set-MsolUserLicense -UserPrincipalName $UserInOffice365 -addLicense "TENANTNAME:EXCHANGESTANDARD"
        }
    }
} until ( $choice -match "X" )

