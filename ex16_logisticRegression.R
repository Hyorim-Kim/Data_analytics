# Logistic Regression
# 종속변수(y:범주형)와 독립변수(x:연속형) 간의 관계를 통해 분류 모델을 작성
# 대개의 경우 이항분류를 함
# 신경망 이론(딥러닝)의 기초가 됨

# 실습 : 미국의 어느 대학원 입학여부 관련 dataset을 사용
getwd()
setwd("C:/work/rsou/pro1")
mydata <- read.csv("testdata/binary.csv")
head(mydata, n=3)
unique(mydata$admit) # 0 1 분류
summary(mydata)

# admit에 대한 rank 빈도수
table(mydata$admit, mydata$rank)
xtabs(formula = ~admit + rank, data = mydata)

str(mydata) # 400 obs. of  4 variables

# 데이터 분리 : 학습데이터 70%, 검정데이터 30% - 과적합 방지가 목적
# 범위 지정 후 실행 -> 랜덤한 데이터 출력됨 -> 실습 때는 난수 고정하기
set.seed(1) # random data 고정
idx <- sample(1:nrow(mydata), nrow(mydata) * 0.7) # 비복원 추출
length(idx)
train <- mydata[idx, ]
test <- mydata[-idx, ]
dim(train) # 280   4
dim(test)  # 120   4
head(train, n=3)

# 로지스틱회귀모델(이항분류)
?glm # Fitting Generalized Linear Models
lgmodel <- glm(formula = admit~., data = train, family = binomial(link = "logit"))
lgmodel
anova(lgmodel) # 분산의 차이 확인(Deviance)
summary(lgmodel) # 각 변수에 대한 적합도 확인 Pr(>|z|)

# 분류예측
pred <- predict(lgmodel, newdata = test, type = "response") # 검정
head(pred, n=10) # 0.5를 기준으로 판단
cat('예측값 : ', head(ifelse(pred > 0.5, 1, 0), 30))
cat('실제값 : ', head(test$admit, 30))

# 모델의 분류 정확도 계산
result_pred <- ifelse(pred > 0.5, 1, 0)
t <- table(result_pred, test$admit)
t

# confusion matrix를 이용해 모델의 Accuracy(정확도)를 구함
#TP + TN
(77 + 11) / nrow(test) # 0.7333333
(t[1,1] + t[2,2]) / nrow(test)
sum(diag(t)) / nrow(test)

# 새로운 값으로 분류 결과 얻기
newdata <- train[c(1:3), ]
newdata <- edit(newdata)
new_pred <- predict(lgmodel, newdata = newdata, type = "response")
new_pred
ifelse(new_pred > 0.5, '합격', '불합격')
