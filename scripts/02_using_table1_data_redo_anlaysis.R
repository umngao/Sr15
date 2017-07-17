rm(list=ls())
library(data.table)

d = fread('sr15datadump/20170628_Table1_orig_out.txt')

x = colnames(d); x = gsub('18-22°C.','warm.',x); x = gsub('15-18°C.', 'cool.',x)
colnames(d) = x

### additing a column 'gene.format' to the data, this is formatted Yes or No data indicating presence or absence of Sr15, all other Sr were converted to - and then to "No"
### Y: Yes, N: No
d[, gene.format:=gsub('Sr15.*','Y',Gene, ignore.case = T)][,gene.format:=gsub('Sr.*','-',gene.format)][,gene.format:=gsub('-','N',gene.format)]
### Doing the same thing again, adding colum 'gene.format2' to data, it is similar to gene.format column, the only difference is that Sr38 AND Sr36 were converted to NA to avoid confounding effects
d[, gene.format2:=gsub('Sr15.*','Y',Gene, ignore.case = T)][,gene.format2:=gsub('Sr.*',NA,gene.format2)][,gene.format2:=gsub('-','N',gene.format2)]

write.table(d[,.(Line,cool.TTKSK,cool.TTKSK.num,warm.TTKSK,warm.TTKSK.num,Gene,gene.format,gene.format2)],'clipboard',sep='\t',quote=F,row.names=F)

summary(lm(cool.TTKSK.num~gene.format,data=d))  
summary(lm(cool.TTKSK.num~gene.format2,data=d))  

summary(lm(warm.TTKSK.num~gene.format,data=d))  
summary(lm(warm.TTKSK.num~gene.format2,data=d))  

