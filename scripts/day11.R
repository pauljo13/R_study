# day 11
## lapply()
b <- list(1:5, 21:29, seq(2, 20, by=2)); b
mean(b[[1]])
mean(b[[3]])
lapply(b, mean)
lapply(b, mean)[[1]]
lapply(b, mean)[[3]]

lapply(b, max)
names(b) <- c("A", "B", "C")
lapply(b, range)

## sapply()
sapply(b, length)
sapply(b, range)
lb <- lapply(b, length)
typeof(lb)
sb <- sapply(b, length)
typeof(sb)

sapply(b, function(x){
  sum(x > 10)
})

## mapply()
a <- list(1:5, 10:5, letters[1:4])
b <- list(6:4, 4:7, LETTERS[5:1])
mapply(c, a, b)
a
b

mapply(rep, times=2:4, x=list(1:2, 11:12, 21:22))

# list
## lm
x <- lm(dist~speed, data = cars); x
typeof(x)
class(x)
names(x)
x$residuals
x$terms

## unclass()
unclass(x)

## data frame
head(cars)
typeof(cars)
class(cars)
unclass(cars)

y <- list(a = 11:15, b = letters[11:15]); y
typeof(y); class(y)
z <- as.data.frame(y); z
typeof(z); class(z)



#6 Data frame
## Categorical Data
results <- c(1,3,2,4,3,2,1,3,2,2); results
results[1] <- 5; results
mean(results)

results
attributes(results)
fResults <- factor(results, levels = 1:4); fResults
attributes(fResults)

results[1] <- 1
fResults <- factor(results, levels=1:4); fResults
fResults[12] <- 5
fResults

fResults[12] <- 2; fResults
fResults[11] <- 4; fResults
mean(fResults)

levels(fResults)
levels(fResults) <- c("A", "B", "C", "None")
fResults

typeof(fResults)
class(fResults)
unclass(fResults)

levels(fResults)
fResults[11] <- 4

fResults[12] <- "None"; fResults


## Ordinal Data
satisfaction <- c("매우 불만", "매우 만족", "불만", "만족", "보통","불만", "매우 불만", "보통", "매우 만족", "불만")
fsatisfaction <- factor(satisfaction,
                        levels = c("매우 불만", "불만", "보통", "만족", "매우 만족"))
fsatisfaction
fsatisfaction >= "만족"

oSatisfaction <- factor(satisfaction, ordered = TRUE,
                        levels = c("매우 불만", "불만", "보통", "만족", "매우 만족")); oSatisfaction
oSatisfaction >= "만족"
sum(oSatisfaction >= "만족")
mean(oSatisfaction >= "만족")
order(oSatisfaction)

oSatisfaction <- factor(satisfaction, ordered = TRUE,
                        levels=c("매우 만족", "만족", "보통", "불만", "매우 불만"))
oSatisfaction
oSatisfaction >= "만족"
sum(oSatisfaction >= "만족")
mean(oSatisfaction >= "만족")
order(oSatisfaction)


a <- c("F", "M", "F", "M", "F")
fa1 <- factor(a); fa1
unclass(fa1)
table(fa1)
fa2 <- factor(a, levels = c("M", "F"))
fa2
unclass(fa2)
table(fa2)

fResults
fResults2 <- relevel(fResults, ref = "None"); fResults2
table(fResults2)

head(InsectSprays)
InsectSprays$spray
boxplot(count ~ spray, data = InsectSprays)
boxplot(count ~ reorder(spray, count, median), data=InsectSprays)
unclass(InsectSprays)

fa3 <- factor(a, levels = c("M", "F"), labels = c("Male", "Female")); fa3
unclass(fa3)
table(fa3)
fa3[6] <- "M"
fa3[6] <- "Male"
fa3
