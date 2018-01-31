$packagePath = ".\release\sharepoint\solution\sp-fx-test.sppkg"
$encpassword = convertto-securestring -String $(Password) -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $(Username), $encpassword
Connect-PnPOnline -Url "https://dinushaonline.sharepoint.com/sites/dev" -Credentials $cred
Add-PnPApp -Path $packagePath -Publish -Overwrite

$appAfterAdd = Get-PnPApp | ? { $_.Title -eq 'SPFxTest' }
Publish-PnPApp -Identity $appAfterAdd.id
Install-PnPApp -Identity $appAfterAdd.id