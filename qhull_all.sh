#!/bin/bash
USAGE="\e[1mUsage:\e[0m \e[3mqhull_all.sh\e[0m [-r|--riesz] [-i|--input file]\n"
OUTPATH='qhull_output'
[ -d "$OUTPATH" ] || mkdir "$OUTPATH";
temp=.temp;


if [ $# = 0 ]
then 
    echo -e $USAGE
fi

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -h|--help)
            echo -e $USAGE
            echo  This script will take all the files in the current folder that start with the;
            echo -e 'substring given by the "file" argument, and run "\e[1mqconvex  FN  p Fv\e[0m" on each.'
            echo -e "Note that \e[1mqconvex\e[0m expects the first two lines of the input to contain "
            echo dimension and the total number of points, and each subsequent line to contain
            echo coordinates of one point. You can specify these parameters from the command
            echo line using.
            echo If the points that are being used come from the Riesz optimization routines in 
            echo 'https://github.com/OVlasiuk/RieszEnergyOptimization, use [-r|--riesz].'
            echo 'The script will then search for "control.inp" in the current folder and parse'
            echo it for the dimension and total number of points.
            echo "";
            echo From the qconvex manual:
            echo -e "\e[1mFN\e[0m\nlist neighboring facets for each point. The first line is the total number of\npoints. Each remaining line starts with the number of neighboring facets. Each\nvertex of the cube example has three neighboring facets. Use 'Qc Qi FN' to\ninclude coplanar and interior points."
            echo -e "\e[1mFv\e[0m\n list vertices for each facet. The first line is the number of facets. Each\nremaining line starts with the number of vertices. For the cube example, each\nfacet has four vertices."
            echo -e "\e[1mp\e[0m\n print vertex coordinates. The first line is the dimension and the second line\nis the number of vertices. The following lines are the coordinates of each\nvertex."
            shift # past argument
            ;;
        -r|--riesz)
            RIESZ=1
            shift # past argument
            ;;
        -i|--input)
            INPATH="$2"
            shift # past argument
            ;;
        -d|--dimension)
            DIM="$2"
            shift # past argument
            ;;
        -n|--numpts)
            NUMPTS="$2"
            shift # past argument
            ;;
        --default)
            DEFAULT=YES
            ;;
        *)
            echo -e $USAGE
            ;;
    esac
    shift
done
if ! [ -z "$RIESZ" ];
then 
    echo Trying to parse control.inp...
    DIM=$(sed -n '5p' control.inp | sed 's/[^0-9]*//g');
    NUMPTS=$(sed -n '8p' control.inp | sed 's/[^0-9]*//g');
    NUMITS=$(sed -n '9p' control.inp | sed 's/[^0-9]*//g');
    NUMFILES=$(sed -n '10p' control.inp | sed 's/[^0-9]*//g');
    OUTPUT=$(sed -n '12p' control.inp | sed 's/outfile = //g');
    echo Done.
fi
a="$DIM\n$NUMPTS";
# modify the mask for input, for example,
# for f in sphere[0-9][0-9][0-9].txt; do
if ! [ -z "$INPATH" ]
then
    for f in $INPATH*; do
        #echo $f;
        echo ./${OUTPATH}/${f%.*}.out;
        echo -e $a | cat - $f> $temp; 
        cat $temp | qconvex  FN  p Fv > ./${OUTPATH}/${f%.*}.out; 
    done;
    echo Qhull done.
fi
if [ -e "$temp" ]  
then
    rm $temp;
fi
