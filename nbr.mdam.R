#Multispecies dependent double-observer model 
#Author: Jessie Golding
#1/26/2016

#Code to format NBR pilot year data for MDAM

#Read in data
mdam<-read.csv("mdamdata.csv")


#Make sure that each site/rep/year combo has an entry for each 
#species (even if it's a 0)
#Use expand.grid to do this 
#Create unique values for the expand.grid function
year <-unique(mdam$year)
plot <-unique(mdam$site)
reps <-unique(mdam$reps)
sp <-unique(mdam$sp)

#Use expand.grid to create the new data frame and create placeholder columns
newdf<-expand.grid(year=year, site=plot, sp=sp, reps= reps)
newdf$y1<-0
newdf$y2<-0
newdf$prim <-0
newdf$sec <-0
newdf$ncap <-0

#Rbind (so much better than merge) - just have to make sure colnames are the same
newdf2<-as.data.frame(rbind(mdam, newdf))


#Add in observer info for each unique year, plot, rep (ypr) combo
ypr<-function(x){
  tmp<-x[x$prim !=0 & x$sec !=0,] 
  tmp<-unique(tmp[c("year", "site", "reps", "prim", "sec")])
  tmp
  
}

uni<-ypr(newdf2)
uni2<-uni[apply(uni[c(4:5)],1,function(z) any(z!=0)),]


newdf3<-merge(newdf2,uni2,by=c("year","site","reps"),all=T)
newdf3[is.na(newdf3)] <- 0
newdf3<-newdf3[newdf3$prim.y !=0 & newdf3$sec.y !=0,]
newdf3$prim.x<-NULL
newdf3$sec.x<-NULL
colnames(newdf3)<-c("year","site","reps","sp","y1","y2","ncap","prim","sec")


newdf4 <- newdf3 %>% 
  group_by(year, site, reps, sp) %>% 
  summarise(y1 = sum(y1), 
            y2 = sum(y2),
            prim = max(prim, na.rm=T), 
            sec = max(sec, na.rm=T))


#Add ncap column
newdf4$ncap <-newdf4$y1+newdf4$y2

mdam <-as.data.frame(newdf4)
