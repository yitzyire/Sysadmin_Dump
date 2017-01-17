$computers = Gc "c:\path\RemoteRegistry.txt"
foreach($pc in $computers){
            Write-Verbose ("{0}: Checking network availability" -f $pc)
            If (Test-Connection -ComputerName $pc -Count 1 -Quiet) {
                Try {
                    Write-Verbose ("{0}: Attempting remote registry access" -f $pc)
					$serviceMode = ( Get-WmiObject -computername $pc Win32_Service -filter "Name='RemoteRegistry'").ChangeStartMode('Automatic') 
					( Get-WmiObject -computername $pc Win32_Service -filter "Name='RemoteRegistry'").startservice()
                } Catch {
				
					$serviceMode = New-Object PSObject -Property @{
					Caption = $_.Exception.Message
                    Version = $_.Exception.Message
                    }
				}
			}
}
