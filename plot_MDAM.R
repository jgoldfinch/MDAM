#Multispecies dependent double-observer model (MDAM)
#Author: Jessie Golding
#1/28/2015

###Code for Figures for Danielle###



#####################################Figures####################################

#######################Define sp and color for graphs###########################
#Danielle - change for your actual species names 
sp<-c("1", "2", "3","4","5", "6","7","8","9","10","11","12","13","14","15","16",
      "17","18","19","20","21","22","23","24","25","26","27","28","29","30","31",
      "32","33","34","35")

colourCount = length(unique(mdam$sp))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

################################   Figure 1 - Abundance  #################################
#Figure 1.The estimated abundance per 6.25 ha site on NBR
#for thirty five avian species. Black bars represent the 95% Bayesian credible intervals 
#of the estimate. Predictions are derived from the multispecies dependent 
#double-observer abundance model using data collected on NBR in 2015.   

###########################   Format for Figure 1  ###########################
fubar.new3<-function(out){
  #Function to format abundance and credible intervals for bar graphs 

  x<-out$BUGS$sims.list
  n.sp<-dim(x$N)[3]
  n.site<-dim(x$N)[2]
  
  lowci<-highci<-n<-matrix(NA,n.site,n.sp)
  for (i in 1:n.site){
    for (j in 1:n.sp){ 
    #Mean estimated abundance
    n[i,j]<-mean(x$N[,i,j])
    
    lowci[i,j]<-quantile(x$N[,i,j],.025)
    highci[i,j]<-quantile(x$N[,i,j],.975)
    }
    }
  
  tbl<-list(n=n, lowci=lowci, highci=highci)
  tbl <- matrix(unlist(tbl), nrow=3*n.site, ncol=n.sp, byrow=T)
  rownames(tbl)<-rep(c("n","lowci","highci"),each=n.site)
  tbln<-tbl[1:60,]
  tbll<-tbl[61:120,]
  tblh<-tbl[121:180,]
  tbln<-as.vector(t(tbln))
  sp<-rep(1:35, each = 60)
  site<-rep(1:60, 35)
  tbln<-as.data.frame(cbind(site,sp, tbln))
  tbll<-as.vector(t(tbll))
  tblh<-as.vector(t(tblh))
  
  tbl<-as.data.frame(cbind(tbln,tbll,tblh))
  colnames(tbl)<-c("site","sp","n","lowci","highci")
  tbl
  
}

#Create data frame for all species (which is really too big)
ab2015<-fubar.new3(out)
max2015<-max(ab2015$highci)

abWEME2015<-ab2015[ab2015$sp==34,]
maxWEME2015<-max(abWEME2015$highci)

############################   Plot  Figure 1     ############################ 


plotbarfun.new3 <- function(x, color, maxy, title) {
  
  plots<-ggplot(data=x, aes(x=as.factor(sp), y=n, fill=as.factor(sp))) + 
    geom_bar(stat="identity", position=position_dodge())+
    scale_fill_manual(values=getPalette(color), guide=FALSE)+
    geom_errorbar(aes(ymin=lowci, ymax=highci),
                  width=.2,                    
                  position=position_dodge(.9))+
    scale_x_discrete(labels=NULL,expand=c(0,0))+
    scale_y_continuous(limits=c(0,maxy), breaks=c(0,1,2,3,4,5,6,7,8,9,10,11,12,13),expand=c(0,0))+
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
          panel.background = element_blank(), legend.key.size = unit(.6, "cm"), 
          legend.key.width = unit(.2, "cm"),
          strip.background = element_blank(),
          strip.text.y = element_blank())+ 
    ggtitle(title)+
    facet_grid(sp~site, scales = "free")+
    ylab("n")+
    xlab("")
  
  plots
}



######################   Create and save Figure 1 ############################
abar2015<-plotbarfun.new3(ab2015,colourCount, max2015,"Predicted abundance per 6.25 ha site")
abarWEME2015<-plotbarfun.new3(abWEME2015,colourCount,maxWEME2015,"WEME abundance per 6.25 ha site")

#Change file path if you want to save them somewhere on your computer
png("C:/Users/filepath/name of file.png", 
    height = 12, width = 17, units = 'cm', res = 300)
#change plot for whatever object you want to save
plot(abarWEME2015)
dev.off()

################################   Figure 2  #################################
#Figure 2.The average probability (right y axis) that an observer (x axis) 
#detected a bird (left y axis) during DDO transect surveys conducted on NBR in 2015.
#Black bars represent the 95% Bayesian credible intervals (CRI) of the estimate.

###########################   Format for Figure 2  ###########################
pnew.fun<-function(out){
  x<-out$BUGS$sims.list
  n.observers<-dim(x$p)[2]
  n.sp<-dim(x$p)[3]

  
  lowcip<-hicip<-p<-matrix(NA,n.observers,n.sp)
 
  
  for (i in 1:n.observers){
    for (j in 1:n.sp){ 
      #Mean estimated abundance
      p[i,j]<-mean(x$p[,i,j])
      
      lowcip[i,j]<-quantile(x$p[,i,j],.025)
      
      hicip[i,j]<-quantile(x$p[,i,j],.975)
      
    }
  }
  
  tbl<-list(p=p, lowcip=lowcip, hicip=hicip)
  tbl <- matrix(unlist(tbl), nrow=3*n.observers, ncol=n.sp, byrow=T)
  rownames(tbl)<-rep(c("p","lowci","highci"),each=n.observers)
  tblp<-tbl[1:6,]
  tbll<-tbl[7:12,]
  tblh<-tbl[13:18,]
  tblp2<-as.vector(tblp)
  sp<-rep(1:35, each = 6)
  obs<-rep(1:6, 35)
  tblp<-as.data.frame(cbind(obs,sp, tblp2))
  tbll<-as.vector(tbll)
  tblh<-as.vector(tblh)
  tbl<-as.data.frame(cbind(tblp,tbll,tblh))
  colnames(tbl)<-c("obs","sp","meanp","lowcip","hicip")
  tbl
}

############################   Plot  Figure 2     ############################ 

pobspfun <- function(x, color, sp, title) {
  
  n.observers<-unique(x$obs)
  
  plots<-ggplot(data=x, aes(x=obs, y=meanp, fill=as.factor(sp))) + 
    geom_bar(stat="identity", position=position_dodge())+
    geom_errorbar(aes(ymin=lowcip, ymax=hicip),
                  width=.2,                    
                  position=position_dodge(.9))+
    scale_x_continuous(breaks=c(1:max(n.observers)),labels=c("1","2","3","4","5","6"),expand=c(0,0))+
    scale_y_continuous(breaks=c(0,0.5,1),limits=c(0,1),expand=c(0,0))+
    scale_fill_manual(values=getPalette(color),guide=FALSE,
                      labels=sp)+
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
          panel.background = element_blank(), legend.key.size = unit(.6, "cm"), 
          legend.key.width = unit(.2, "cm"), panel.margin = unit(1, "lines"))+ 
    ggtitle(title)+
    xlab("Observer")+
    ylab("Avgerage detection probability")+
    facet_grid(sp ~ .)+
    theme(strip.text.x = element_text(size = 15), strip.text.y = element_text(size = 8))
  
  plots
}


######################   Create and save Figure 2 ############################
#All species and observers (again, too big)
p<-pnew.fun(out)
p$hicip<-ifelse(p$hicip>1,1,p$hicip)
ptable<- pobspfun(p, colourCount, sp, "") 

#First 10 species and all observers 
p2<-p[p$sp <10,]
p2<- pobspfun(p2, colourCount, sp, "") 

