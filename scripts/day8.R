# List
## Objects
### atomic vectors
a <- c(T, F, F, T); typeof(a)
b <- 1:4; typeof(b)
d <- c(1.5, 2.7, 3.3, 4.7); typeof(d)
e <- c("car", "bus", "train", "plane"); typeof(e)

f <- c(a,b); f; typeof(f)
g <- c(b, d); g; typeof(g)
h <- c(d, e); h; typeof(h)
g * 2
h * 2

length(a)
length(b)

aa <- matrix(a, nrow = 2); aa; typeof(aa); length(aa)
bb <- matrix(b, nrow = 2); bb; typeof(bb); length(bb)
dd <- matrix(d, nrow = 2); dd; typeof(dd); length(dd)
ee <- matrix(e, nrow = 2); ee; typeof(ee); length(ee)
b
bb
class(b)
class(bb)

#### attributes()
attributes(b)
attributes(bb)

#### attr()
z <- 1:9; z
class(z)
attr(z, "dim")
attr(z, "dim") <- c(3,3)
attributes(z)
z

attr(z, "dimnames") <-list(c("A", "B", "C"), 1:3)
attributes(z)
z


#### mode()
typeof(a); mode(a)
typeof(b); mode(b)
typeof(d); mode(d)
typeof(e); mode(e)

storage.mode(b)
storage.mode(d)
