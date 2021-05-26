param([string]$cmd='', [string]$file='', $split = '#') 

#region
<# tovabbi otletek
egymásba ágyazott feldolgozási egységek
#t tol #tx darabszam vagy #u tol #u i/c r feltetelig a ketto kozott tetszoleges, paros szamu feldolgozas
 #>

#endregion

function main {

$file = "D:\_EGYETEMI\FordProg\INGR_lizenz_roh.txt"

$cmd = '#t123#iszo#r2#u#iertz#r2#usd#'
$cmd = '#u#u123#t25#usdf#t12#'
$cmd = '#iasdf#cwert#r12#o456#t21#ukjh#x-1#'
$cmd = '#u#iasdf#r2#ilkjh#r-1#'
$cmd = '#u#b#iasdf#r2#e#ilkjh#r-1#t2#p#f#'
$cmd = '#b#iasdf#r2#e#g\s{1,3}#r12#n#saszerk#f#'

write-host 'input data: ' $cmd $file 


if ( $file.length -gt 0 ){
    if(test-path $file){
            write-host 'file valid'
    }else{
        write-host 'file invalid'
        exit
    }
}else{
    write-host 'file invalid'
    exit
}

#region globals
$global:cmds =@{   b = ''; # begin
            e = ''; #end
            i = 'string'; #c insens find
            c = 'string'; #c sens find
            g = 'string'; #find regex
            r = 'int32'; #rel pos
            o = ''; #start multiple 
            t = 'int32'; #count multiple
            u = ''; #start until
            x = 'string'; # until condition
            s = 'string'; # save in array
            n = ''; #insert LF
            p = ''; #output stream
            f = ''} # end symbol
#endregion globals                        

#region states
$global:states = @(@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}) #18

$global:states[0] = @{'b' = 1;'o' = 4;'u' = 4}
$global:states[1] = @{'i' = 2;'c' = 2;'g' = 2;'r' = 3} 
$global:states[2] = @{'r' = 3;'e' = 11} 
$global:states[3] = @{'b' = 1;'e' = 8; 'p' = 17} 
$global:states[4] = @{'b' = 5} 
$global:states[5] = @{'i' = 6;'c' = 6;'g' = 6;'r' = 7} 
$global:states[6] = @{'r' = 7} 
$global:states[7] = @{'b' = 1;'o' = 4;'u' = 4; 'e' = 11} 
$global:states[8] = @{'i' = 9;'c' = 9;'g' = 9;'r' = 10} 
$global:states[9] = @{'r' = 10} 
$global:states[10] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 15;'s' = 16;'f' = 17}
$global:states[11] = @{'i' = 12;'c' = 12;'g' = 12;'r' = 13} 
$global:states[12] = @{'b' = 1;'r' = 13;'t' = 14;'x' = 14} 
$global:states[13] = @{'b' = 1;'t' = 14;'x' = 14;'n' = 15;'s' = 16} 
$global:states[14] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 15;'s' = 16;'f' = 17} 
$global:states[15] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 15;'s' = 16;'f' = 17} 
$global:states[16] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 15;'s' = 16;'f' = 17} 
#$global:states[17] = @{'f' = 18}
#endregion states                     

#write-host ($global:cmdeval['u']).gettype().name
                 # n = '';   s = 'string'}                      n,s re meg ki kell talalni a feltetelt
#$szoveg = "We are going to write the message by the User" #>


#$index = 0
#$relindex = 0

write-host "`r`n splitter literal : " $split
$cmdset = cmd_read $cmd

if( $null -ne $cmdset) {
write-host "`r`n command syntactically valid `r`n" #($cmdset | out-string)
}else{
    write-host "`r`n something went wrong `r`n"
    exit
}
write-host ($cmdset | out-string)

cmdset_read $cmdset

#write-host (cmdset-read $cmdset| out-string)

#pause
} #main

function cmdset_read{
    param(
        $cmdset
    )

#$cmdlist =''
#$arglist = @()


$seq = @()  # lista a loop elemekkel
#$loop = @()    #nagykor
$pair_counter = @{'o' = 0; 'u' = 0 ; 't' = 0 ; 'x' = 0 }

$checkval = 0
$flag = 0
$state = 0
$ou = $false

#$_1chk = $true

#$iloop = @()    #kiskor, kegkisebb egyseg, elemei

#write-host $cmdset.keys$cmdset[$cmdset.keys]#.values
#$loop += @{}
foreach ($cmd in $cmdset){
    #$cmdlist += $cmd.keys
    #$flag += [math]::pow($global:base, ($global:cmdeval[[string]$cmd.keys]))
    #aktualis parancs berendezese a vegrehajtasi loopba
#loop-ot kezdhet b, u, o
    #tomb uj elem


#legkisebb egyseg: b icg r e icg r n s p
    if($cmd.keys -eq 'u' -or $cmd.keys -eq 'o'){
        $seq += @{}     # tobbszorozos mindig uj dict
        $seq[$seq.length-1][[string]$cmd.keys] = '' # u vagy o        
        #$ou = $true
    }

    if($cmd.keys -eq 'b' -and ($state -eq 0 -or $state -eq 3 -or  $state -gt 13)){
        $seq += @{}
    }

    if($cmd.keys -eq 'b'){
        $seq[$seq.length-1]['loop'] = @{}
    }
 
    if(($state -lt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
        ($seq[$seq.length-1]['loop'])['b'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -lt 7) -and $cmd.keys -eq 'r' ){
        ($seq[$seq.length-1]['loop'])['b'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -gt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
        ($seq[$seq.length-1]['loop'])['e'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -gt 7) -and $cmd.keys -eq 'r' ){
        ($seq[$seq.length-1]['loop'])['e'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -lt 12) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's')){  # sima belso vege
        ($seq[$seq.length-1]['loop'])[[string]$cmd.keys] = ''
    }

    if($cmd.keys -eq 't' -or $cmd.keys -eq 'x'){  # sima belso vege
        $seq[$seq.length-1][[string]$cmd.keys] = $cmd.values
    }

    if(($state -gt 12) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's' -or $cmd.keys -eq 'f')){  # sima belso vege
        $seq[$seq.length-1][[string]$cmd.keys] = ''
    }
########



<# if ($state -eq 1){    
}
if($cmd.keys -eq 'b'){
} #>

$filling = $false
if ($filling) {   
    if($cmd.keys -eq 'u' -or $cmd.keys -eq 'o' -or ($cmd.keys -eq 'b' -and ($state -eq 0 -or $state -eq 14 -or $state -eq 17 ))){
        $loop += @{}
    }
    #tobbszorozes kezdete
    if($cmd.keys -eq 'u' -or $cmd.keys -eq 'o'){
        #$loop += @{}
        ($loop[$loop.count-1])['augm']=[string]$cmd.keys
        $pair_counter[[string]$cmd.keys] += 1 
    }
    #kezdetek definiálása, mindket fele
    if ($state -eq 1 -or $state -eq 5 ){    
        #$loop[$loop.count-1])[$cmd.keys]
        if(($loop[$loop.count-1])['begin'] -eq $none){
        ($loop[$loop.count-1])['begin'] = @()   #[string]($cmd.values)
        }
        ($loop[$loop.count-1])['begin'] += @{[string]$cmd.keys = [string]($cmd.values)}
    }
    if ($state -eq 2 -or $state -eq 6 ){    #rel pos, ha van
        #$loop[$loop.count-1])[$cmd.keys]
        if(($loop[$loop.count-1])['begin'] -eq $none){
            ($loop[$loop.count-1])['begin'] = @()   #[string]($cmd.values)
        }
        ($loop[$loop.count-1])['begin'] += @{[string]$cmd.keys = [string]($cmd.values)}
    }
    #vegek definiálása, mindket fele
    if ($state -eq 8 -or $state -eq 11 ){    #kezdet definiálása
        #$loop[$loop.count-1])[$cmd.keys]
        if(($loop[$loop.count-1])['end'] -eq $none){
        ($loop[$loop.count-1])['end'] = @()   #[string]($cmd.values)
        }
        ($loop[$loop.count-1])['end'] += @{[string]$cmd.keys = [string]($cmd.values)}
    }
    if ($state -eq 9 -or $state -eq 12 ){    #rel pos, ha van
        #$loop[$loop.count-1])[$cmd.keys]
        if(($loop[$loop.count-1])['end'] -eq $none){
            ($loop[$loop.count-1])['end'] = @()   #[string]($cmd.values)
        }
        ($loop[$loop.count-1])['end'] += @{[string]$cmd.keys = [string]($cmd.values)}
    }
    #tobbszorozes vege
    if($cmd.keys -eq 't' -or $cmd.keys -eq 'x'){
        #$loop += @{}
        ($loop[$loop.count-1])['close']=[string]$cmd.keys
        $pair_counter[[string]$cmd.keys] += 1 
    }

}   # if ($filling)
    #a végén állítjuk elő a következő lépést
    Write-Host 'old ' $state 'cmd: ' $cmd.keys
    $state = ($global:states[$state])[[string]$cmd.keys]
    if (-not $state ){
        write-host 'state error'
    }

#if($state -eq 17 -and (-not ))
Write-Host 'new: ' $state
}   # foreach ($cmd in $cmdset)
write-host ($seq | out-string)

if($state -ne 17){

    Write-Host 'Command sequence error, no acc.'
}else{
    Write-Host 'Command sequence processed succsesfully'

}
}   # function cmdset_read

#u|o ellenorzese
#csak egy lehet valamelyikbol
<# $checkval = powercheck $flag 1,0
if(($checkval[0] + $checkval[1]) -gt 1){
    Write-Host 'Semantical error in command queue pos. ' $cmdset.indexof($cmd) $cmdlist
    exit
}else{
    $_1chk = $false

} #>



    #$flag += [math]::pow($base, $global:cmdeval[$cmd.keys])

#$checkval = check_cmdval $flag 1,0

<# write-host (check_cmdval $flag 7,6 | Measure-Object -sum).sum
if (((check_cmdval $flag 7,6 | Measure-Object -sum).sum) -eq 1){
    write-host 1
} #>

<# foreach (){

} #>

<# if([regex]::match($cmdlist,'(o|u)').success -and $_ou){
    ($loop[$loop.count-1])[$cmd.keys] = ''
    $_ou = $false
    #$cmdlist =''
    write-host ($loop.count)($loop[$loop.count-1] | out-string)
}
write-host ([regex]::match($cmdlist,'(o|u)((i|c|g)?r?){2}'))
write-host $cmdlist.count
if([regex]::match($cmdlist,'(o|u)((i|c|g)?r?){2}').success -and `
    ([regex]::match($cmdlist,'(o|u)((i|c|g)?r?){2}').length -eq $cmdlist.length)){
    $arglist += $cmd.values
    #($loop[$loop.count-1])[$cmd.keys] = ''
    #$cmdlist =''

} #>


# scope-ot tisztázni
#write-host $cmd.gettype()
#$cmd.GetEnumerator() | write-host $_.key $_.value 
#write-host $cmd.count # ($cmd[0]).value
#write-host $cmd.Keys $cmd[$cmd.Keys] #| % { "key = $_ , value = " + $cmd.Item($_) }

#| $_ # $cmd.values# | write-host $_  #, value = " + $hash.Item($_) }
#allapotok
<# $_ou = $true    # tobbszorozes indult
$_ou = $true    # tobbszorozes indult
$_ou = $true    # tobbszorozes indult 
$_ou = $true    # tobbszorozes indult #>


<# write-host $cmd.keys
write-host ($global:cmdeval['u']).gettype().name
write-host ([string]($cmd.keys)).gettype().name
write-host ($global:cmdeval[[string]$cmd.keys]).gettype().name #>
#write-host ([int]($global:cmdeval[$cmd.keys])).gettype().name



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

function cmd_read{
    param(
        $cmd
    )
    $index = 0
    $pos1 = 0
    $cmdset = @()
    #$notype = $true
    while (($index -lt $cmd.length-2) -and ($pos1 -ne -1)) { #a szoveg hosszan belul es talalt kovetkezot
        $pos1 = find $cmd $index $split 1      # a kovetkezo # utani abszolut index
        if ($pos1 -ne -1){              # ha van kovetkezo #
            $index += $pos1 # a parancs betujenel allunk    Abszolut index-szel a talalat elejere allunk
            #write-host $cmd $index
            #write-host 'index+pos1: '$index
            #write-host $cmd.substring($index,1)
            if($global:cmds.ContainsKey($cmd.substring($index,1))){    #lekerdezzuk, hogy van-e ilyen parancs
                #write-host 'parancs' 
                $pos2 =  (find $cmd $index $split -1) # elmegyunk a kovetkezo # ig
                #write-host $cmd $index $pos2 
                if($global:cmds[$cmd.substring($index,1)] -ne ''){ #van argumentum tipus 
                    if ($pos2 -gt 0 ){  #ha 1, akkor nincs argumentum a parancshoz
                        Set-Variable 'arg' -Value ($cmd.substring($index+1,$pos2) -as ($global:cmds[$cmd.substring($index,1)] -as [type]))
                        #write-host $arg ($cmd.substring($index+1,$pos2))
                        if($arg -eq $cmd.substring($index+1,$pos2)){
                    
                            $cmdset +=  @{$cmd.substring($index,1) = $arg}
                        }else{
                            write-host 'argument type mismatch at pos :' ($index+1) ':' $cmd.substring($index+1,$pos2)
                            exit
                        }
                    }else{
                        #kotelezo argumentum hianyzik
                        write-host 'ERROR command argument missing at pos. '($index+1)
                        write-host 'succesfully processed commands and arguments:'
                        write-host ($cmdset | out-string)
                        write-host 'ERROR quit'
                        exit
                    }
                }elseif($pos2 -eq 0){ #nincs argumentum, csak parancs
                $cmdset +=  @{$cmd.substring($index,1) = ''} #csak beirja
                }else{
                    $cmdset +=  @{$cmd.substring($index,1) = ''}  #beirja es jelez
                    write-host 'not processed input at pos :' ($index+1) ':'  $cmd.substring($index+1,$pos2)

                }
            }else{ #nincs ilyen parancs, mehetunk tovabb
                Write-Host 'unknown command: '$cmd.substring($index,1) 
            }

                #write-host 'index'$index
                $index += $pos2
                #write-host 'index+pos2: '$index 
        }
    }
    $cmdset
}

function powercheck{
    param(
        $cmdval,
        $exponents
) 

$result = @()
$exp = [math]::max([math]::floor([math]::log($cmdval)/[math]::log($global:base)),$exponents[0])
#write-host [string]$exp
#write-host ([math]::pow($base,$exp))
$count = 0
while($exp -ge 0 -and $count -lt $exponents.count){
    if ($cmdval - [math]::pow($global:base,$exp) -ge 0){
        if($cmdval/[math]::pow($global:base,$exp) -lt 4){
            if($exp -eq $exponents[$count]){
                $result += [math]::floor($cmdval / [math]::pow($global:base,$exp))
                $count +=1
            }else{
            }
            $cmdval -=  [math]::pow($global:base,$exp)*[math]::floor($cmdval/[math]::pow($global:base,$exp))
            $exp -= 1
        }  
    }else{
    if($exp -eq $exponents[$count]){
        $result += 0
        $count +=1
    }
    $exp -= 1
}
}
$result
}
<# function check_cmdval{
    param(
        $cmdval,
        $exponents
) 
$base = 4
$count = @()
foreach($exponent in $exponents){
    $count += 0
    while(($cmdval - [math]::pow($base,$exponent)) -ge 0){
        $cmdval -= [math]::pow($base,$exponent)
        $count[$exponents.IndexOf($exponent)] += 1
#[math]::pow(2,3)        
    }

}
    $count
} #>

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


                    

                            # string literalban tarolt valtozo  típus
                            # Set-Variable 'valtozo1' -Value ('asdf' -as ('int32' -as [type]))
                            # (123 -as ('int32' -as [type])).gettype()




                <# if ($cmd.substring($index+1,1) -eq 'n'){
                    $cmdset += @{$cmd.substring($index,1) = [int]$cmd.substring($index+2,$pos2-1)}
                    $notype = $false
                }elseif ($cmd.substring($index+1,1) -eq 's') {
                    $cmdset += @{$cmd.substring($index,1) = [string]$cmd.substring($index+2,$pos2-1)}
                    $notype = $false
                } #>
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