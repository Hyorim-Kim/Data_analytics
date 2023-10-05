# 변수(데이터 유형)
va <- 1 # va는 1이라는 주소를 참조한다(reference variable)
va = 2
3 -> va
# 함수내에서 변수에게 값을 치환할 때에는 va=2방법 추천
va
print(va)
cat(va)
# console로 변수가 가진 값을 받기 위해서는 print / cat이용
print(1, 2)
cat(1, 2) # print는 한 개만 출력되지만 cat은 모두 출력됨
va[1] # 1차원 배열열

.a = 5
a.b = 5
a_b = 5

# a <- 5
# b <- 3
# c <- a + b

# ctrl + alr + r : 한 번에 실행
# ctrl + shift + c : 주석

a = 5
b = 6
(c = a + b)

# 데이터 유형(문자형, 숫자형, 복수소형, 논리형)
ss = "홍길동"
typeof(ss)

kbs = 9
typeof(kbs) # double

zz = 5.3 - 3i
typeof(zz) # complex(복소수)
Re(zz) # real number
Im(zz) # imaginary number

bb = TRUE # 논리형 - 대문자만 가능
typeof(bb) # logical
bb = T # TRUE의 T만 써도 ok

aa = NA # 결측값, 데이터 값이 없음
is.na(aa) # is.na : type 물어볼 수 있음
sum(2, 3)
sum(2, 3, NA) # 연산에 NA가 포함되면 무조건 결측값으로 수행
sum(2, 3, NA, na.rm = T) # NA remove

typeof(NA)
typeof(NULL) # NULL
typeof(NaN) # double

length(NA)   # 1
length(NULL) # 0 - 자릿릿수 확보하지 않음
length(NaN)  # 1 - not a number, missing value
0 / 0 # 수학적으로 정의되지 않은 값 : NaN으로 출력력
inf = 0


# 참고 ---------------------
# package : 데이터셋(dataset) + 함수 + 알고리즘 꾸러미(컬렉션, R패키지가 저장된 폴더는 라이브러리라고 함)
install.packages("plyr") # 내 컴퓨터에 설치
library(plyr) # 메모리에 로딩하기
search()
plyr::ddply() # package명::, 중복일 때 패키지 구분하기 위해
help("ddply") # ddply의 형식을 알려줌 + sample

dfx <- data.frame(
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
  sex = sample(c("M", "F"), size = 29, replace = TRUE),
  age = runif(n = 29, min = 18, max = 54)
)

ddply(dfx, .(group, sex), summarize,
      mean = round(mean(age), 2),
      sd = round(sd(age), 2))
# mean, sd 알려줌

remove.packages("plyr") # X
search()

data() # dataset 목록보기
Nile
head(Nile, 3) # 앞부터 3개
hist(Nile, freq = F) # histogram
lines(density(Nile)) # 밀도에 따라 line

example("head") # sample 확인

# 함수를 많이 알아야함
help("mean")
example("mean") # sample만 보기
x <- c(0:10, 50, 100)
mean(x)
c(xm, mean(x, trim = 0.10))

head(iris, 3)
mean(iris$Sepal.Length)

