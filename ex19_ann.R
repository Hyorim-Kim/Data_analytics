# 인공신경망
df <- data.frame(
  x1 = c(1:6),
  x2 = c(6:1),
  y = factor(c('n','n','n','y','y','y'))
)
df # 증가 형태:n, 감소:y
str(df)

library(nnet)
# x1, x2 : 독립변수, y : 종속변수
model <- nnet(y ~ ., df, size = 5) # nnet(formula, dataset, size = hidden수(은닉층의 수): node 개수)
# converged : 수렴됨, 값이 minimized
model
summary(model)
# b->h1 i1->h1 i2->h1   들어감
# -0.48  -5.90   5.53
# b->o  h1->o         빠져나옴
# 11.17 -23.93
# node의 개수가 너무 많으면 overfitting의 문제가 발생할 수 있음

install.packages("devtools")
library(devtools)

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(summary(model))

# 분류 모형 예측
model$fitted.values # 분류모델 적합값
predict(model, df)
ifelse(predict(model, df) > 0.5, 1, 0)
ifelse(predict(model, df) > 0.5, "y", "n")

pre <- predict(model, df, type = "class")
pre

table(pre, df$y)
