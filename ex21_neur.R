# neuralnet : 역전파(back propagation)를 지원
install.packages("neuralnet")
library(neuralnet)

head(iris, 2)
unique(iris$Species)
# Species를 숫자형태로 변환
iris$Species2[iris$Species == 'setosa'] <- 1
iris$Species2[iris$Species == 'versicolor'] <- 2
iris$Species2[iris$Species == 'virginica'] <- 3
head(iris, 2)
iris$Species <- NULL
head(iris, 2)
unique(iris$Species2)

# 분류 모델 작성 전 dataset을 train / test로 분리(7:3)
set.seed(123)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
nrow(train) # 105
nrow(test)  # 45

# 독립변수에 대한 정규화를 실시 (대개의 경우 정규화 또는 표준화를 하면 모델링 성능이 향상)
normal_func <- function(x){
  #print((x - min(x)) / (max(x) - min(x)))
  return((x - min(x)) / (max(x) - min(x)))
}

normal_func(c(1, 2, 3))

# 학습 데이터를 정규화
train_nor <- as.data.frame(lapply(train, normal_func))
head(train_nor, 5)

# 검정 데이터를 정규화
test_nor <- as.data.frame(lapply(test, normal_func))
head(test_nor, 5)

help("neuralnet")

model <- neuralnet(Species2 ~ ., data = train_nor, hidden = 5, algorithm = 'backprop', learningrate = 0.01)
model
plot(model)
