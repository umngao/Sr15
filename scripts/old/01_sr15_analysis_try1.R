rm(list=ls())
library(data.table)
source('D:/Dropbox/R/functions/write.x.R')

d.sr15 = fread('sr15datadump/sr15_temperat_test.txt')
uniq.line = as.vector(unique(d.sr15$LINE))
### 61 levels
SEL = match(uniq.line,d.sr15$LINE)
write.x(d.sr15[SEL])



m.sr15 = fread('sr15kaspresult/sr15_marker_data.txt')
head(m.sr15)
str(m.sr15)
SEL2 = match(uniq.line, m.sr15$Accession)
write.x(m.sr15[SEL2,])

D = fread ('sr15datadump/Sr15_temp.marker.CDL.txt')
SEL3 = match(uniq.line,D$V2)
dim(D[SEL3,])
write.x(D[SEL3,])

dd = fread('sr15datadump/Sr15_organize.txt') 
SEL4 = match (uniq.line, dd$LINE)
write.x(dd[SEL4,])

d.sr15.cdl.all = read.delim('sr15datadump/Sr15_all_data_CDL.txt')
head(d.sr15.cdl.all)
SEL5 = match(uniq.line, d.sr15.cdl.all$X.1)
ss = grep ('KBD', colnames(d.sr15.cdl.all))
write.x(d.sr15.cdl.all[SEL5,c(2,ss)])

ddd = read.delim('sr15datadump/Sr15_organize_plus_KBD.txt')
(as.vector(ddd$LINE) == as.vector(ddd$X.1))
write.x(ddd)
gene.fact = as.vector(ddd$Gene)
gene.fact[gene.fact == 'Sr15'] =1
gene.fact[gene.fact == 'Sr36'] =0
gene.fact[gene.fact == 'Sr36'] =0
gene.fact[gene.fact == '-']=0
gene.fact=as.factor(gene.fact)
KBD_886 = as.vector(ddd$KBD.886)
KBD_886[KBD_886=='x'] =0
KBD_886[KBD_886=='y'] =1
KBD_886[KBD_886=='-'] =0
KBD_886[KBD_886=='_'] =0
KBD_886[KBD_886=='H'] =0.5
KBD_886[KBD_886=='y/h?'] =0
anova(lm(as.numeric(gene.fact)~as.numeric(KBD_886)))

geno.hmp = read.delim('LD_HMP_file//GENO.HMP.txt',head=F)
LD.1 = read.delim('LD_HMP_file//LD_9_marker.txt')
head(LD.1)
source('D:/Dropbox/R/functions/GWAS/tass4_summ.R')
write.x(convert.ld.tass(LD.1, geno.hmp))



d = read.delim ('sr15datadump/Sr15_to_linearize_out.txt')
gene.vec = as.vector(d$Gene)
gene.vec = gsub('SR15', 'Sr15', gene.vec);
gene.vec = gsub ('Sr15.*', 'Sr15',gene.vec)
gene.vec = gsub ('SrZelma', 'Sr15', gene.vec)
gene.vec = gsub ('SrZel.*', 'Sr15', gene.vec)
gene.vec = gsub ('Sr36', '-', gene.vec)
gene.vec[gene.vec == 'Sr15'] = 1
gene.vec[gene.vec =='-'] = 0
gene.vec = as.numeric(gene.vec)
cor.test (gene.vec, d$Cool.TTKSK.num, use = 'complete')
### -0.68
cor (gene.vec, d$Cool.TPMKC.num, use = 'complete')
summary(lm(d$Cool.TTKSK.num~as.factor(gene.vec)))  ##p=4.26e-10
anova(lm(d$Cool.TTKSK.num.1~gene.vec))


gene.vec = as.vector(d$Gene)
gene.vec = gsub('SR15', 'Sr15', gene.vec);
gene.vec = gsub ('Sr15.*', 'Sr15',gene.vec)
gene.vec = gsub ('SrZelma', 'Sr15', gene.vec)
gene.vec = gsub ('SrZel.*', 'Sr15', gene.vec)
gene.vec = gsub ('Sr36', NA, gene.vec)
gene.vec[gene.vec =='-'] = 0
gene.vec[gene.vec == 'Sr15'] = 1
anova(lm(d$Warm.TTKSK.num~as.factor(gene.vec)))  ##p=0.28; 
summary(lm(d$Warm.TTKSK.num~as.factor(gene.vec)))
##if without removing Sr36, p=~0.093

## Most of intermediate data saved 'sr15datadump/PD_table1_20170628.xlsx'
