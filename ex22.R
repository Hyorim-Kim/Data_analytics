# neuralnet : iris dataset을 사용
library(neuralnet)

# 분류 모델 작성 전 dataset을 train / test로 분리(7:3)
set.seed(123)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
nrow(train) # 105
nrow(test)  # 45
head(train, 3)

# T, F가 있는 열 3개 추가
train <- cbind(train, train$Species == 'setosa')
train <- cbind(train, train$Species == 'versicolor')
train <- cbind(train, train$Species == 'virginica')
names(train)[6:8] <- c('setosa', 'versicolor', 'virginica')
head(train, 3)

# model 생성
model <- neuralnet(setosa+versicolor+virginica ~ Sepal.Length+Sepal.Width+Petal.Length+Petal.Width, 
                   data = train, hidden = 3)
plot(model)

# 예측 : neuralnet은 predict이 아니라 compute를 지원
head(test, 2)
comp <- compute(model, test[-5]) # Species 빼고 참여
comp
pred_weight <- comp$net.result
idx <- apply(pred_weight, 1, which.max) # 행단위 작업으로 행 내에서 가장 큰 값 위치 반환
idx

c('setosa', 'versicolor', 'virginica')[3]

pred <- c('setosa', 'versicolor', 'virginica')[idx]
pred

t <- table(pred, test$Species)
t
sum(diag(t)) / nrow(test) # 모델 성능 : 0.9777778

# 새로운 값으로 분류 수행
my <- test
my <- my[c(1:3), ]
my <- edit(my)
my
mycomp <- compute(model, my[-5])
mypred <- mycomp$net.result
idx2 <- apply(mypred, 1, which.max)
idx2
pred2 <- c('setosa', 'versicolor', 'virginica')[idx2]
pred2
