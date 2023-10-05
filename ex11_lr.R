# 단순 선형회귀
# 미국 여성의 height, weight가 담긴 dataset을 사용
getwd()
setwd("C:/work/rsou/pro1")
women
head(women,n=3)

cor(women$height, women$weight) # 0.9954948
plot(women$height, women$weight)
#       lm(formula = 종속변수 ~ 독립변수)
mfit <- lm(formula = weight ~ height, data=women)
mfit # y(weight) = x(height) * 3.45 + (-87.52)

58 * 3.45 + (-87.52) # 예측값: 112.58
48 * 3.45 + (-87.52)
59.1234 * 3.45 + (-87.52)

abline(mfit, col='red') # 회귀선

summary(mfit) # 모델에 대한 요약통계량
# (Intercept) -87.51667
# height        3.45000
# Std. Error : 0.09114
# Std. Error(표준오차): 여러개의 샘플링 데이터에 대한 평균들의 표준편차
# Std. Error(표준오차)가 0에 가까울수록 신뢰도 높음
# Pr(>|t|) : 1.09e-14 ***
# Pr(>|t|) : p value < 0.05 -> 유의한 모델
# R-squared(결정계수):  0.991
# R-squared는 설명력! 정확도가 아님

pred <- predict(mfit, data.frame(height=c(45.5,55.5,60.5))) # 예측 결과
pred # 69.45833 103.95833 121.20833

cor.test(women$height, women$weight) # 상관관계 분석

# 회귀분석모형의 적절성을 위한 조건 : 아래의 조건 위배 시에는 변수 제거나 조정을 신중히 고려해야 함.
# 1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
# 2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
# 3) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
# 4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
# 5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.

# 회귀분석모형 진단 그래프
par(mfrow=c(2,2))
plot(mfit)
# Residuals(잔차) vs Fitted(예측) : 패턴이 있기 때문에 좋은 모델 X -> 선형성 만족X
# Q-Q plot : 잔차량이 정규분포를 따라야 하지만 데이터가 일정하지 않음 -> 정규성 만족X
# Scale-Location : 독립변수들이 특정한 패턴없이 고르게 분포되어야함 -> 등분산성 만족
# - 위 차트는 독립변수가 하나이기 때문에 의미 없음
# Residuals vs Leverage : leverage가 크면 작은 움직임에도 전체적인 영향이 큼
# - outlier(이상치)로 인해 평균에 영향을 끼침
# - outlier의 영향력을 보여줌; cook's distance 밖의 데이터는 outlier가 의심됨

