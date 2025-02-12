# day 2.
## Get character length of a string
### nchar() : To get the number of characters in a text
a <- 'I love R'
length(a)
nchar(a)

## Sunstring
a[1]
substring(a, 1,1)
substring(a, 3,6)

## String formatting
### sprintf() : returns a character vector containing a formatted combination of text and variable values.
sprintf('I need to study Python%d', 2)
sprintf('I need to study Python%f', 2.7)
sprintf('I need to study Python%s', 2.7)
sprintf('I need to study Python%.1f', 2.7)
sprintf('humans share about %s%% of DNA with chimpanzees', 99)

## String formatting
lang = 'Python'
ver = '2.7'
paste('I need to study ', lang, ver, sep = '')
sprintf('I need to study %s%s', lang, ver)
sprintf('I need to study %s%.2f', lang, as.numeric(ver))

# Quiz
circ = 'pi'
pi
sprintf("The ratio of a circle's circumference to its diameter is called %s, and the value of %s is %.2f", circ, circ, pi)


# R data structure
# Vector : A vector is a sequence of data elements of the same basic type.
## Creating a vectpr