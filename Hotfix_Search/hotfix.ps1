$computers = Gc "c:\filepath\MachinesHotfix.txt"
foreach($pc in $computers){
	get-hotfix 'KB2571388' -ComputerName $pc 
}
