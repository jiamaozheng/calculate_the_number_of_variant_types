#!/bin/bash

# https://samtools.github.io/bcftools/bcftools.html

# TYPE for variant type in REF,ALT columns (indel,snp,mnp,ref,bnd,other). 
# Use the regex operator "\~" to require at least one allele of the given type or the equal sign "=" 
# to require that all alleles are of the given type. Compare
# TYPE="snp"
# TYPE~"snp"
# TYPE!="snp"
# TYPE!~"snp"

snp_counter=0
indel_counter=0
mnp_counter=0
other_counter=0

for file in $1*; do

        I=$file

        NOW=$(date +%Y-%m-%d/%H:%M:%S)
        echo "Starting at $NOW"
        echo $file

        let snp_counter=snp_counter+$(bcftools view -e 'TYPE!="snp"' $I |cut -f1 | wc -l)
        echo "snp: $snp_counter"

        let indel_counter=indel_counter+$(bcftools view -e 'TYPE!="indel"' $I |cut -f1 | wc -l)
        echo "indel: $indel_counter"

        let mnp_counter=mnp_counter+$(bcftools view -e 'TYPE!="mnp"' $I |cut -f1 | wc -l)
        echo "mnp: $mnp_counter"

        let other_counter=other_counter+$(bcftools view -e 'TYPE!="other"' $I |cut -f1 | wc -l)
        echo "other: $other_counter"


        NOW=$(date +%Y-%m-%d/%H:%M:%S)
        echo "Ending at $NOW"
done