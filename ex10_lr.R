# 추론 통계
# 단순 선형회귀 분석
# 독립변수(x) 1개:연속형, 종속변수(y):연속형

# 부모의 두뇌지수(IQ)와 자녀의 IQ를 이용해 선형회귀 분석
x <- c(110,120,130,140,150)
y <- c(100,105,128,115,155)
cor(x, y)  # correlation : 0.8621722 (양의 상관관계가 매우 강함)
plot(x, y) # 분포 형태 우상향
# 두 변수의 인과관계는? x가 y에 영향을 줌 (분석가의 주관) --> 회귀분석을 시도
# 원인과 결과 관계가 아닐 때에는 회귀분석 시행하지 않음(eg. 날파리와 아이스크림)

# y = wx + b  w? b? <-- 최소제곱법을 사용  
# 모델 생성 방법1 : 최소제곱법 수식을 사용
x_dev <- x - mean(x) # x에 대한 편차
y_dev <- y - mean(y) # y에 대한 편차
dev_mul <- (x - mean(x)) * (y - mean(y)) # 두 변수 각 편차의 곱
square <- x_dev ** 2  # x 편차 제곱
df <- data.frame(x, y, x_dev, y_dev, dev_mul, square) # data.frame에 넣기
df
mean(df$x)
mean(df$y)
sum(df$dev_mul) # sigma : 분자
sum(df$square)  # sigma : 분모

w <- sum(df$dev_mul) / sum(df$square)
w # 기울기값 : 1.2

b <- mean(df$y) - w * mean(df$x)
b # 절편 : -35.4
# y = w * x + b             y = 1.2 * x + (-35.4) # 모델 완성

# 부모의 IQ 110인 경우 자식 IQ는?
w * 110 + b # 예측값 : 96.6, 실제값 : 100
w * 120 + b # 예측값 :108.6, 실제값 : 105
1.2 * 120 + (-35.4)


# 모델 생성 방법2 : R이 제공하는 함수를 사용
#         lm(formula = 종속변수 ~ 독립변수)
mymodel <-lm(formula = y ~ x)
mymodel # Intercept: -35.4, x: 1.2
predict(mymodel, data.frame(x=c(110,120,87.5,134.567))) # 미지의 값 추론
# 95% confidence interval

plot(x, y)
abline(mymodel, col='blue') # 기울기: 1.2, 절편: -35.4

