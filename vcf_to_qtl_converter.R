setwd("~/wd/")

#prepearing a vcf for setting the alleles 
tx  <- readLines("cross.vcf")
tx2  <- gsub(pattern = "#CHROM", replace = "CHROM", x = tx)
writeLines(tx2, con="cross.vcf.wohash.vcf")
rm(tx,tx2)

vcf <- read.table("cross.vcf.wohash.vcf", header = T, stringsAsFactors = F)
vcf[,c(10:ncol(vcf))] <- sapply(vcf[,c(10:ncol(vcf))], function(x)(
  substr(x, 1,3)
))

#setting the maternal genotype which will be set to As
parent.A = "BK195"

#replacing vcf encoded alleles to As, Bs, and Hs
vcf[,10:ncol(vcf)] <-  t(apply(vcf[,10:ncol(vcf)], 1, function(x)(
  ifelse(x == x[names(x) == parent.A], "A",
         ifelse(x == "0/1" | x  == "1/0", "H", 
                ifelse(x == "./.", "-", "B")))
)))

#creating qtl formatted file 
Rqtl <- t(vcf[,c(3,10:ncol(vcf))])
colnames(Rqtl) <- Rqtl[1,]

#approximation of physical distance to genetic distance (1cM ~ 1Mbp)
Rqtl[1,] <- as.numeric(sub(".+_", "", colnames(Rqtl))) / 1000000

#adding chromosome numbers
Rqtl <- rbind(sub("_.+", "", sub("S", "", colnames(Rqtl))), Rqtl)

# this is optional step needed if the map is going to be reconstructed de novo without prioir information on markers
#Rqtl[1,] <- 1

#formatting to qtl object
Rqtl <-  as.data.frame(Rqtl)
Rqtl <- data.frame(id = rownames(Rqtl), Rqtl, row.names = NULL)

Rqtl[c(1,2),1] <- ""

write.table(Rqtl, "cross.qtl.csv", quote = F, sep = ",", row.names = F, na = "")

#Checking the correctness of the formatting by loading formatted file using qtl's read.cross function
library(qtl)
qtl.cross <- read.cross("csv", "", "cross.qtl.csv", estimate.map=F)
plot.map(qtl.cross, ylab = "Location (Mbp)")
