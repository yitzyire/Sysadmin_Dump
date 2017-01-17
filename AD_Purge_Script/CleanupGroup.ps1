Import-Module ActiveDirectory
Get-ADGroupMember -Identity "Name of the Group" | ForEach-Object { $Members = $_.SamAccountName; Remove-AdGroupMember -Identity "Name of the Group" -Members $Members -Confirm:$false }

$GroupNameWhereUsersAre = Gc "c:\Path\GroupName.txt"
foreach($user in $GroupNameWhereUsersAre){
Add-ADGroupMember -Identity "Name of the Group" -Member $user
}
