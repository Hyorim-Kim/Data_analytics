# 군집분석(Clustering analysis) : 비지도 학습
# 계층적, 비계층적
# 군집 간 유사성과 비유사성 확이능ㄹ 위해 거리계산법 - 맨하탄, 유클리드 거리계산법 등...

# 유클리드 거리 계산법
x <- matrix(1:16, nrow = 4)
x
?dist
dist <- dist(x, method = "euclidean") # "euclidean", "maximum", "manhattan", "canberra", "binary" or "minkowski"
dist # 1과 6 사이가 가장 멀다.
plot(dist)
text(dist, c(LETTERS[1:6]), pos = 2)

sqrt(sum((x[1,] - x[4,])^2))

getwd()
setwd("C:/work/rsou/pro1")
txt1 <- read.csv("testdata/cluster_ex.csv", encoding = "euc-kr")
txt1

plot(txt1[,c(2:3)], xlab='국어', ylab='영어', main='학생점수 산포도', 
     xlim=c(50,100), ylim=c(30,100))

# 홍길동과 이기자 두 학생의 거리 계산
text(txt1[,2], txt1[,3], labels = abbreviate(rownames(txt1)), cex=0.8, pos=1, col='blue')
text(txt1[,2], txt1[,3], labels = txt1[,1], cex=0.8, pos=2, col='blue')
points(txt1[1,2], txt1[1,3], col='red', pch=19)
points(txt1[2,2], txt1[2,3], col='red', pch=19)

dist_mht <- dist(txt1[c(1:2),c(2:3)], method="manhattan")
dist_mht

dist_euc <- dist(txt1[c(1:2), c(2:3)], method="euclidean")
dist_euc
