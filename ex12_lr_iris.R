# 단순선형회귀 모델 : 회귀식 적합도 확인
data("iris")
head(iris,n=3)

cor(iris[1:4])
cor(iris$Sepal.Length, iris$Sepal.Width) # -0.1175698, 음의 상관관계가 매우 낮음

# 모델 1 : 두 변량 간 상관관계가 낮은 경우로 모델 생성
model1 = lm(formula = Sepal.Length ~ Sepal.Width, data = iris)
model1

summary(model1)
# 해석 : p-value(유의확률:0.1519) > α(유의수준:0.05) 이므로 모델은 유의하지 X
# Multiple R-squared(결정계수, 설명력) : 0.01382

# 모델 2 : 두 변량 간 상관관계가 높은 경우로 모델 생성
cor(iris$Sepal.Length, iris$Petal.Length) # 0.8717538
model2 = lm(formula = Sepal.Length ~ Petal.Length, data = iris)
model2

summary(model2)
# 해석 : p-value(유의확률:< 2.2e-16) < α(유의수준:0.05) 이므로 모델은 유의함
# Multiple R-squared(결정계수, 설명력) : 0.76
