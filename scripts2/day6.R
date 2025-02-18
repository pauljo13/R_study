# day 6
# R practice 2
getwd()
setwd("/Users/knu_cgl1/Desktop/Study/repositories/BIC0711_practice1")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DEGseq")

file_path <- system.file("extdata", "GeneExpExample1000.txt", package = "DEGseq")
print(file_path)

setwd("/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/library/DEGseq/extdata/")
exdata <- read.table('GeneExpExample1000.txt', sep = "\t", header = T)
exdata

## Gene expression estimation
### RPKM(FPKM) = Reads (Fragments) Per Kilobase Per Million
### TPM = Transcript Per Million

cal_rpkm <- function(cnts, lens) {
  return(10^9 * (cnts/(sum(cnts) * lens)))
}
cal_tpm <- function(cnts, lens){
  tpm <- 10^6 * ((cnts/lens) / sum(cnts/lens))
}

expr <- exdata[,7:ncol(exdata)]
rownames(expr) <- exdata$EnsemblGeneID

gene.len <- as.numeric(exdata[,4] - exdata[,3])

rpkm.data <- apply(expr, 2, function(x) cal_rpkm(x, gene.len))
tpm.data <- apply(expr, 2, function(x) cal_tpm(x, gene.len))
rpkm.data
tpm.data

rpkm.data.lg2 <- log2(rpkm.data + 1)
tpm.data.lg2 <- log2(tpm.data + 1)

hist(tpm.data[,1])
hist(tpm.data[,1], xlab = "TPM", main = sprintf("Histogram of %s", colnames(tpm.data)[1]))
hist(tpm.data.lg2[,1], xlab = "log2(TPM + 1)", main = sprintf("Histogram of %s", colnames(tpm.data.lg2)[1]))

hist(rpkm.data[,1], xlab = "RPKM", main = sprintf("Histogram of %s", colnames(rpkm.data)[1]))
hist(rpkm.data.lg2[,1], xlab = "log2(RPKM + 1)", main = sprintf("Histogram of %s", colnames(rpkm.data.lg2)[1]))

# grep/grepl : search for matches of a regular expression/pattern in a character vector.
# lapply & sapply
a <- 1:10
b <- sapply(a, function(x) c(x,x))
c <- lapply(a, function(x) c(x,x))
a
b
c

# get differentially expressed genes
group <- rep('kidney', ncol(tpm.data.lg2))
group[grep("Liver", colnames(tpm.data.lg2))] = "liver"
group

tres = apply(tpm.data.lg2, 1, function(x) t.test(x~group))
tp <- sapply(tres, function(x) x$p.value)
td <- sapply(tres, function(x) x$estimate[2] - x$estimate[1])
names(td) <- names(tres)
logtp <- -log10(tp)
plot(x=td, y=logtp, xlab="fold change", ylab="-logP", main = "Volcano plot of kidney vs. liver")
# Threshold
p_threshold <- 0.05
fc_threshold <- 1  # log2 기준 (즉, 실제 FC가 2배 증가/감소 의미)

# Up-regulated genes (FC > 1, p-value < 0.05)
up.genes <- names(td[td > fc_threshold & tp < p_threshold])

# Down-regulated genes (FC < -1, p-value < 0.05)
dn.genes <- names(td[td < -fc_threshold & tp < p_threshold])

length(up.genes)  
length(dn.genes)

points(x=td[names(td) %in% up.genes], y =logtp[names(tp) %in% up.genes], col = "red")
points(x=td[names(td) %in% dn.genes], y =logtp[names(tp) %in% dn.genes], col = "blue")
abline(h = -log10(0.05), v=c(1, -1), col="red", lty=2)
legend("topleft", legend = c("up in liver", "up in kindney"), col=c("red", "blue"), pch=1, cex=0.8)


#Draw a plot with ggplot
install.packages("ggplot2")
library(ggplot2)
mat <- data.frame(exdata[,1:6], "logP" = logtp, "FC"=td)
mat$label <- "Nodiff"
mat$label[mat$logP > - log10(0.05) & mat$FC > 1] <- "Liver"
mat$label[mat$logP > - log10(0.05) & mat$FC < -1] <- "kidney"

ggplot(data=mat, aes(x=FC, y=logP, col=label)) + geom_point()

ggplot(data=mat, aes(x=FC, y=logP, col=label)) + geom_point() + 
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "red") +
  geom_vline(xintercept = c(-1, 1), linetyp = "dashed", color = "red") +
  scale_color_manual(values = c("blue", "red", "grey")) +
  theme_classic()

setwd("/Users/knu_cgl1/Desktop/Study/repositories/BIC0711_practice1")
pdf("volcano_kidney_liver_deg.pdf", height = 7, width = 7)
dev.off()
gp <- ggplot(data=mat, aes(x=FC, y=logP, col=label)) + geom_point() + 
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "red") +
  geom_vline(xintercept = c(-1, 1), linetyp = "dashed", color = "red") +
  scale_color_manual(values = c("blue", "red", "grey")) +
  theme_classic()
ggsave(filename = "volcano_kidney_liver_deg2.pdf",plot=gp, height = 7, width = 7, units = "in")

# Draw a boxplot
mat_sorted <- mat[order(mat$FC, decreasing = T),]
mat_sorted <- mat_sorted[mat_sorted$Status == "KNOWN", ]
top.gene <- mat_sorted$EnsemblGeneID[1]
val <- tpm.data.lg2[top.gene,]
boxplot(val~group)

group <- factor(group, levels = c("liver", "kidney"))
boxplot(val~group, col = c("red"))
boxplot(val~group, col = c("blue", "red"), xlab = "organ", ylab = "log2(TPM+1)")

# Merge (join) two data frames
mat2 <- merge(mat_sorted, expr, by.x="EnsemblGeneID", by.y = "row.names")
dim(mat_sorted)
dim(expr)
dim(mat2)

mat2 <- merge(mat_sorted, expr, by.x="EnsemblGeneID", by.y = "row.names", all = T, sort = F)
dim(mat2)

# Draw a heatmap
tpm.data.lg2.ft <- tpm.data.lg2[c(up.genes, dn.genes),]

colcol <- gsub("liver", "yellow", gsub("kidney", "green", as.vector(group)))

install.packages("gplots")
library(gplots)
heatmap.2(tpm.data.lg2.ft, Rowv = T, Colv = T, scale = "row", trace = "none", density.info = 'none', col = bluered(9), ColSideColors = colcol)


# R practice 3
setwd("/Users/knu_cgl1/Desktop/Study/repositories/BIC0711_practice1")
library(GEOquery)
gse <- getGEO("GSE25297")
pheno <- attr(attr(gse[[1]], "phenoData"), "data")
expr <- attr(gse[[1]], "assayData")[["exprs"]]
colnames(pheno)
colnames(expr) <- pheno[colnames(expr), 'title']
expr
colnames(expr)

write.table(pheno, "GSE25297_phenodata.txt", sep="\t")
write.table(expr, "GSE25297_exprsdata.txt", sep="\t")
# Get t-test p-value and mean differences
exc.smaples <- c("CNSlymphoma_rep4", "CNSlymphoma_rep5","CNSlymphoma_rep7","NormalLymphNode_rep7")
expr.ft <- expr[,!(colnames(expr) %in% exc.smaples)]
colnames(expr.ft)
pheno$title
match(colnames(expr.ft), pheno$title)

group <- pheno$type[match(colnames(expr.ft), pheno$title)]
dim(expr.ft)
dim(group)
tres <- apply(expr.ft, 1, function(x) t.test(x~group))


