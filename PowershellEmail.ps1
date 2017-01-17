$From = "senderAddress@someaddress.com>"
$To = "someRecipent@someaddress.com"

$Attachment = "Filetoattach.txt"
$Subject = "SampleEmailSubject"
$Body = Get-Content Body | Out-String
$SMTPServer = "MailServerAddress"

Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer
