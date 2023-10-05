# iris dataset으로 출력결과가 세개의 범주로 처리
data(iris)
head(iris, n=2)
unique(iris$Species)
dim(iris)

# 분류 모델 작성 전 dataset을 train / test로 분리(7:3)
set.seed(123)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
nrow(train) # 105
nrow(test)  # 45

library(nnet)
library(devtools)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

# Sepal.Length Sepal.Width Petal.Length Petal.Width: 독립변수   Species: 종속변수
# node를 1개 사용한 경우
model_1 <- nnet(Species ~ ., train, size = 1)
model_1 # softmax modelling : 출력값은 확률
# 이항분류일 땐 binary, 다항분류일 때는 softmax
summary(model_1)
plot.nnet(summary(model_1))
# 입력층 4개, 은닉층 1개, 출력층 3개

# node를 3개 사용한 경우
model_2 <- nnet(Species ~ ., train, size = 3)
model_2 # softmax modelling : 출력값은 확률
summary(model_2)
plot.nnet(summary(model_2))
# 입력층 4개, 은닉층 3개, 출력층 3개

# 분류 모델 평가
pred1 <- predict(model_1, test, type = "class")
t1 <- table(pred1, test$Species)
t1
sum(diag(t1)) / nrow(test) # 0.9777778

pred2 <- predict(model_2, test, type = "class")
t2 <- table(pred2, test$Species)
t2
sum(diag(t2)) / nrow(test) # 0.9777778

# 다른 방법
model_3 <- nnet(train[, 1:4], class.ind(train$Species), size = 3, softmax = TRUE)
model_3
pr <- predict(model_3, newdata = test[, 1:4], type = "class")
pr
table(pr, test$Species)

# nnet는 단방향 학습만 처리 : 역전파(back propagation)를 지원하지 않음