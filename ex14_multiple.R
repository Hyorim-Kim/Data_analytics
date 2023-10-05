# 다중회귀분석 (독립변수가 복수)
state.x77 # 미국 각 주 관련정보 dataset
colSums(state.x77)
# Population  Income  Illiteracy  Life  Exp  Murder  HS Grad  Frost  Area
class(state.x77) # "matrix" "array"
is(state.x77)
str(state.x77)
# 몇개의 주만 뽑아서 사용, 모든 행
states <- as.data.frame(state.x77[,c('Murder','Population','Income','Illiteracy','Frost')])
is(states)
str(states)
head(states, n=3)
cor(states) # 종속변수:Murder, 독립변수:Population, Income, Illiteracy, Frost

# 다중회귀모델 작성
mfit <- lm(formula = Murder ~ Population+Income+Illiteracy+Frost, data = states)
mfit
summary(mfit) # p-value: 9.133e-08 < 0.05이므로 유의한 모델, R-squared: 56.7%
# 각 독립변수의 p 값은 Income: 0.9253, Frost: 0.9541로 유의수준 0.05보다 크므로 독립변수의 자격을 의심
# forward, backward로 중요한 모델 셀렉션 하기도 함

# 회귀모형의 적절성을 확인
# 1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
# 2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
# 3) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
# 4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
# 5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.

# 그래프 출력
par(mar=c(1,1,1,1))
par(mfrow=c(2,2)) # 2행 2열
plot(mfit)

install.packages("car", dependencies = T)
library(car)

# 종속변수 : Murder, 독립변수 : Population+Illiteracy
imsi_mfit <- lm(formula = Murder ~ Population+Illiteracy, data = states)
imsi_mfit
summary(imsi_mfit)

par(mar=c(1,1,1,1))
par(mfrow=c(2,2))
plot(imsi_mfit)
# Residuals(잔차) vs Fitted(예측) : 선형성은 만족하는 것으로 보임
# 선형성 만족 여부 수치로 확인
boxTidwell(Murder ~ Population+Illiteracy, data = states) # Pr(>F) = 0.7938 > 0.05이므로 선형성 만족

# Q-Q plot : 잔차량이 정규분포를 따라야 함, 정규성은 만족하는 것으로 보임
# 정규성 만족 여부 수치로 확인
shapiro.test(residuals(imsi_mfit)) # p-value = 0.6098 > 0.05이므로 잔차의 정규성 만족

# Scale-Location : 독립변수들이 특정한 패턴없이 고르게 분포되어야함, 등분산성 불만족일듯
# 그래프 출력결과 등분산성은 만족하지 않을 가능성이 있어 보임
# 등분산성 만족 여부 수치로 확인
ncvTest(imsi_mfit) # p = 0.16305 > 0.05이므로 잔차의 등분산성 만족

# 독립성
durbinWatsonTest(imsi_mfit) # p-value = 0.246 p값이 2에 근사하면 독립성을 만족 -> 독립성 X

# 다중공선성
?vif # Variance Inflation Factors(분산 팽창 요인)
vif(imsi_mfit) # 1.011718, 값이 10을 넘으면 다중공선성에 문제가 있다.

# 최적의 모델을 작성하려면 적당한 독립변수의 선택이 중요함
# 독립변수의 갯수가 많아지면 모델의 예측성능이 떨어지기 때문
# lm(formula = Murder ~ Population+Income+Illiteracy+Frost, data = states)
mfit1 <- lm(formula = Murder ~ ., data = states) # . = 모두 변수 참여
summary(mfit1) # p-value: 9.133e-08, R-squared:  0.567

mfit2 <- lm(formula = Murder ~ Population+Illiteracy, data = states)
summary(mfit2) # p-value: 2.893e-09, R-squared:  0.5668

# AIC 통계량 : 모델을 평가하는 지표 중 하나로
# 최소의 정보 손실을 갖는 모델이 가장 데이터와 적합만 모델로 선택하는 방법
AIC(mfit1, mfit2)
# df      AIC
# mfit1  6 241.6429
# mfit2  4 237.6565 # 값이 더 작으므로 좋은 모델로 평가됨

# 적당한 독립변수 선택방법 중 stepwise regression
# 후진 소거법(backward : 모든 변수를 넣고 기여도가 낮은 것부터 하나씩 제거)
full_model <- lm(formula = Murder ~ ., data = states)
reduce_model <- step(full_model, direction = "backward")

# 전진 선택법(forward : 유익한 변수부터 하나씩 추가)
min_model <- lm(Murder ~ 1, data = states) # 독립변수 없이 절편값만 주고 출발
fwd_model <- step(min_model, direction = "forward",
                  scope = (Murder~Population+Income+Illiteracy+Frost), trace = 1)

