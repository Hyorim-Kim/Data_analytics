# 내장 함수
seq(1, 5, by=1.5)

set.seed(123) # seed number 고정 - 123번에 맞는 난수 사용
aa = rnorm(100, mean=0, sd=1) # 정규분포를 따르는 난수(random number) 생성
aa
mean(aa)
hist(aa)

bb = runif(5000, min=0, max=100) # 균등분포를 따르는 난수(random number) 생성
mean(bb)
hist(bb)

sample(1:100, 10)

vec = 1:10
min(vec)
max(vec)
range(vec)
mean(vec)
median(vec)
var(vec) # 분산 variance
sd(vec)  # 표준편차
sqrt(var(vec))
quantile(vec)
table(vec)

# 사용자 정의 함수
func1 = function(){
  print("사용자 만세")
}
func1()
typeof(func1) # "closure"

func2 = function(arg1){
  print(arg1)
  return(arg1 + 10)
}
func2(10)

# 구구단 출력
gugu_func <- function(dan){
  for(d in dan){
    for(i in 1:9){
      cat(d, '*', i, '=', d*i, ' ')
    }
    cat('\n')
  }
}
gugu_func(2:5)
