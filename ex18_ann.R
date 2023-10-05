# ANN(인공신경망) - 뉴런이 하나인 경우 논리회로 중 XOR(배타적or) 문제를 해결할 수 없다.
install.packages("nnet")
library(nnet)

input <- matrix(c(0,0,1,1,0,1,0,1), ncol=2)
input
output <- matrix(c(0,1,1,0)) # and, or, xor
output

ann <- nnet(input, output, maxit = 100, size = 2, decay = 0.001) # maxit: 학습 횟수, size: 노드 개수
ann
result <- predict(ann, input)
result
ifelse(result > 0.5, 1, 0) # 한 번 학습 결과 답을 못찾음, maxit = 100으로 학습 횟수를 수정
# 랜덤한 값을 부여하기 때문에 답이 틀릴 수 있음
# and, or와 달리 xor은 노드의 개수가 2개 이상이어야 답이 나올 수 있다.

