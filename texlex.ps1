param([string]$cmd='', [string]$file='', $split = '#') 

#region

#endregion

function main {

    #test data

    <# $file = "D:\_EGYETEMI\FordProg\INGR_lizenz_roh.txt"
    $cmd = "#b#r0#e#g-----\r\n#r5#n#"
    $cmd += "#u#b#g\r\n\s{2}#r4#e#g\d{1,3}[.]\d{1,3}#r-1#n#sarray1#b#g\r\n\s{2}#x#iconcurr#r-1#"
    $cmd += '#f#' #>

    
    $cmd = $cmd -replace '##','#'
    write-host '   INFO:  input data:  ' $cmd"`r`n   "$file 

    if ( $file.length -gt 0 ){
        if(test-path $file){
                write-host "`r`n   INFO:  file valid"
        }else{
            write-host ' ERROR:  file invalid'
            exit
        }
    }else{
        write-host ' ERROR:  file invalid'
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
                s = 'string'; # save in array, named string
                n = ''; #insert LF
                p = ''; #output stream
                f = ''} # end symbol

    $global:seq = $none
    $global:cmdset = $none
    $global:result = ''
    $global:result_data = @{}

    #endregion globals                        

    #region states
    $global:states = @(@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}) #23

    $global:states[0] = @{'b' = 1;'o' = 4;'u' = 4}
    $global:states[1] = @{'i' = 2;'c' = 2;'g' = 2;'r' = 3} 
    $global:states[2] = @{'b' = 1;'r' = 3;'e' = 8;'x' = 18; 'f' = 23} 
    $global:states[3] = @{'b' = 1;'e' = 8;'x' = 18; 'f' = 23} 
    $global:states[4] = @{'b' = 5} 
    $global:states[5] = @{'i' = 6;'c' = 6;'g' = 6;'r' = 7} 
    $global:states[6] = @{'r' = 7;'e' = 13}
    $global:states[7] = @{'e' = 13}
    $global:states[8] = @{'i' = 9;'c' = 9;'g' = 9;'r' = 10} 
    $global:states[9] = @{'b' = 1;'o' = 4;'u' = 4;'r' = 10;'n' = 11;'s' = 12;'x' = 18; 'f' = 23} 
    $global:states[10] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 11;'s' = 12;'x' = 18; 'f' = 23}
    $global:states[11] = @{'b' = 1;'o' = 4;'u' = 4;'s' = 12;'x' = 18; 'f' = 23}
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
    $global:states[23] = @{'f' = 24}
    #endregion states                     

    write-host "`r`n   INFO:  splitter literal : " $split
    cmd_read $cmd

    if( $null -ne $global:cmdset) {
    write-host "`r`n   INFO:  command syntactically valid"
    }else{
        write-host "`r`n ERROR:  something went wrong..."
        exit
    }
    
    #write-host ($global:cmdset | out-string)
    cmdset_read 

    $global:filetext = ([IO.File]::ReadAllText($file)).trim()

    execute

    if($global:result.Length -eq 0){
        write-host "`r`n   INFO:  nothing found or no range to put out "
    }else{
        write-host "`r`n   OUTPUT:`r`n"
        $global:result
    }
    write-host "`r`n   DATA STRUCTURES:`r`n"
    write-host ($global:result_data | out-string)
} #main

function execute{
    $global:index = 0
    foreach ($step in $global:seq){ 
        $loop_result =''
        $t = 1
        $counter = 0
        $cond = $false
        if($step.ContainsKey('o') -and (-not $step.ContainsKey('u')) ){ 
            if([int]$step['t'] -lt 1 ){
                write-host 't is less then 1...'
                exit
            }else{
                $t = [int]$step['t']
            }
        }
       
        #write-host "t: $t  "
        $cond_pos = step_find $step
        while(($counter -lt $t)  -and (-not $cond)){


            foreach ($iloop in $step.loop){
                $iloop_result = ''
                $normal = $true
                $nomatch = $false
                $range = loop_find $iloop

                if($range.Get_Item('b') -eq -1){ 
                    $normal = $false
                    $nomatch = $true
                }
                if($range.ContainsKey('b') -and -not $range.ContainsKey('e')){
                    $normal = $false
                    $global:index = ($range.Get_Item('b'))
                }
                if($normal){
                    if([int]$range.Get_Item('b') -gt [int]$range.Get_Item('e')){
                        write-host "`r`n ERROR:  range error `r`n"
                        exit
                    }

                    if(($step.ContainsKey('u') -and ($range.Get_Item('b') -lt $cond_pos) -and ($range.Get_Item('e') -lt $cond_pos)) -or(-not $step.ContainsKey('u')) -or
                     ( ($step.ContainsKey('u') -and $cond_pos -eq -1 )) ){ # -or (($counter -lt $t) -or ($null -eq $t))){
                        $iloop_result += $global:filetext.substring($range.Get_Item('b'), $range.Get_Item('e')-$range.Get_Item('b')+1)
                        #write-host $iloop_result
                        if ($iloop['n']){
                            $iloop_result += "`r`n"
                        }
                        if ($iloop['s']){
                            if(-not [bool]$global:result_data[[string]($iloop['s'])] ){
                            $global:result_data[[string]($iloop['s'])] = @()
                            }
                            $global:result_data[[string]($iloop['s'])] += $iloop_result
                        }
                        $loop_result += $iloop_result
                        #write-host $loop_result

                    }else{
                        $cond = $true
                    }
                    $global:index = ($range.Get_Item('e'))
                }
            }
            if($step.ContainsKey('o')){ $counter += 1 }
            elseif($step.ContainsKey('u')){$counter = 0}
            else{$counter = 1}  
        }
        if ($step['n']){
            $loop_result += "`r`n"
        }
        if ($step['s']){
            if(-not [bool]$global:result_data[[string]($step['s'])] ){
            $global:result_data[[string]($step['s'])] = @()
            }
            $global:result_data[[string]($step['s'])] += $loop_result
        }
        $global:result += $loop_result
    }   
} 
function step_find{
    param(
        $step
    )
    $pos = -1
    foreach($key in $step.keys){
        #write-host $key
        if($key.indexof('i') -gt -1 -or $key.indexof('c') -gt -1 -or $key.indexof('g') -gt -1 ){
            $expr1 = (("find_"+$key)+' '+($global:index)+' "'+($step.Get_Item($key))+'" '+($step.Get_Item('r'))).Replace("`r`n","")
            $pos = $global:index + (Invoke-Expression $expr1) 
        }
    }
    if(-not $step.ContainsKey('i') -and -not $step.ContainsKey('c') -and -not $step.ContainsKey('g') -and $step.ContainsKey('r')){
        $pos = $step.Get_Item('r')
    }
    $pos
}

function loop_find{
    param(
        $step
    )
    $pos = @{}
    foreach($key in $step.keys){
        $rel = $key.substring(0,1)+'r'
        if($key.indexof('i') -gt -1 -or $key.indexof('c') -gt -1 -or $key.indexof('g') -gt -1 ){
            $expr1 = (("find_"+($key.Replace("e","")).Replace("b",""))+' '+($global:index)+' "'+($step.Get_Item($key))+'" '+($step.Get_Item($rel))).Replace("`r`n","")
            $pos[$key.substring(0,1)] = $global:index + (Invoke-Expression $expr1) 
        }
    }
    if(-not $pos.ContainsKey('b') -and -not $step.ContainsKey('bi') -and -not $step.ContainsKey('bc') -and -not $step.ContainsKey('bg') -and $step.ContainsKey('br')){
        $pos['b'] = $step.Get_Item('br')
    }
    if(-not $pos.ContainsKey('e') -and -not $step.ContainsKey('ei') -and -not $step.ContainsKey('ec') -and -not $step.ContainsKey('eg') -and $step.ContainsKey('er')){
        $pos['e'] = $step.Get_Item('er')
    }
    $pos
}

function cmdset_read{

    $global:seq = @()
    $pair_counter = @{'o' = 0; 'u' = 0 ; 't' = 0 ; 'x' = 0 }
    $state = 0

    foreach ($cmd in $global:cmdset){

        if($cmd.keys -eq 'u' -or $cmd.keys -eq 'o'){
            $global:seq += @{} 
            $seq_counter = $global:seq.length-1
            $global:seq[$seq_counter][[string]$cmd.keys] = ''
            $pair_counter[[string]$cmd.keys] += 1
            $tx = $false        
        }

        if($cmd.keys -eq 'b' -and ($state -lt 4 -or $state -gt 17)){
            $global:seq += @{}
            $seq_counter = $global:seq.length-1
        }

        if($cmd.keys -eq 'b'){
            if(-not [bool]$global:seq[$seq_counter]['loop'] ){
                $global:seq[$seq_counter]['loop'] = @()
            }
            ($global:seq[$seq_counter]['loop']) += @{}
            $loop_counter = ($global:seq[$seq_counter]['loop']).Count -1
        }
    
        if(($state -lt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
        ((($global:seq[$seq_counter]['loop'])[$loop_counter]))['b'+[string]$cmd.keys] = ($cmd.values | out-string)
        }

        if(($state -lt 7) -and $cmd.keys -eq 'r' ){
            ((($global:seq[$seq_counter]['loop'])[$loop_counter]))['b'+[string]$cmd.keys] = ($cmd.values | out-string)   
        }
        if(($state -gt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
            if($tx){
                $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
            }else{((($global:seq[$seq_counter]['loop'])[$loop_counter]))['e'+[string]$cmd.keys] = ($cmd.values | out-string)
            }
        }
        if(($state -gt 7) -and $cmd.keys -eq 'r' ){
            if($tx){
                $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
            }else{((($global:seq[$seq_counter]['loop'])[$loop_counter]))['e'+[string]$cmd.keys] = ($cmd.values | out-string)
            }
        }
        if(($state -lt 18) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's')){ 
            ((($global:seq[$seq_counter]['loop'])[$loop_counter]))[[string]$cmd.keys] = ($cmd.values | out-string)
        }
        if(($state -gt 18) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's')){ 
            $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
        }
        if($cmd.keys -eq 't' -or $cmd.keys -eq 'x'){
            $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
            $pair_counter[[string]$cmd.keys] += 1
            $tx = $true 
        }

        if($cmd.keys -eq 'f'){ 
            $global:seq[$seq_counter][[string]$cmd.keys] = ''
        }
        #Write-Host 'old ' $state 'cmd: ' $cmd.keys
        $state = ($global:states[$state])[[string]$cmd.keys]
        if (-not $state ){
            write-host 'state error'
        }
        #Write-Host 'new: ' $state
    }
    
    #write-host ($global:seq | out-string)
    if($state -eq 23){
        if(($pair_counter['o'] -eq $pair_counter['t']) -and ($pair_counter['u'] -eq $pair_counter['x'])){
            Write-Host "`r`n   INFO:  Command sequence processed succsesfully"
        }else{
            Write-Host "`r`n ERROR:  Command sequence error, o-t or u-x pairs not match"
            exit
        }
    }else{
        Write-Host "`r`n ERROR:  Command sequence error, no acc."
        exit
    }
} 

function find_c{
    param(
        [int]$start,
        [string]$what,
        [int]$rel = 0,
        [string]$where = $global:filetext
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
        [int]$start,
        [string]$what,
        [int]$rel = 0,
        [string]$where = $global:filetext
    )
    $pos = -1
    $pos =  (($where.ToLower()).substring($start)).IndexOf($what.ToLower())
    if($pos -gt -1){
        $pos += $rel
    }
    $pos
}

function find_g{
    param(
        [int]$start,
        [string]$what,
        [int]$rel = 0,
        [string]$where = $global:filetext
    )
    $pos = -1
    $search =  [regex]::match($where.substring($start),$what)
    
    if($search.success){
        $pos = $search.index
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
    while (($index -lt $cmd.length-2) -and ($pos1 -ne -1)) {
        $pos1 = find_c $index $split 1 $cmd  
        if ($pos1 -ne -1){            
            $index += $pos1
            if($global:cmds.ContainsKey($cmd.substring($index,1))){
                $pos2 =  (find_c $index $split -1 $cmd )
                if($global:cmds[$cmd.substring($index,1)] -ne ''){
                    if ($pos2 -gt 0 ){
                        Set-Variable 'arg' -Value ($cmd.substring($index+1,$pos2) -as ($global:cmds[$cmd.substring($index,1)] -as [type]))
                        if($arg -eq $cmd.substring($index+1,$pos2)){
                    
                            $global:cmdset +=  @{$cmd.substring($index,1) = $arg}
                        }else{
                            write-host 'argument type mismatch at pos :' ($index+1) ':' $cmd.substring($index+1,$pos2)
                            exit
                        }
                    }else{
                        write-host 'ERROR command argument missing at pos. '($index+1)
                        write-host 'succesfully processed commands and arguments:'
                        write-host ($global:cmdset | out-string)
                        write-host 'ERROR quit'
                        exit
                    }
                }elseif($pos2 -eq 0){
                $global:cmdset +=  @{$cmd.substring($index,1) = ''}
                }else{
                    $global:cmdset +=  @{$cmd.substring($index,1) = ''}
                    write-host 'not processed input at pos :' ($index+1) ':'  $cmd.substring($index+1,$pos2)

                }
            }else{
                Write-Host 'unknown command: '$cmd.substring($index,1) 
            }
                $index += $pos2
        }
    }
}

main 
