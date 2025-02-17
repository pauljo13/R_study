# Dat 5
# R package
## .libPaths() : get library locations containing R packages
.libPaths()

library() # list all available packages
library(lib.loc = .Library) # list all packages in the default library
library(help = splines) # documentation on package 'splines'
library(splines) # attach package 'splines'
require(splines) # the same
search() # give a list of attached packages

detach("package: splines")

# install.packages("package name")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("package name")

install.packages("devtools")

install.packages("~/Downloads/readxl_1.3.1.tgz", repos = NULL)

BiocManager::install("GEOquery")

library(GEOquery)
gse <- getGEO("GSE16659")
show(gse)
pheno <- attr(attr(gse[[1]], "phenoData"), "data")
expr <-  attr(gse[[1]], "assayData")[["exprs"]]
pheno
expr

# Quiz 
colnames(expr)
for (i in colnames(expr)) {
  colnames(expr)[colnames(expr) == i] <- gsub(" ","_", pheno[i,"title"])
}; colnames(expr)

# match(x, table, nomatch = NA_integer_, incomparables = NULL)
m <- matrix(c("a","b","c","d","e","A","B","C","D","E"),nrow=5,
            dimnames = list(1:5,c("lower","upper")))
m
match(c("d", "a", "z"), m[,"lower"])
m[match(c("d","a","z"), m[,"lower"]),"upper"]

match(colnames(expr), rownames(pheno))

annot <- attr(attr(gse[[1]], "featureData"), "data")
dim(annot)
colnames(annot)

#Quiz
annot["ID"]
annot["Gene Symbol"]
rownames(expr)
gene.symbol <- annot[match(rownames(expr), annot[,"ID"]), "Gene Symbol"]

# Add annotation
expr.lg2 <- round(log2(expr + 1), 4)
new.data <- data.frame("ProbeID"=rownames(expr.lg2), "GeneSymbol"=gene.symbol, expr.lg2)

getwd()
setwd("/Users/knu_cgl1/Desktop/Study/repositories/BIC0711_practice1")
write.table(new.data, file = "GSE16659R_series_matrix_log2_annot.txt", sep = "\t", row.names = FALSE, col.names = TRUE)
