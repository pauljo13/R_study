# day 7
setwd("/Users/knu_cgl1/Desktop/Study/repositories/BIC0711_practice1")
library(GEOquery)
gse <- getGEO("GSE25297")
pheno <- attr(attr(gse[[1]], "phenoData"), "data")
expr <- attr(gse[[1]], "assayData")[["exprs"]]
colnames(pheno)
dim(pheno)
colnames(expr) <- pheno[colnames(expr), 'title']
colnames(expr)

write.table(pheno, "GSE25297_phenodata.txt", sep="\t")
write.table(expr, "GSE25297_exprsdata.txt", sep="\t")
# Get t-test p-value and mean differences
exc.samples <- c("CNSlymphoma_rep4", "CNSlymphoma_rep5", "CNSlymphoma_rep7",
                 "NormalLymphNode_rep7")
expr.ft <- expr[,!(colnames(expr) %in% exc.samples)]
group <- pheno$Type[match(colnames(expr.ft),pheno$Sample)]
tres <- apply(expr.ft, 1, function(x) t.test(x~group))

tp <- sapply(tres, function(x) x$p.value)
td <- sapply(tres, function(x) x$estimate[2]-x$estimate[1])

colnames(pheno)
pheno["title"]
dim(pheno)

library(dplyr)
head(pheno)
grepl("CNS", pheno[1,"source_name_ch1"])

add_col <- function(x) {
  if (grepl("CNS", x)) {
    return("PCNSL")
  } else if (grepl("Normal", x)) {
    return("Normal")
  }
}

pheno$Type <- sapply(pheno$source_name_ch1, add_col)

colnames(expr) <- pheno[colnames(expr),'title']

exc.samples <- c("CNSlymphoma_rep4", "CNSlymphoma_rep5", "CNSlymphoma_rep7",
                 "NormalLymphNode_rep7")
expr.ft <- expr[,!(colnames(expr) %in% exc.samples)]
group <- pheno$Type[match(colnames(expr.ft),pheno$title)]
tres <- apply(expr.ft, 1, function(x) t.test(x~group))

tp