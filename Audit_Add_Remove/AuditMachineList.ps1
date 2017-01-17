$computers = Gc "D:\filepath\MachineList.txt"

foreach($pc in $computers){
	Try
	{
	( Get-WmiObject -computername $pc Win32_Service -filter "Name='RemoteRegistry'").ChangeStartMode('Enabled') 
	( Get-WmiObject -computername $pc Win32_Service -filter "Name='RemoteRegistry'").startservice()
	$null = $array = @()
    $UninstallKey="SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall" 
    $reg=[microsoft.win32.registrykey]::OpenRemoteBaseKey('LocalMachine',$pc) 
    $regkey=$reg.OpenSubKey($UninstallKey) 
    $subkeys=$regkey.GetSubKeyNames() 
 
 foreach($key in $subkeys){

        $thisKey=$UninstallKey+"\\"+$key 
        $thisSubKey=$reg.OpenSubKey($thisKey) 
        $obj = New-Object PSObject
        $obj | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $pc
        $obj | Add-Member -MemberType NoteProperty -Name "DisplayName" -Value $($thisSubKey.GetValue("DisplayName"))
        $obj | Add-Member -MemberType NoteProperty -Name "DisplayVersion" -Value $($thisSubKey.GetValue("DisplayVersion"))
        $obj | Add-Member -MemberType NoteProperty -Name "InstallLocation" -Value $($thisSubKey.GetValue("InstallLocation"))
        $obj | Add-Member -MemberType NoteProperty -Name "Publisher" -Value $($thisSubKey.GetValue("Publisher"))		
        $array += $obj		
		}
	$array | Where-Object { $_.DisplayName } | select ComputerName, DisplayName, DisplayVersion, Publisher | Export-CSV D:\filepath\$pc.csv | ft -auto 	
	}
	Catch [Exception]
	{
		$exception = "System not contactable"
		$exception | out-file D:\filepath\$pc.csv
	}
}
