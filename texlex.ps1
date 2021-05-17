param([string]$instruction='', [string]$file='') 

function main {

write-host $instruction $file 




<# parancsfeldolgozas
*, ?, [a-n], [abc]
RegEx characters: ^ . [ ] - g G ? + * p P w W s S d D $

#>



# string literalban tarolt valtozo  típus
# Set-Variable 'valtozo1' -Value ('asdf' -as ('int32' -as [type]))
# (123 -as ('int32' -as [type])).gettype()


<# $lista = @()
$lista += @{_SSK = 0}
$lista += @{_SPPD = 0} #>
$cmds =@{ i = "string"; c = 'string'; r = 'int32'; t = 'int32'}
#$szoveg = "We are going to write the message by the User"
$cmd = '#tn123#isszo#rn2'
$cmdset = @()
$index = 0
#$relindex = 0

#$LizBesetzt = @{_SSK = 0; _3D = 0; _SPPD = 0; _CW3 = 0; _SPR = 0; _S3D = 0; _4D = 0; _SRP = 0}

#region 1. vegigkereses
#write-host $cmd.indexof('szo')
#write-host ($LizBesetzt | out-string)
#write-host ($lista | out-string)

# végigkereses:
<# do {$relindex = find $cmd $index '#' 1 #($szoveg.substring($index)).IndexOf('t')
    $index += $relindex
    Write-Host $cmd.substring($index)
    Write-Host ($index +=1)
}
while(($index -lt $szoveg.length) -and ($relindex -ne -1)) #> 
#endregion

#region $cmd beolvasasa
write-host $cmd.length
$index = 0
$notype = $true
while (($index -lt $cmd.length) -and ($pos1 -ne -1)) {
    $pos1 = find $cmd $index '#' 1
    if ($pos1 -ne -1){
        $index += $pos1 # a parancs betujenel allunk
        #write-host 'index+pos1: '$index
        write-host $cmd.substring($index,1)
        if($cmds.ContainsKey($cmd.substring($index,1))){
            #write-host 'parancs' 
            $pos2 =  (find $cmd $index '#' -1) # elmegyunk a kovetkezo # ig
            if ($pos2 -gt 0 ){
                #Write-Host 'n-s: '$cmd.substring($index+1,1)
                if ($cmd.substring($index+1,1) -eq 'n'){
                    $cmdset += @{$cmd.substring($index,1) = [int]$cmd.substring($index+2,$pos2-1)}
                    $notype = $false
                }elseif ($cmd.substring($index+1,1) -eq 's') {
                    $cmdset += @{$cmd.substring($index,1) = [string]$cmd.substring($index+2,$pos2-1)}
                    $notype = $false
                }
            $index += $pos2
            #write-host 'index+pos2: '$index 
            }else{
                $cmdset += @{$cmd.substring($index,1) = 0}
            }
        }
    }else{
        # ha nem talalt az elso keresesnel, valami hibauzenet, folyamat megszakitasa

    }

}
#endregion
write-host ($cmdset | out-string)
#pause
} #main
function find{
    param(
        [string]$where,
        [int]$start,
        [string]$what,
        [int]$rel = 0
    )
    $pos = -1
    $pos =  ($where.substring($start)).IndexOf($what)
    if($pos -gt -1){
        $pos += $rel
    }
    $pos
}
main 
#pause
<# write-host $szoveg.indexof('go')
Write-Host $szoveg.substring($szoveg.indexof('go')) #>
#write-host ($LizBesetzt | out-strin


<# while($i -lt $stdout.length){
} #>




<# function asdf{
    param(
        [string]$workdata
    )
} #>
