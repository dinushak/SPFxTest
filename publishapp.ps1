Param(
    [string]$username,
    [string]$password,
)

$packagePath = ".\release\sharepoint\solution\sp-fx-test.sppkg"
$encpassword = convertto-securestring -String $password -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $encpassword
Connect-PnPOnline -Url "https://dinushaonline.sharepoint.com/sites/dev" -Credentials $cred

$appExist = Get-PnPApp | ? { $_.Title -eq 'SPFxTest' }
if ($appExist -ne $null) {	
    Uninstall-PnPApp -Identity $appExist.Id		
	Remove-PnPApp -Identity $appExist.Id
}

Add-PnPApp -Path $packagePath -Publish -Overwrite

$appAfterAdd = Get-PnPApp | ? { $_.Title -eq 'SPFxTest' }
Publish-PnPApp -Identity $appAfterAdd.id
Install-PnPApp -Identity $appAfterAdd.id