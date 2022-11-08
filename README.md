# vcf_to_qtl
Rim Gubaev, 2019

This is a short R script for conversion of vcf file to R/qtl format for subsequent getetic map construction. 

##### Input data:

1) cross.vcf - standart vcf file produced by SNP calling software like Tassel-GBS,GATK, etc. 

##### Note! Both parents should be present in the vcf file! The parental alleles should be known across all markers! 


##### Output data:

1) cross.vcf.wohash.vcf - modifed intermediate vcf file that will be used to obtain R/qtl's cross object.

2) cross.qtl.csv - cross object that could be used to construct genetic map in R/qtl.

Email: rimgubaev@gmail.com

##### This script was used in the following publication:

Rim Gubaev, Stepan Boldyrev, Elena Martynova, Alina Chernova, Tatyana Kovalenko, Tatyana Peretyagina, Svetlana Goryunova, Denis Goryunov, Zhanna Mukhina, Cecile Ben, Laurent Gentzbittel, Philipp Khaitovich, Yakov Demurin, Genetic mapping of loci involved in oil tocopherol composition control in Russian sunflower (Helianthus annuus L.) lines, G3 Genes|Genomes|Genetics, Volume 12, Issue 4, April 2022, jkac036, https://doi.org/10.1093/g3journal/jkac036
