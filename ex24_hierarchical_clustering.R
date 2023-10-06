# 계층적 군집분석 : 거리개념을 기본으로 군집화를 할 때 각 데이터에서 시작해 가까운 것부터 순차적으로 묶어나가는 방법

x <- c(1,2,2,4,5)
y <- c(1,1,4,3,4)
xy <- data.frame(cbind(x, y))
xy

plot(xy, pch=20, xlab=c("x값"), ylab=c("y값"), xlim=c(0, 6), ylim=c(0, 6))
text(xy[,1], xy[,2], labels = abbreviate(rownames(xy)), cex = 0.8, pos = 1, col = 'blue')
abline(v=3, col="gray", lty=2)
abline(h=3, col="gray", lty=2)

dist(xy)^2

# 댄드로그램으로 군집 확인
?hclust
hc_res <- hclust(dist(xy)^2, method = "single") # "ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median" or "centroid"
hc_res
plot(hc_res, hang = -1)

# -------중학교 1학년 학생들의 신체검사 자료로 군집화--------
body <- read.csv("testdata/bodycheck.csv")
head(body, 3)
str(body)

d <- dist(body[, -1], method="euclidean") # 모든행 모든열
d

# 계층적 군집분석
hc <- hclust(d, method = "complete")
hc
plot(hc, hang = -1)
rect.hclust(hc, k=3, border = "red")

# 3개의 그룹 (10,4,8,1,15), (11,3,5,6,14), (2,9,13,7,12)
# 군집별 특징 확인
library(cluster)
g1 <- subset(body, 번호==10|번호==4|번호==8|번호==1|번호==15)
g2 <- subset(body, 번호==11|번호==3|번호==5|번호==6|번호==14)
g3 <- subset(body, 번호==2|번호==9|번호==13|번호==7|번호==12)
g1[2:5]
g2[2:5]
g3[2:5]

# 클러스터에 가장 큰 영향을 준 요소 : 안경유무
summary(g1[2:5])
summary(g2[2:5])
summary(g3[2:5])
# 해설 : 각 그룹의 요약 통계량과 안경유무 등을 바탕으로 특징을 살펴보면
#        1, 3 그룹이 안경유무에 의해 분류된 것을 알 수 있고, 기타 세부적으로
#        요약 통계량에 의해 군집의 유사성을 확인할 수 있다.

# ------------iris dataset으로 군집화----------------
head(iris, n=3)
idist <- dist(iris[, -5]) # 5열 제외
idist

hc <- hclust(idist)
plot(hc, hang=-1)
rect.hclust(hc, k=3, border = "red")

# 군집수 생성
ghc <- cutree(hc, k=3) # 3개로 군집 분리
ghc

iris$ghc <- ghc
head(iris, 3)

table(ghc)

g1 <- subset(iris, ghc == 1)
g2 <- subset(iris, ghc == 2)
g3 <- subset(iris, ghc == 3)
head(g1, 5)
head(g2, 5)
head(g3, 5)

summary(g1)
summary(g2)
summary(g3)
