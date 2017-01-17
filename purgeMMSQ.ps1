[Reflection.Assembly]::LoadWithPartialName("System.Messaging")
[System.Messaging.MessageQueue]::GetPrivateQueuesByMachine("hostname") | % {".\" + $_.QueueName} | % {[System.Messaging.MessageQueue]::Delete($_); }
