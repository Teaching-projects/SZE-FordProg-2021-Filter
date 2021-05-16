Function Do-SomethingRegular{
    [CmdletBinding()]
    param(
            [String]$Message
    ) 
    Write-Verbose "We are going to write the message by the User" 
    Write-Output $Message
} 

Do-SomethingRegular -Message "Hi Mom" -verbose