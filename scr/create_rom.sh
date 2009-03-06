#!/bin/bash
TMP_FILE=tmp0000.tmp
OUT_FILE=out.dat
data_file="coeff_token_0_2.dat"




if [ -f $TMP_FILE ]
then
    rm $TMP_FILE
fi

if [ -f $OUT_FILE ]
then
    rm $OUT_FILE
fi

echo "always @* begin" >> $OUT_FILE
echo "case(Address) begin" >> $OUT_FILE

cat $data_file | sed 's/ //g' > $TMP_FILE

while read LINE
do
    char_count=`expr length $LINE`
    let bits_left=16-$char_count
    max_cnt=`echo "2^"$bits_left"" | bc`
#    echo $max_cnt
    #echo -n $LINE >> $OUT_FILE
    if [ $bits_left -eq "0" ] 
    then
	echo -n "16'b" >> $OUT_FILE
	echo -n $LINE >> $OUT_FILE
	echo ":" >> $OUT_FILE
    else
	for((i=0;i<$max_cnt;i+=1)); do
#    for((i=0;i<3;i+=1)); do
	    bin_string=`echo "obase=2;$i" | bc`
	    bin_string=`printf "%."$bits_left"d\n" "$bin_string"`
	    echo -n "16'b" >> $OUT_FILE
	    echo -n $LINE >> $OUT_FILE
	    echo -n $bin_string >> $OUT_FILE
	    echo ":" >> $OUT_FILE
	done
    fi
done < $TMP_FILE


echo "endcase" >> $OUT_FILE
echo "end" >> $OUT_FILE
