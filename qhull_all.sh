#!/bin/bash

Dim=$(sed -n '5p' control.inp | sed 's/[^0-9]*//g');
Numpts=$(sed -n '8p' control.inp | sed 's/[^0-9]*//g');
Numits=$(sed -n '9p' control.inp | sed 's/[^0-9]*//g');
NumFiles=$(sed -n '10p' control.inp | sed 's/[^0-9]*//g');
#Output=$(sed -n '12p' control.inp | sed 's/outfile = //g');

a="$Dim\n$Numpts";
[ -e temp.txt ] || cat > temp.txt;
temp=temp.txt;
#for (( f=1; f<$NumFiles; f++ )) do
    #echo -e $a | cat - $f> $temp; 
    #cat $temp | qconvex QR0  FN  p Fv > ${f%.txt}.out; 
#done;
c=1;

# modify the mask for input, for example,
# for f in sphere[0-9][0-9][0-9].txt; do
for f in spherefinal[0-9].txt; do
    if [ "$c" -eq "$NumFiles" ]; then
        break;
    fi;
    echo -e $a | cat - $f> $temp; 
    cat $temp | qconvex  FN  p Fv > ${f%.txt}.out; 
    c=$((c+1));
done;
echo qhull done;
[ -d qhull\ output ] || mkdir qhull\ output;
for f in *.out; do
    mv $f ./qhull\ output/;
done;
