# 어떤 음료에 대한 설문조사 결과로 상관관계 분석
result = read.csv("testdata/drinking_water.csv", header=T)
head(result)

summary(result)

cov(result$친밀도, result$적절성)  # 공분산 : 0.4164218
cov(result)

cor(result$친밀도, result$적절성)  # 상관계수 : 0.4992086
cor(result, method = "pearson")

plot(result$적절성, result$만족도) # 상관계수 : 0.7668527

symnum(cor(result)) # 숫자를 심볼로 표시

install.packages("corrgram")
library(corrgram)
corrgram(result) # 상관계수값을 색으로 표시
corrgram(result, upper.panel = panel.conf)
corrgram(result, lower.panel = panel.conf)

# 차트에 밀도곡선과 상관성 출력
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(result, histogram = , pch="+")
