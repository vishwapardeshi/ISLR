<<<<<<< HEAD
#remove this can we get this done
=======
#remove this this is taken care of 
>>>>>>> df39b03e4c1fb5402697543fd24734789983da99

x = rnorm(100)
y = rnorm(100)
plot(x,y)
x = seq(1:10)
y = x
f = outer(x, y, function(x,y) cos(y)/(1 + x ^ 2))
contour(x,y,f)
contour(x,y,f,nlevels=45,add=T)
fa=(f-t(f))/2
contour(x,y,fa,nlevels=15)
library(ISLR)
Auto
plot(Auto$cylinders, Auto$mpg, col="red", varwidth=T, xlab="cylinders",horizontal=T)
Auto$cylinders <- as.factor(Auto$cylinders)
pairs(~mpg + displacement + horsepower + weight + acceleration , Auto)
plot(Auto$horsepower, Auto$mpg)
identify(Auto$horsepower,Auto$mpg,Auto$name)

summary(college)
pairs(college[,1:10])
college$Private <- as.factor(college$Private)
plot(college$Private,college$Outstate)

Elite = rep("No", nrow(college))
Elite[college$Top10perc>50] = "Yes"
Elite = as.factor(Elite)
college = data.frame(college, Elite)

summary(college)
plot(college$Elite, college$Outstate)

#divide screeninto four area
par(mfrow= c(2,2))
hist(college$Apps)
hist(college$Accept, col = 2)
hist(college$Enroll)
hist(college$PhD)
hist(college$Apps)
hist(college$perc.alumni, col=2) #col is color bro
hist(college$S.F.Ratio, col=3, breaks=10)
hist(college$Expend, breaks=100)
na.omit(Auto)
str(Auto)
as.factor(Auto$origin)
sapply(Auto[,1:7], range)

sapply(Auto[,1:7], mean)
sapply(Auto[,1:7], sd)

newAuto <- Auto[-(10:85)]
sapply(Auto[,1:7], range)
sapply(Auto[,1:7], mean)
sapply(Auto[,1:7], sd)

library(MASS)
?Boston
dim(Boston)
# 506 rows, 14 columns
# 14 features, 506 housing values in Boston suburbs


# (b)
pairs(Boston)
# X correlates with: a, b, c
# crim: age, dis, rad, tax, ptratio
# zn: indus, nox, age, lstat
# indus: age, dis
# nox: age, dis
# dis: lstat
# lstat: medv

# (c)
plot(Boston$age, Boston$crim)
# Older homes, more crime
plot(Boston$dis, Boston$crim)
# Closer to work-area, more crime
plot(Boston$rad, Boston$crim)
# Higher index of accessibility to radial highways, more crime
plot(Boston$tax, Boston$crim)
# Higher tax rate, more crime
plot(Boston$ptratio, Boston$crim)
# Higher pupil:teacher ratio, more crime

# (d)
par(mfrow=c(1,3))
hist(Boston$crim[Boston$crim>1], breaks=25)
# most cities have low crime rates, but there is a long tail: 18 suburbs appear
# to have a crime rate > 20, reaching to above 80
hist(Boston$tax, breaks=25)
# there is a large divide between suburbs with low tax rates and a peak at 660-680
hist(Boston$ptratio, breaks=25)
# a skew towards high ratios, but no p

# (e)
dim(subset(Boston, chas == 1))
# 35 suburbs

# (f)
median(Boston$ptratio)
# 19.05

# (g)
t(subset(Boston, medv == min(Boston$medv)))
#              399      406
summary(Boston)
# Not the best place to live, but certainly not the worst.

# (h)
dim(subset(Boston, rm > 7))
# 64
dim(subset(Boston, rm > 8))
# 13
summary(subset(Boston, rm > 8))
summary(Boston)
# relatively lower crime (comparing range), lower lstat (comparing range)
