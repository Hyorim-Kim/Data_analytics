# 분할적(비계층적) 군집분석 : k-means가 주로 사용

data <- read.csv("testdata/exam.csv", sep = " ", header = T)
data
d_data <-dist(data, method = "euclidean")
d_data

gra_data <- cmdscale(d_data)   # 공간적 배치가 가능한 형태로 변환
gra_data

plot(gra_data, type="n")
text(gra_data)

# 학생들의 성적으로 k-means 군집분석
str(data)
data$avg <- apply(data[,2:5], 1, mean)
data

# 몇 개의 그룹으로 나눌까? k=?

install.packages("NbClust")
library(NbClust)

data_s <- scale(data[2:5])  #  표준화
data_s

# best k 값 얻기
nc <- NbClust(data_s,min.nc = 2, max.nc = 5, method = 'kmeans')
nc
plot(table(nc$Best.nc[1,]))   # 4를 추천

# 모델 생성
model_kmeans <- kmeans(data[, c("bun","avg")], 4)
model_kmeans

table(model_kmeans$cluster)

cluster <- model_kmeans$cluster
cluster

kmeans_df <- cbind(cluster, data[, c("bun", "avg")])
kmeans_df

str(kmeans_df)

kmeans_df <- transform(kmeans_df, cluster=as.factor(cluster))  # cluster 열을 factor타입으로 변환
kmeans_df
str(kmeans_df)

install.packages("ggplot2")
library(ggplot2)

df_plot <- ggplot(data = kmeans_df, aes(x =bun, y=avg, col=cluster)) + 
  geom_point(aes(shape = factor(cluster), size =4)) + 
  ggtitle("학생 점수 분포")
df_plot