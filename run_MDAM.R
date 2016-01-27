#Multispecies dependent double-observer model 
#Author: Jessie Golding
#1/26/2016

### MDAM ###

#Code forrunning the simplest model for Danielle's NBR pilot season data 
#Only the top 4 most abundant species used

sink("nbr_mdam_model.txt")
cat("
    model{

    #  Priors
    #  Linear predictor on abundance, setup for species variation only,
    #  abundance assumed the same at every site
    for(i in 1:n.sp){
    log.n[i] ~ dnorm(0, 0.001)
    mu.lambda[i] <- exp(log.n[i])
    }

    #  Individual observer detection probability
    for(i in 1:n.observers){
    for (j in 1:n.sp){ 
    p[i,j] ~ dnorm(0, 0.001)
    }
    }


    #  Site abundance
    for(i in 1:n.sites){
    for(j in 1:n.sp){

    N[i,j] ~ dpois(mu.lambda[j])
    }
    }
    
    
    #  Primary likelihood
    for(i in 1:n.obs){
    #  Indices always follow site, reps, species order
    #  Capture probabilities
    #  Seen by observer #1
    cp[i,1] <- p[prim[i],sp[i]]
    #  Seen by observer #2 and not seen by observer #1
    cp[i,2] <- p[sec[i],sp[i]] * (1 - p[prim[i],sp[i]])
    #  Seen by somebody
    pcap[i] <- 1-((1-cp[i,1])*(1-cp[i,2]))
    #  Not seen by either observer
    pnocap[i] <- 1 - pcap[i]
    #  Realizations
    #  Number captured (ncap) and population size (N)
    ncap[i] ~ dbin(pcap[i], round(N[site[i],sp[i]]))
    #  Detection probabilities
    y[i,] ~ dmulti(cp[i,1:2], ncap[i])
    }
    
    }
    ", fill = T)
sink()
################################################################################
# Data
jags.dat <- list("y" = mdam[,5:6],
                 "prim" = mdam$prim,
                 "sec" = mdam$sec,
                 "n.obs" = nrow(mdam),
                 "n.observers" = length(unique(mdam$prim)),
                 "n.sites" = length(unique(mdam$site)),
                 "site" = mdam$site,
                 "n.sp" = length(unique(mdam$sp)),
                 "sp" = mdam$sp,
                 "ncap" = mdam$ncap)

#  Monitor parameters

pars <- c("N","p")

#  Initial value
n.sites<-length(unique(mdam$site))
n.sp<-length(unique(mdam$sp))
Nst <-matrix(NA, n.sites, n.sp)
lambda <-25
for (i in 1:n.sites){
  Nst[i,]<-rpois(n.sp, lambda)
}

n.observers<-length(unique(mdam$prim))
p <-matrix(NA, n.observers, n.sp)
p<-runif(n.observers)
p<-cbind(p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p)
pst<-matrix(p, ncol = ncol(p), dimnames = NULL)

init.vals <-function(){list(
  N = Nst, p = pst)}

#  Callp=
out <- jags(jags.dat,
            init.vals,
            pars,
            "nbr_mdam_model.txt",
            n.chains = 3,
            15000,
            1000,
            1)
