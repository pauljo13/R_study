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
head(tres)

tp <- sapply(tres, function(x) x$p.value)
td <- sapply(tres, function(x) x$estimate[2] - x$estimate[1])

df <- data.frame("ID"=names(tres), "P"=tp, "FC"=td)
df.sorted <- df[order(df$FC, decreasing = T),]
top.gene <- df.sorted$ID[1]
val <- as.matrix(expr.ft)[top.gene,]

# aggregate : splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form.
val.avg <- aggregate(val, by=list(group), mean)
val.sd <- aggregate(val, by=list(group), sd)

df2 <- data.frame(val.avg, val.sd[,-1])
colnames(df2) <- c("Group", "avg", "sd")

# Barplot with error bars
library(ggplot2)

ggplot(df2, aes(x=Group, y=avg, fill=Group)) + geom_bar(stat="identity") + geom_errorbar(aes(ymin=avg-sd, ymax=avg+sd), width = .2) +
  scale_fill_manual(values = c("grey","darkred"))


df3 <- data.frame("Sample"=colnames(expr.ft), "Group"=group, "Expr"=val)
df4 <- df3 %>% group_by(Group) %>% summarise(avg=mean(Expr), sd = sd(Expr))
ggplot(df4, aes(x=Group, y=avg, fill=Group)) + geom_bar(stat="identity") +
  geom_errorbar(aes(ymin=avg-sd, ymax=avg+sd), width=.2) +
  scale_fill_manual(values=c("grey","darkred"))

library(ggpubr)
df3$Group = factor(df3$Group, levels = c("Normal", "PCNSL"))
ggbarplot(df3, x="Group", y="Expr",
          add =c('mean_sd'),
          fill="Group",
          palette = c("grey","darkred"))

# matrix transpose
top.gene.list <- df.sorted$ID[1:5]
mat <- as.matrix(expr.ft)[top.gene.list,]
mat2 <- t(mat)
mat2

#Melting data frame
install.packages("reshape2")
library(reshape2)

df5 <- melt(mat2)
df5 <- melt(mat2, varnames = c("Sample", "probe"), value.name = "Expr")
df5$Group <- pheno$Type[match(df5$Sample, pheno$title)]
df5

# Barplot for multiple genes
df6 <- df5 %>% 
  group_by(probe, Group) %>%  
  summarize(avg = mean(Expr), sd = sd(Expr), .groups = "drop")
df6
ggplot(df6, aes(x=probe, y=avg, fill=Group)) + geom_bar(stat="identity")
ggplot(df6, aes(x=probe, y=avg, fill=Group)) + geom_bar(stat="identity",position=position_dodge())
ggplot(df6, aes(x=probe, y=avg, fill=Group)) + geom_bar(stat="identity", position=position_dodge()) +
  geom_errorbar(aes(ymin=avg-sd, ymax=avg+sd), width=0.2, position = position_dodge(width=0.9)) +
  scale_fill_manual(values=c("grey","darkred"))
ggbarplot(df5, x = "probe", y = "Expr", fill = "Group",
          add = "mean_sd", palette = c("#00AFBB", "#E7B800"),
          position = position_dodge(width=0.9)) +
  stat_compare_means(aes(group = Group), label = "p.signif")

#Quiz