#0 clean
rm(list =   ls())
#1. Creez le vecteur [1 2 3 4]
V<-as.vector(c(1,2,3,4))
str(V)
mode (V)
class (V)
#2. Calculez sa moyenne
mean(V)
#3. Retranchez sa moyenne à chacune de ces composantes
#(ceci revient `a effectuer un centrage)
W<-V-mean(V)
W
#4. Verifiez que sa moyenne est devenue nulle.
mean(W)

#5. Affichez sa transposee
t(W)
t(t(W))

#6. Calculez le carre de sa norme 
#(en faisant le produit scalaire de ce vecteur avec lui-meme)
t(W)%*%W

#1. Chargez ce fichier dans un tableau de donnees T. 
#Pour ce faire, il faut ´ecrire
setwd("P:/M1/SEPT2019/TD/TP/V2")
T<-read.csv("temperature.csv", sep = ';', dec = ',', row.names = 1)
#2. Affichez ce tableau de donnees a l'ecran
plot(t(T)[,1], type = 'b')
for (i in (2:15)) {lines(t(T)[,i], type = 'b', col = i)}

print(T$janv)
print(T)
View(T)

#3. Convertissez la partie numerique du tableau en matrice M
# Affichez M pour voir si le resultat correspond a ce que vous attendez.
MAT<- as.matrix( T )
View(MAT)
print(MAT)
class(MAT)
class(T)
dim(MAT)
#4. Pour centrer un tableau, le cours donne la formule suivante 
# Y = X- 1_n g'
TMOY <- sapply(T,mean)
TMOY
TTMOY <-colMeans(T)
TTMOY
#summary(T)
col_1_n = rep(1,15)
g = as.matrix(TTMOY)
gprime = t(g)
X = as.matrix(T)
#Y<- as.matrix( T - rep(1,15)%*%t(TTMOY) )
Y <- X - col_1_n %*% gprime
# vérification que Y est de moyenne nulle par colonne (variable)
YYMOY <-colMeans(Y)
YYMOY
round(YYMOY, 5)

#5. D'apres le cours, la matrice de variance V est
# V = Y'D_pY
# Dans notre cas, tous les individus ont meme poids. 
# Creer un code pour calculer V .

DP<-diag(rep(1/15,15))
DP
V<-t(Y)%*%DP%*%Y
V #variance covariance entre variable (mois)
sum(diag(V))

# 6. On choisit l'identite pour la metrique M. 
# Calculez les valeurs propresde VM  avec deux decimales.
# En deduire l'inertie totale ainsi que 
# le taux d'inertie explique par le premier axe puis
# par le plan factoriel associe aux deux premiers axes factoriels.
# Combien d'axes factoriels allez vous retenir ?
  

M<-diag(rep(1,12))
val_propre<-eigen(V%*%M)
IT<-sum(val_propre$values) # 37.12
IT
plot(eigen(V%*%M)$values)
IPCT<-round(eigen(V%*%M)$values/IT*100,2)
IPCT
# => 2 vecteurs propres semblent appropriés
# plot(round(eigen(V)$values,2)/IT)

#7.  les vecteurs propres associes aux axes factoriels de l'ACP.
# combinaison linéaire des 12 variables 
MU1<-val_propre$vectors[,c(1)]
MU1
t(MU1)%*%MU1 # normé ! ouf
MU2<-val_propre$vectors[,c(2)]
MU2
t(MU2)%*%MU2 # normé ! ouf


#8. La composante principale associee a l'axe ua est donnee par
#   PHIa = Y.MUa:
# Creez une matrice P dont les deux premieres colonnes 
# sont les deux premieres composantes principales.
PHI1 <- Y %*% M %*% MU1
PHI1
PHI2 <- Y %*% M %*% MU2
PHI2
INDIV<-cbind(PHI1,PHI2)
INDIV
#9. Affichez avec la commande plot les 15 individus projetes sur 
# les 2 premiers axes factoriels. 
# Avec la commande text, rajoutez le nom de ces individus. 
# Avec la commande axis, creer les axes
# axis(1,-10:10,pos=0,labels=FALSE)
# axis(2,-5:5,pos=0,labels=FALSE)
plot(INDIV)
text (x=PHI1, y= PHI2, labels = rownames(INDIV) , pos = 1, cex = 0.5)
axis(1,-10:10,pos=0,labels=FALSE)
axis(2,-5:5,pos=0,labels=FALSE)

#10. Interpretez les deux axes factoriels.
#pour une représentation NS-EO
INDIV<-cbind(-PHI2,PHI1)
plot(INDIV)
text (x=-PHI2, y= PHI1, labels = rownames(INDIV), pos = 1 , cex = 0.5)

#install.packages("png")
library (png)
# Import the image

img.file<-"P:/M1/2021-22/TP/V2/France2.png"
img <- png::readPNG(img.file)


background_image <- function(raster.img){
  annotation_raster(raster.img,
                    xmin = -Inf, xmax = Inf,
                    ymin = -Inf, ymax = Inf)
}

# Plot with background image
library(ggplot2)
library(ggpubr)
colnames(INDIV)<-c("x","y")

df <- as.data.frame(INDIV)
ggplot(df,aes(x=x*0.5, y=y))+
  background_image(img)+
  geom_point(shape=23, fill="blue", color="darkred", size=3)+
  geom_text(aes(label=rownames(INDIV)),hjust=0, vjust=0)
  

  
  
  


# 11. On pose Ek = vect(u1; · · · ; uk)
# On rappelle que la qualit´e de repr´esentation de l'individu 
# yi sur Ek est  
#   QLT (yi; Ek) =sum(alpha = 1..k) [phi_i_alpha/||yi||_M]²
# Calculer pour tous les individus la qualite de representation
# sur le premier axe.
PHI1[1]*PHI1[1] # pour bordeaux
k<-PHI1^2 # test
k[1] #verif
Q1<-PHI1^2/as.matrix(diag(Y%*%M%*%t(Y)))
Q1[order(-Q1),]

Q2<-PHI2^2/as.matrix(diag(Y%*%M%*%t(Y)))
Q2[order(-Q2),]

# 12. On rappelle que la contribution relative de l'individu yi 
# a l'inertie de l'axe a est :
#   CTRa(yi) = pi (PHIi;a)²/lamba_a
# Calculer pour tous les individus la contribution relative 
# au premier axe.
CTR1 <-1/15* PHI1^2 /eigen(V%*%M)$values[1]
sum(CTR1) 
CTR1[order (CTR1,decreasing = TRUE),]

CTR2 <-1/15* PHI2^2 /eigen(V%*%M)$values[2]
sum(CTR2)
CTR2[order (CTR2,decreasing = TRUE),]

# 13. Comment realiser une ACP normalise sur les donnees
# precedentes
# il suffit de prendre comme metrique M = [  .. 1/si .. ] 
# inverse des variance (pour normaliser les variables)
diag(V) # est la liste des variances (ecart_type ²)
variances<-diag(V)# est la liste des variances 
M<-diag(1/variances) # (nouvelle métrique)



# 3 ACP avec le logiciel FactoMineR
# Dans la suite de ce TP, nous utilisons le logiciel FactoMineR 
# pour realiser des analyses Factorielles.
# On commence par charger la librairie FactoMineR par la commande
library(FactoMineR)
# puis on importe les donnees
T<-read.csv("temperature.csv", sep = ';', dec = ',', row.names = 1)
# La commande summary donne les statistiques de base pour chaque variable.
summary(T)
# Pour effectuer une analyse en composantes principales normees, 
# la commande est   T.pca <- PCA(T)
# L'option scale.unit = FALSE permet une ACP sur la matrice variance. 
# A la suite de cette commande, les nuages des individus et des variables apparaissent.

T.pca<-PCA(T, scale.unit = FALSE)
# T.pca<-PCA(T, scale.unit = TRUE) # APC normée par défaut ..
# La commande suivante donne les coordonnees des variables 
# pour les deux premiers axes factoriels
round(T.pca$var$coord[,1:2],2)
round(T.pca$eig,2)[,2]
# Les valeurs propres sont obtenues par
round(T.pca$eig,2)
IT <- sum(T.pca$eig[,1])
IT
# La distance des individus au centre de gravite
round(T.pca$ind$dist,2)
plot(T.pca)
# Les contributions sont donnees par
round(T.pca$ind$contrib[,1:2],2)
round(T.pca$var$contrib[,1:2],2)
T.pca$ind$contrib[,1]
CTR1[,1]*100

T.pca$ind$cos2[,1]*100
Q1[,1]*100

# Il est possible de rajouter des individus supplementaires dans le graphe.
# Par exemple, on considere Amiens et Moscou et Marackech
"Amiens" <-c( 3.1,3.8 ,6.7,9.5,12.8,15.8,17.6,17.6,15.5,11.1,6.8,4.2)
T<-rbind(T, Amiens)
row.names(T)[16]<-"Amiens"

Moscow<- c(-9.2,-8,-2.5,5.9 ,12.8,16.8,18.4,16.6,11.2,4.9,-1.5,-6.2)
T<-rbind(T, Moscow)
row.names(T)[17]<-"Moscow"

Marrakech<-c(11.3 ,12.8,15.8,18.1,21.2,24.7,28.6,28.6,25,20.9,15.9,12.1)
T<-rbind(T, Marrakech)
row.names(T)[18]<-"Marrakech"

#Pour considerer ce individus comme supplémentaire , on utilise la commande ind.sup 
T.pca <- PCA(T)
T.pca <- PCA(T, scale.unit = FALSE)
T.pca <- PCA(T,ind.sup=16:18)
T.pca <- PCA(T,scale.unit = FALSE,ind.sup=16:18)


NS<- -c(T.pca$ind$coord[,1],T.pca$ind.sup$coord[,1])
EO <- -c(T.pca$ind$coord[,2],T.pca$ind.sup$coord[,2])
rownames(T.pca$ind)
plot(EO,NS)
text (x=EO[1:15], y= NS[1:15], labels =rownames(T.pca$ind$coord), col = 1 , pos = 1)
NS.sup<- -T.pca$ind.sup$coord[,1]
EO.sup <- -T.pca$ind.sup$coord[,2]
text (x=EO.sup, y= NS.sup, 
      labels =rownames(T.pca$ind.sup$coord), col = 2, pos = 1)

# Comparez vos resultats obtenus a la main et ceux obtenus avec FactoMineR.
# Commentez les resultats des deux analyses non normalisees et normalisees.



# encore plus loin
#library(FactoMineR)
#data(decathlon)
#res.pca = PCA(decathlon, quanti.sup=11:12,quali.sup=13)
library(Factoshiny)
resshiny = PCAshiny(T.pca)


library(ade4)
library("factoextra")
data(decathlon2)
str(decathlon2)
decathlon2.active <- decathlon2[1:10]
str(decathlon2.active)
head(decathlon2.active[, 1:6])
deca.pca <- PCA(decathlon2.active, scale.unit = FALSE)
deca.pca$eig
deca.pca$var$coord
?? "factoextra"

data(iris)
str(iris)
res.pca <- PCA(iris[, -5],  scale.unit =  TRUE)
plot(res.pca$ind[c(1,2),])
plot(res.pca$ind$coord[,c(1,2)])
plot(res.pca$ind$coord[,c(1,3)])
plot(res.pca$ind$coord[,c(1,4)])
plot(res.pca$ind$coord[,c(2,3)])
plot(res.pca$ind$coord[,c(3,4)])
HCPC(res.pca)


res.pca <- PCA(iris[, -5],  scale.unit = FALSE)
ind <- get_pca_ind(res.pca, data = iris[, -5])
res.pca <- prcomp(iris[, -5],  scale = TRUE)


HCPC(T.pca)
