param([string]$file='', $instruction='') 

write-host $file $instruction

<# parancsfeldolgozas
*, ?, [a-n], [abc]
RegEx characters: ^ . [ ] - g G ? + * p P w W s S d D $

#>
#$cmd = '#tb#i"szo"#r"2"'

$lista = @()
$lista += @{_SSK = 0}
$lista += @{_SPPD = 0}

$LizBesetzt = @{_SSK = 0; _3D = 0; _SPPD = 0; _CW3 = 0; _SPR = 0; _S3D = 0; _4D = 0; _SRP = 0}


#write-host $cmd.indexof('szo')
write-host ($LizBesetzt | out-string)
write-host ($lista | out-string)

<# while($i -lt $stdout.length){
} #>

function get{
    param(
        [string]$workdata
    )
}



#pause
