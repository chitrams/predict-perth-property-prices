# Figuring out how lists work
# And how to extract elements from a list

x <- list(1:3, "a", 1:5)
y <- list("b", TRUE, 5:10)

alist <- list(x, y)

# Returns a list
a <- alist[[2]][3]

# Returns an object
b <- alist[[2]][[3]]
pluck(alist, 2, 3)

# Take the object 
x[[3]]

# This should get b
alist[[2]][[1]]
pluck(alist, 2, 1)

# This should get 5
alist[[1]][[3]][[5]]
pluck(alist, 1, 3, 5)

pluck_depth(alist)
