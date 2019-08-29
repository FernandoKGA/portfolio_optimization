install.packages("tidyverse")
install.packages("Hmisc") 
install.packages("readxl")
install.packages("igraph")
install.packages("fBasics")
install.packages("xtable")
install.packages("reshape")
install.packages("PerformanceAnalytics")

library(tidyverse)
library(readxl)
library(PerformanceAnalytics)
library(Hmisc)
library(readxl)
library(igraph)
library(fBasics)
library(ggplot2)
library(gridExtra)
library(reshape)

#Tidying Data Data from january-1995 to July-2019
acoes1 <- read_excel("economatica_acoes.xlsx")    #Load Data for getting dates and variable names

date <- acoes1[,1]        #Removes excess lines and columns in the data                        
date <- date[-1,]        
date <- date[-1,]
date <- date[-1,]
colnames(date) <- "Date"



acoes1 <- acoes1[-1,]            #Removes excess lines and columns in the data 
acoes1 <- acoes1[-1,]
colnames(acoes1) <- acoes1[1,]   
acoes1 <- acoes1[-1,-1]
acoes1 <- acoes1[,-1]
nomes <- colnames(acoes1)    #Get the names of the variables

nomes <- str_remove_all(nomes, 
                        fixed("Fechamento\najust p/ prov\nEm moeda orig\n"))    #Clean and set small names for the variables
colnames(acoes1)<-nomes       #Set the new names in the data frame, however this data frame is in character 

acoes <- read_excel("economatica_acoes.xlsx",col_types=c(rep("numeric",545)), col_names=T)  #Reload data as double
acoes <- acoes[-1,]
acoes <- acoes[-1,]
colnames(acoes) <- acoes[1,]
acoes <- acoes[-1,-1]
acoes <- acoes[,-1]
colnames(acoes)<-nomes     #Set the names of the variable in this data frame of double variables

"Choosing Liuidity for the data set"
 
L=0.8   #Set the percentual of liquidity here

liquidi <- data.frame()       #Calculates the liquidity as the numer of lines ominting the NAs divided by total number of lines 
for (j in 1:ncol(acoes)) {    #Create the data frame liquidi with numeric results
  liquidi[1,j]<- (nrow(na.omit(acoes[,j])))/(nrow(acoes[,j]))
  }

colnames(liquidi) <- names(acoes)   
liquidity <- liquidi[,liquidi>=L]  #Use the condition to select the lines larger than L (80% of liquidity if L=0.8)

selection <- acoes[2348:8743,names(liquidity)]   #Use the names of the selected variables as conditoin for selecting the variable in the tidy data set

write.csv(selection, file = "selection_80_1986.csv") #Save the file

#Returns - Log returns
retorno_bruto <- data.frame()
for (i in 1:nrow(selection)) {
  for (j in 1:ncol(selection)) {
    retorno_bruto[i,j] <- log(selection[i+1,j])-log(selection[i,j])
  }
}

retorno_bruto[is.na(retorno_bruto)] <- 0               #All NA transformed into 0s


#Risk Free Return
CDI <- read_excel("c:/Users/Gerson/OneDrive - usp.br/Pesquisa/USP/CDI.xls")      #From Oct-03-2012 to sep-29-2016
CDI <- CDI[,-1]

for (i in 1:nrow(CDI)) {
  if(CDI[i,1]<1){
    CDI[i,1] <-CDI[i,1]*10        #Correct some values in CDI Data Set that were wrongly set in the original data
  }
}
logCDI <- log(CDI)



#Excess Return

Ex_returna <- data.frame()
for (i in 1:nrow(retorno_bruto)) {
  for (j in 1:ncol(retorno_bruto)) {
    Ex_returna[i,j] <- na.omit(retorno_bruto[i,j]-logCDI[i+1,1])
  }
}



#Normalized Log Returns by p days 


p=30    #setting p periods normalization

nor <- function(data,p,k=1:p){
  norma <- data[i+p-1,j]/sum(rep(abs(data[i+p-k])),p)
}

Ret_Norm <- data.frame()
for (i in 1:nrow(Ex_returna)) {
  for (j in 1:ncol(Ex_returna)) {
    Ret_Norm[i,j] <- na.omit(Ex_returna[i+p-1,j]/sum(abs(Ex_returna[i+p-1,j])/p,
                                             abs(Ex_returna[i+p-2,j])/p,
                                             abs(Ex_returna[i+p-3,j])/p,
                                             abs(Ex_returna[i+p-4,j])/p,
                                             abs(Ex_returna[i+p-5,j])/p,
                                             abs(Ex_returna[i+p-6,j])/p,
                                             abs(Ex_returna[i+p-7,j])/p,
                                             abs(Ex_returna[i+p-8,j])/p,
                                             abs(Ex_returna[i+p-9,j])/p,
                                             abs(Ex_returna[i+p-10,j])/p,
                                             abs(Ex_returna[i+p-11,j])/p,
                                             abs(Ex_returna[i+p-12,j])/p,
                                             abs(Ex_returna[i+p-13,j])/p,
                                             abs(Ex_returna[i+p-15,j])/p,
                                             abs(Ex_returna[i+p-16,j])/p,
                                             abs(Ex_returna[i+p-17,j])/p,
                                             abs(Ex_returna[i+p-18,j])/p,
                                             abs(Ex_returna[i+p-19,j])/p,
                                             abs(Ex_returna[i+p-20,j])/p,
                                             abs(Ex_returna[i+p-21,j])/p,
                                             abs(Ex_returna[i+p-22,j])/p,
                                             abs(Ex_returna[i+p-23,j])/p,
                                             abs(Ex_returna[i+p-24,j])/p,
                                             abs(Ex_returna[i+p-25,j])/p,
                                             abs(Ex_returna[i+p-26,j])/p,
                                             abs(Ex_returna[i+p-27,j])/p,
                                             abs(Ex_returna[i+p-28,j])/p,
                                             abs(Ex_returna[i+p-29,j])/p,
                                             abs(Ex_returna[i+p-30,j])/p))
    
  }
}

colnames(Ret_Norm) <- names(selection)

Ret_Norm[is.na(Ret_Norm)] <- 0

retornos <- Ret_Norm[1:(nrow(selection)-p),1:ncol(selection)]

#retornos <- Ex_returna


#Creating a Moving Average Function (maf)
maf <- function(data,lag){
  
  maf2 <- data.frame()
  for (i in 1:nrow(data)) {
    for (j in 1:ncol(data)) {
      maf2[i,j] <-sum(data[(0+i):((lag-1)+i),j])/lag
    }
  }
  return(maf2)
}

#Creating a Return of the Moments (rom) function according to long and short strategy by intensity
rom <- function(data,lag){
  maf <- function(data,lag){
    maf2 <- data.frame()
    for (i in 1:nrow(data)) {
      for (j in 1:ncol(data)) {
        maf2[i,j] <-sum(data[(i+0):((lag-1)+i+0),j])/lag
      }
    }
    return(maf2)
  }
  
  MA <- data.frame(na.omit(maf(data,lag)))
  rome_i <- data.frame()
  for (i in 1:nrow(MA)) {
    for (j in 1:ncol(MA)) {
      rome_i[i,j] <- MA[i,j]*data[i+2,j]                         
    }
  }
  return(rome_i)
}

#Creating a list with multiple matrices, one for each lag
lags <- c(1:260)
rom_lag <- list()
for (i in 1:260) {
  rom_lag[[i]] <- rom(retornos,lags[[i]])
}


#Means of Returns of the Moments by lag by intensity
means_i_i <- data.frame()
for (i in 1:260) {
  for (j in 1:ncol(retornos)) {
    means_i_i[i,j] <- mean(rom_lag[[i]][1:nrow(rom_lag[[i]]),j])
  }
}

means_j_i <- as.data.frame(t(means_i_i))
means2 <- cbind(c(1:260),as.data.frame(sapply(means_j_i, mean)))
colnames(means2) <- c("Lag", "Means")

#Returns of the Moments Volatility 
ret_i <- data.frame()
sd <- data.frame()
for (j in 1:260) {
  a <- melt(na.omit(data.frame(rom_lag[[j]])))            #Join all data in two columns: one for numeric and other for variabales
  ret_i[1:nrow(a),j] <- na.omit(a[,2])            #Get the column of numeric data
  sd[1,j] <- sd(na.omit(ret_i[1:nrow(ret_i),j]))  #Calculates the standard deviation for each lag omitting NAs
}


sd_i_i <- data.frame()
for (i in 1:260) {
  for (j in 1:ncol(retornos)) {
    sd_i_i[i,j] <- sd(na.omit(rom_lag[[i]][1:nrow(rom_lag[[i]]),j]))
  }
}

colnames(sd_i_i) <- names(selection)

#sd_j_i <- as.data.frame(t(sd_i_i))
#sd2 <- cbind(c(1:260),as.data.frame(sapply(sd_j_i, sd)))
#colnames(sd2) <- c("Lag", "Standard_Deviation")



#Sharpe Ratio-SR


sharpe <- function(Ri){                #Creating a Function for Sharpe Ratio
  (abs((mean(Ri))))/(sd(Ri))
}

#Matrix of SR for each lag 

sr_i <- data.frame()
sr <- data.frame()
for (j in 1:260) {
  a <- melt(data.frame(rom_lag[[j]]))            #Join all data in two columns: one for numeric and other for variabales
  sr_i[1:nrow(a),j] <- a[,2]                    #Get the column of numeric data
  sr[1,j] <- sharpe(na.omit(ret_i[1:nrow(ret_i),j]))  #Calculates the standard deviation for each lag omitting NAs
}


 sharpe_i <- data.frame()
for (i in 1:260) {
for (j in 1:ncol(retornos)) {
 sharpe_i[i,j] <- sharpe(na.omit(rom_lag[[i]][1:nrow(rom_lag[[i]]),j]))
}
}
 colnames(sharpe_i) <- names(selection)
 
# #Data frame of the Sharp Ratios Means of Each Lag
# sharpe_i <- as.data.frame(t(sharpe_i))
# sharpe2 <- cbind(c(1:260),as.data.frame(sapply(sharpe_i, mean)))
# colnames(means2) <- c("Lag", "Means")


#
#SR <- data.frame()                        #A matrix with all SR of main returns
#for (j in 1:ncol(retornos)) {
#   SR[1:1042,j] <- sharpe(retornos[[j]])
#   }



#Plotting


#1-Return of the Moments- Portfolio Mean by Lag
#par(bg = 'black', fg = 'white',    col.axis = "white",  col.grid = "white")
plot(means2,type="b",  main="Excess Normalized Returns of the Moments - Portfolio Mean by Lag", ylab="Return", xlab="Lag", col="Blue")
grid(col = "gray", lty = "dotted")
marks <- c(2)
axis(2,at=marks,labels=format(marks,scientific=F),cex.axis=0.5)

#2- Sharpe Ratio of the Moments  - Portfolio Mean by Lag
#par(bg = 'black', fg = 'white',    col.axis = "white")
plot(t(sr[,3:260]), type="o", main="Sharpe Ratio of the Moments  - Portfolio Mean by Lag", ylab="SR", xlab="Lag", col="Green")
grid(col = "gray", lty = "dotted")


#3-Return of the Moments Volatility - Portfolio Standard Deviation by Lag
#par(bg = 'black', fg = 'white',    col.axis = "white",  col.grid = "white")
plot(t(sd),type="o",  main="Return of the Moments Volatility- Portfolio Mean by Lag", ylab="SD", xlab="Lag", col="red")
grid(col = "gray", lty = "dotted")
marks <- c(2)
axis(2,at=marks,labels=format(marks,scientific=FALSE),cex.axis=1.5)

################################################################ ATE AQUI ###################################################################
#Abaixo nao sera usado

#Building Lists for Correlation Matrices for Each Lag
correlations <- list()
for (i in 1:length(rom_lag)) {
  correlations[[i]] <- rcorr(as.matrix(rom_lag[[i]]), type="pearson")  #Calculates correlation matrix for each lag and stores it in a list
}

dist_correlations <- list()
for (i in 1:length(rom_lag)) {
  dist_correlations[[i]] <- sqrt((1-correlations[[i]]$r))                #Calculates distance correlation matrix list (Gower,1966) for each lag an stores it in a list
}


#Building a list of Networks: One Correlation Minimum Spannig Tree for Each Lag
links_list <- list()
mst_list <- list()
MST_list <- list()

for (i in 1:length(rom_lag)) {
  links_list[[i]]<-as.data.frame(as.table(dist_correlations[[i]]))  #A list of data frames of Links by lag 
}

nodes<-links_list[[1]][1:ncol(retornos),1]

for (i in 1:length(rom_lag)) {
  colnames(links_list[[i]]) <- c("from","to","weight")  #Changing the colmns names
}



for (i in 1:length(rom_lag)) {
  mst_list[[i]]<-mst(graph_from_data_frame(d=links_list[[i]],
                                           vertices=nodes, 
                                           directed=F))                    #A list of Minimum Spanning Tree by using Prim algorithm by lag
}

for (i in 1:length(rom_lag)) {
  MST_list[[i]]<-as_data_frame(mst_list[[i]])                     #A list of tables that transformed MST into a data frame with 3 columns
}

for (i in 1:length(rom_lag)) {
  a <- c(1:length(rom_lag))
  write_graph(mst_list[[i]], 
              file = paste0( "c",":","/","Gerson","/","Rede",a[i],".","net"),
              format = c("pajek"))                                #Save each MST network as Pajek file
  
}

#Network`s Centralizations


# 1.Degree Centralization
deg <- data.frame()
degr <- list()
for (i in 1:length(rom_lag)) {
  
  degr[[i]] <- centr_degree(mst_list[[i]], mode="all", normalized = T)         
  deg[i,1] <-degr[[i]]$centralization 
}


# 2.Closeness Centralization
clo <- data.frame()
clos <- list()
for (i in 1:length(rom_lag)) {
  
  clos[[i]] <- centr_clo(mst_list[[i]], mode="all", normalized = T)         
  clo[i,1] <-clos[[i]]$centralization 
  
}

# 3.Eigen Vector Centralization
eig <- data.frame()
eige <- list()
for (i in 1:length(rom_lag)) {
  
  eige[[i]] <- centr_eigen(mst_list[[i]], 
                           normalized = T)         
  eig[i,1] <-eige[[i]]$centralization 
  
}

# 4.Betweenes Centralization
bet <- data.frame()
betw <- list()
for (i in 1:length(rom_lag)) {
  
  betw[[i]] <- centr_betw(mst_list[[i]], 
                          normalized = T)         
  bet[i,1] <-betw[[i]]$centralization 
  
}

# #Saving Network Stats
# 
# statistics <- list()
# for (i in 1:length(rom_lag)) {
#   statistics[[i]]=data.frame(as.table(c(degree=degr[[i]]$centralization, 
#                                       closeness=clos[[i]]$centralization, 
#                                       eigenvector=eige[[i]]$centralization, 
#                                       betweenness=betw[[i]]$centralization))) #Creates a list with all stats for all lags
#    
# }                  
# 
# for (i in 1:length(rom_lag)) {                 #Writes de csv files 
#   a <- c(1:length(rom_lag))
#   write.csv(statistics[[i]], 
#               file = paste0( "c",":","/","Gerson","/","Stats",a[i],".","csv"))
#}



#Plotting Nets Stats


net1 <- cbind(c(1:260),as.data.frame(deg$V1))
colnames(net1) <- c("Lag", "Degree")

net2 <- cbind(c(1:260),as.data.frame(clo$V1))
colnames(net2) <- c("Lag", "Closeness")

net3 <- cbind(c(1:260),as.data.frame(eig$V1))
colnames(net3) <- c("Lag", "Eigen_Vector")

net4 <- cbind(c(1:260),as.data.frame(bet$V1))
colnames(net4) <- c("Lag", "Betweenes")


par(bg = 'white', fg = 'black', col.axis = "black")
#1 - Degree Centralization
plot(net1, type="o", main="Degree Centralization by Lag",ylab = "Centralization", xlab="Lag", col="darkOrange")
grid(col = "gray", lty = "dotted")
marks <- c(2)
axis(2,at=marks,labels=format(marks,scientific=FALSE),cex.axis=0.8)

#2 -Closeness Centralization by Lag
plot(net2,type="o",  main="Closeness Centralization", ylab="Centralization", xlab="Lag", col="brown")
grid(col = "gray", lty = "dotted")
marks <- c(2)
axis(2,at=marks,labels=format(marks,scientific=FALSE),cex.axis=0.5)

#3- Eigen Vector Centralization by Lag
plot(net3,type="o",  main="Eigen Vector Centralization", ylab="Centralization", xlab="Lag", col="blue")
grid(col = "gray", lty = "dotted")
marks <- c(2)
axis(2,at=marks,labels=format(marks,scientific=FALSE),cex.axis=0.5)

#4-Betweenes Centralization by Lag
#par(bg = 'black', fg = 'white',    col.axis = "white",  col.grid = "white")
plot(net4,type="o",  main="Betweenes Centralization by Lag", ylab="Centralization", xlab="Lag", col="purple")
grid(col = "gray", lty = "dotted")
marks <- c(2)
axis(2,at=marks,labels=format(marks,scientific=FALSE),cex.axis=0.5)



#Tabble of Results
options(digits = 15)
Results <- data.frame(cbind(means2$Means,
                            t(sd), 
                            t(sr),
                            deg$V1, 
                            clo$V1,
                            bet$V1))
colnames(Results) <- c("Mean_Excess_Return","Volatility","SR","Degree","Closeness","Betweenness")

#Correlations

#cor(Results)
#cor(Results, use = "everything",method = c("spearman"))
#rcorr(as.matrix(Results),type=c("pearson"))

cor <- rcorr(as.matrix(na.omit(Results)),type=c("pearson")) #Creates a list for Results of Spearman Correlations coefficents and tests
#levelplot(cor$r)                                    #Heatmap for correlations
levelplot(cor$r,  col.regions = heat.colors(100))
chart.Correlation(cor$r, histogram=TRUE, pch=19)
#formatC(Results$Mean_Excess_Return,digits = 15)    # 15 digists Results
write.csv(Results, file = "Results.csv")            #Saving Results

sharp <- mutate(sharpe_i,Lags=c(1:nrow(sharpe_i)))

require("colorspace")
hcl_palettes(plot = TRUE)
q27 <- diverging_hcl(27, "Berlin")

ggplot(sharp, aes(x = Lags)) +
  geom_line(aes(y = sharp[,1]), colour=q27[1])+
  geom_line(aes(y = sharp[,2]), colour=q27[2])+
  geom_line(aes(y = sharp[,3]), colour=q27[3])+
  geom_line(aes(y = sharp[,4]), colour=q27[4])+
  geom_line(aes(y = sharp[,5]), colour=q27[5])+
  geom_line(aes(y = sharp[,6]), colour=q27[6])+
  #geom_line(aes(y = sharp[,7]), colour=q27[7])+
  geom_line(aes(y = sharp[,8]), colour=q27[8])+
  geom_line(aes(y = sharp[,9]), colour=q27[9])+
  geom_line(aes(y = sharp[,10]), colour=q27[10])+
  geom_line(aes(y = sharp[,11]), colour=q27[11])+
  geom_line(aes(y = sharp[,12]), colour=q27[12])+
  geom_line(aes(y = sharp[,13]), colour=q27[13])+
  geom_line(aes(y = sharp[,14]), colour=q27[14])+
  geom_line(aes(y = sharp[,15]), colour=q27[15])+
  geom_line(aes(y = sharp[,16]), colour=q27[16])+
  geom_line(aes(y = sharp[,17]), colour=q27[17])+
  geom_line(aes(y = sharp[,18]), colour=q27[18])+
  geom_line(aes(y = sharp[,19]), colour=q27[19])+
  geom_line(aes(y = sharp[,20]), colour=q27[20])+
  geom_line(aes(y = sharp[,21]), colour=q27[21])+
  geom_line(aes(y = sharp[,22]), colour=q27[22])+
  geom_line(aes(y = sharp[,23]), colour=q27[23])+
  geom_line(aes(y = sharp[,24]), colour=q27[24])+
  geom_line(aes(y = sharp[,25]), colour=q27[25])+
  geom_line(aes(y = sharp[,26]), colour=q27[26])+
  geom_line(aes(y = sharp[,27]), colour=q27[27])+
  ylab(label="SR") +
  xlab(label="Lags")
#legend("topright", colnames(sharp), lwd = 1, bty = "n")

#plot(sharp, plot.type = "single", col = q27, lwd = 2)
#legend("topleft", colnames(sharp), col = q27, lwd = 0.5, bty = "n",cex=0.1)

save.image("Pesquisa_C_1.RData")

geom_line(aes(y = sharp[,2]), colour=rainbow(nrow(sharp))[2]) +
  geom_line(aes(y = sharp[,3]), colour=rainbow(nrow(sharp))[3]) +
  geom_line(aes(y = sharp[,4]), colour=rainbow(nrow(sharp))[4]) +
  geom_line(aes(y = sharp[,5]), colour=rainbow(nrow(sharp))[5]) +


#Applying Variation For The Results

#Results2 <- data.frame()
#for (i in 1:nrow(Results)) {
#  for (j in 1:ncol(Results)) {
#    Results2[i,j] <- Results[i+1,j]/Results[i,j]
#  }
#}
#colnames(Results2) <- c("Mean_Excess_Return","Volatility","SR","Degree","Closeness","Betweenness")

#rcorr(as.matrix(Results2),type=c("spearman"))
