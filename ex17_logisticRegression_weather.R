# Logistic Regression : 날씨 정보 dataset을 사용해 내일 비 여부 분류 모델
getwd()
setwd("C:/work/rsou/pro1")
weather <- read.csv("testdata/weather.csv")
dim(weather) # 366 * 15
head(weather, n=3)
colnames(weather)
str(weather)
weather_df <- weather[,c(-1,-6,-8,-14)] # char 열 제거
str(weather_df)
unique(weather_df$RainTomorrow) # 이항분류인지 확인, "Yes" "No"

weather_df[!complete.cases(weather_df),] # NA가 있는 행 찾기
sum(is.na(weather_df)) # NA가 있는 행이 5개
weather_df <- na.omit(weather_df) # NA가 있는 행 제거(권장X)
sum(is.na(weather_df))

# RainTomorrow를 종속변수(y)로 사용. Dummy 변수(0, 1로 변환)로 변환 작업
weather_df$RainTomorrow[weather_df$RainTomorrow == 'Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow == 'No'] <- 0
head(weather_df, n=3)
unique(weather_df$RainTomorrow)
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow) # 숫자로 타입변환
unique(weather_df$RainTomorrow)

cor(weather_df)

# 독립변수 선택 작업이 선행 : 생략

# train / test split
dim(weather_df) # 361  11
set.seed(1)
idx <- sample(1:nrow(weather_df), nrow(weather_df) * 0.7)
train <- weather_df[idx, ] # 학습용
test <- weather_df[-idx, ] # 검정용
dim(train) # 252  11
dim(test)  # 109  11

# 분류 모델 생성
wmodel <- glm(RainTomorrow ~ ., data=train, family='binomial')
wmodel
summary(wmodel)

# 모델에 의한 예측값 확인 후 성능 파악
pred <- predict(wmodel, newdata = test, type = "response")
head(pred, n=5)
result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred
cat('예측값 : ', head(result_pred, n=20))
cat('실제값 : ', head(test$RainTomorrow, n=20))
table(result_pred) # useNA = 'ifany' (NAt도 결과에 참여할 경우)

t <- table(result_pred, test$RainTomorrow)
# result_pred  0  1
#           0 88  8
#           1  3 10
sum(diag(t) / nrow(test)) # 분류정확도 : 0.8990826

# ROC(Receiver Operating Characteristic) curve 를 이용한 모델 평가
install.packages('ROCR')
library(ROCR)

pr <- ROCR::prediction(pred, test$RainTomorrow) # (실제값, 예측값)
pr

prf <- ROCR::performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

# AUC(ROC curve의 밑면적을 계산한 값)로 구체적인 값을 제시
auc <- performance(pr, measure = "auc")
auc <- auc@y.values
auc[[1]] # 0.8711844  # evaluation의 good에 해당됨

# 검증이 끝난 경우 새로운 데이터로 비 여부 확인
m <- train[c(1:3), ]
m <- edit(m)
m

new_pred <- predict(wmodel, newdata = m, type="response")
ifelse(new_pred >= 0.5, '비옴', '안옴')
