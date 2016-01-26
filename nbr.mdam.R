mdam<-read.csv("mdamdata.csv")
mdam<-subset(mdam, mdam$sp==10|mdam$sp==19|mdam$sp==32|mdam$sp==34)

mdam$sp<-ifelse(mdam$sp==10, 1, ifelse(mdam$sp==19,2, ifelse(mdam$sp==32,3, ifelse(mdam$sp==34, 4, 0))))


