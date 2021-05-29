param([string]$cmd='', [string]$file='', $split = '#') 

#region

#endregion

function main {

$file = "D:\_EGYETEMI\FordProg\INGR_lizenz_roh.txt"

$cmd = '#t123#iszo#r2#u#iertz#r2#usd#'
$cmd = '#u#u123#t25#usdf#t12#'
$cmd = '#iasdf#cwert#r12#o456#t21#ukjh#x-1#'
$cmd = '#u#iasdf#r2#ilkjh#r-1#'
$cmd = '#u#b#iasdf#r2#e#ilkjh#r-1#t2#p#f#'
$cmd = '#o#b#iasdf#r2#e#g\s{1,3}#n#t5#saszerk#b#cgfd#r-2#e#ilkj#f#'
$cmd = '#b#isplm#e#i-----#r4#n#u#b#g-----\n\s{2}#r7#e#g\n\s{2}#r3#n#x#iconcurr#r-1#f#'
$cmd = '#b#isplm#e#i-----#r4#n#u#b#g-----\n\s{2}#r7#e#g\n\s{2}#r3#n#f#'
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
            x = ''; # until condition
            s = 'string'; # save in array
            n = ''; #insert LF
            p = ''; #output stream
            f = ''} # end symbol

$global:seq = $none
$global:cmdset = $none
$global:pos
$global:filetext

#endregion globals                        

#region states
$global:states = @(@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}) #23

$global:states[0] = @{'b' = 1;'o' = 4;'u' = 4}
$global:states[1] = @{'i' = 2;'c' = 2;'g' = 2;'r' = 3} 
$global:states[2] = @{'b' = 1;'r' = 3;'e' = 8} 
$global:states[3] = @{'b' = 1;'e' = 8} 
$global:states[4] = @{'b' = 5} 
$global:states[5] = @{'i' = 6;'c' = 6;'g' = 6;'r' = 7} 
$global:states[6] = @{'r' = 7;'e' = 13}
$global:states[7] = @{'e' = 13}
$global:states[8] = @{'i' = 9;'c' = 9;'g' = 9;'r' = 10} 
$global:states[9] = @{'b' = 1;'o' = 4;'u' = 4;'r' = 10;'n' = 11;'s' = 12; 'f' = 23} 
$global:states[10] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 11;'s' = 12; 'f' = 23}
$global:states[11] = @{'b' = 1;'o' = 4;'u' = 4;'s' = 12; 'f' = 23}
$global:states[12] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 11;'f' = 23}
$global:states[13] = @{'i' = 14;'c' = 14;'g' = 14;'r' = 15} 
$global:states[14] = @{'b' = 1;'r' = 15;'n' = 16;'s' = 17;'x' = 18;'t' = 20} 
$global:states[15] = @{'b' = 1;'n' = 16;'s' = 17;'x' = 18;'t' = 20}  
$global:states[16] = @{'b' = 1;'s' = 17;'x' = 18;'t' = 20}
$global:states[17] = @{'b' = 1;'n' = 16;'x' = 18;'t' = 20}
$global:states[18] = @{'i' = 19;'c' = 19;'g' = 19;'r' = 20} 
$global:states[19] = @{'b' = 1;'o' = 4;'u' = 4;'r' = 20;'n' = 21;'s' = 22;'f' = 23}
$global:states[20] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 21;'s' = 22;'f' = 23}
$global:states[21] = @{'b' = 1;'o' = 4;'u' = 4;'s' = 22;'f' = 23}
$global:states[22] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 21;'f' = 23}


#$global:states[17] = @{'f' = 18}
#endregion states                     



write-host "`r`n splitter literal : " $split
cmd_read $cmd

if( $null -ne $global:cmdset) {
write-host "`r`n command syntactically valid `r`n" #($global:cmdset | out-string)
}else{
    write-host "`r`n something went wrong `r`n"
    exit
}
write-host ($global:cmdset | out-string)

cmdset_read $global:cmdset

execute $global:seq

} #main

function execute{
    param(
        $cmd_seq
    )

foreach ($step in $cmd_seq){ # nagykorok
# lehet o-t, darabszamszor
#lehet u-x feltételig

    foreach ($iloop in $step.loop){
    #loop() elemei bicg, br, eicg, er, n,s       
    

    }
}
}

<# function vari_loop{
    param(
        $t = 0,
        $icg = '',
        $x = ''

    )
    #mindket ciklus egy loopban
    #a darabszamot es a vegfeltetelt is figyeli, amit kapott, azzal loopol
    if($t -ne 0 -and ($icg -ne '' -or $x -ne '')){
        write-host 'error in function call vari-loop...'
        exit
    }
    $counter = 0
    do{

        $counter += 1

    }until($counter -eq $t -or )

} #>


function cmdset_read{
    param(
        $global:cmdset
    )
$global:seq = @()  # lista a loop elemekkel
$pair_counter = @{'o' = 0; 'u' = 0 ; 't' = 0 ; 'x' = 0 }
$state = 0

foreach ($cmd in $global:cmdset){

    if($cmd.keys -eq 'u' -or $cmd.keys -eq 'o'){
        $global:seq += @{}     # tobbszorozos mindig uj dict
        $global:seq[$global:seq.length-1][[string]$cmd.keys] = '' # u vagy o
        $pair_counter[[string]$cmd.keys] += 1        
    }

    if($cmd.keys -eq 'b' -and ($state -lt 4 -or $state -gt 17)){
        $global:seq += @{}
    }

    if($cmd.keys -eq 'b'){
        $global:seq[$global:seq.length-1]['loop'] = @{}
    }
 
    if(($state -lt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
        ($global:seq[$global:seq.length-1]['loop'])['b'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -lt 7) -and $cmd.keys -eq 'r' ){
        ($global:seq[$global:seq.length-1]['loop'])['b'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -gt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
        ($global:seq[$global:seq.length-1]['loop'])['e'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -gt 7) -and $cmd.keys -eq 'r' ){
        ($global:seq[$global:seq.length-1]['loop'])['e'+[string]$cmd.keys] = $cmd.values
    }

    if(($state -lt 13) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's' -or $cmd.keys -eq 'f')){  # sima belso vege
        ($global:seq[$global:seq.length-1]['loop'])[[string]$cmd.keys] = ''
    }

    if($cmd.keys -eq 't' -or $cmd.keys -eq 'x'){  # sima belso vege
        $global:seq[$global:seq.length-1][[string]$cmd.keys] = $cmd.values
        $pair_counter[[string]$cmd.keys] += 1 
    }

    if(($state -gt 15) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's' -or $cmd.keys -eq 'f')){  # sima belso vege
        $global:seq[$global:seq.length-1][[string]$cmd.keys] = ''
    }
########

    #a végén állítjuk elő a következő lépést
    Write-Host 'old ' $state 'cmd: ' $cmd.keys
    $state = ($global:states[$state])[[string]$cmd.keys]
    if (-not $state ){
        write-host 'state error'
    }

#if($state -eq 17 -and (-not ))
Write-Host 'new: ' $state
}   # foreach ($cmd in $global:cmdset)


write-host ($global:seq | out-string)

if($state -eq 23){
    if(($pair_counter['o'] -eq $pair_counter['t']) -and ($pair_counter['u'] -eq $pair_counter['x'])){
        Write-Host 'Command sequence processed succsesfully'
    }else{
        Write-Host 'Command sequence error, o-t or u-x pairs not match'
        exit
    }
}else{
    Write-Host 'Command sequence error, no acc.'
    exit
}
}   # function cmdset_read

function find_c{
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

function find_i{
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

function find_g{
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
    $global:cmdset = @()
    #$notype = $true
    while (($index -lt $cmd.length-2) -and ($pos1 -ne -1)) { #a szoveg hosszan belul es talalt kovetkezot
        $pos1 = find_c $cmd $index $split 1      # a kovetkezo # utani abszolut index
        if ($pos1 -ne -1){              # ha van kovetkezo #
            $index += $pos1 # a parancs betujenel allunk    Abszolut index-szel a talalat elejere allunk
            #write-host $cmd $index
            #write-host 'index+pos1: '$index
            #write-host $cmd.substring($index,1)
            if($global:cmds.ContainsKey($cmd.substring($index,1))){    #lekerdezzuk, hogy van-e ilyen parancs
                #write-host 'parancs' 
                $pos2 =  (find_c $cmd $index $split -1) # elmegyunk a kovetkezo # ig
                #write-host $cmd $index $pos2 
                if($global:cmds[$cmd.substring($index,1)] -ne ''){ #van argumentum tipus 
                    if ($pos2 -gt 0 ){  #ha 1, akkor nincs argumentum a parancshoz
                        Set-Variable 'arg' -Value ($cmd.substring($index+1,$pos2) -as ($global:cmds[$cmd.substring($index,1)] -as [type]))
                        #write-host $arg ($cmd.substring($index+1,$pos2))
                        if($arg -eq $cmd.substring($index+1,$pos2)){
                    
                            $global:cmdset +=  @{$cmd.substring($index,1) = $arg}
                        }else{
                            write-host 'argument type mismatch at pos :' ($index+1) ':' $cmd.substring($index+1,$pos2)
                            exit
                        }
                    }else{
                        #kotelezo argumentum hianyzik
                        write-host 'ERROR command argument missing at pos. '($index+1)
                        write-host 'succesfully processed commands and arguments:'
                        write-host ($global:cmdset | out-string)
                        write-host 'ERROR quit'
                        exit
                    }
                }elseif($pos2 -eq 0){ #nincs argumentum, csak parancs
                $global:cmdset +=  @{$cmd.substring($index,1) = ''} #csak beirja
                }else{
                    $global:cmdset +=  @{$cmd.substring($index,1) = ''}  #beirja es jelez
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
    $global:cmdset
}

main 
