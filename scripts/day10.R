# List
## list add and list change
a <- list(name="Fred", age=43, wife="Mary", 
          no.children= 3, child.ages=c(4, 7, 9), 
          is.house.owner=T)
length(a)
a[[7]] <- 1:5
a[["address"]] <- "Cheonan"
a$years.since.marrage <- 15
a
length(a)

a[[7]] <- 10:18
a$address <- "Daejeon"
a[[9]] <- 16
a

a2 <- list(1:5, letters[1:8], LETTERS[1:3])
a2
a2[[5]] <- "New items" ;a2

a2[[5]] <- NULL; a2
a2[[4]] <- NULL; a2
names(a2) <- c("num", "lower.case", "upper.case"); a2
a2$num <- NULL; a2


a2[3:4] <- list(1:5, month.name); a2

a2[3:6] <- list(11:15, month.abb); a2


a2[3:6] <- c("X", "Y", "Z", "W"); a2
c("X", "Y", "Z", "W")
as.list(c("X", "Y", "Z", "W"))
a2[3:6] <- NULL; a2


a3 <- list(first=1:3, second=4:6); a3
a4 <- c(a2, a3); a4
length(a4)

a5 = list(a2, a3); a5
length(a5)
a4[[2]]
a5[[2]]
a5[[1]][[2]]
a5[[2]]$second
c(a4, a5)
c(a4, a5, recursive = TRUE)


unlist(a3)
unlist(a4)

a = c("R is a specialized programming language for statistical analysis.", "A variety of data analysis functions are built-in.")
b = strsplit(a, split = " "); b
