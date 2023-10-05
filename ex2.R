a = 1
b = 2
ls() # 현재 램에 로딩되어 있는 변수 목록을 볼 수 있음
rm(a) # remove a
rm(list=ls()) # remove all
gc() # 사용이 종료(어떤 변수도 주소를 참조 X)된 객체(instance)가 점유하고 있는 메모리를 해제

# R에서 제공하는 자료구조 (Object type) **
# 원자값(scala) 자료형은 없다.

# Vector : 1차원 배열 형태의 자료구조 (동일한 형태의 자료만 저장됨) : 가장 작은 자료구조
# - 벡터는 같은 자료형의 데이터를 정해진 갯수만큼 모아놓은 것이다. 
# - 생성 함수 : c(), seq(), rep()
# - 처리 함수 : setdiff(), intersect(), union()

year = 2023
is.vector(year) # vector 확인
is(year) # numeric & vector
class(year)
mode(year)
typeof(year) # double(기본)
year = as.integer(year) # 형변환
typeof(year) # integer
year[1] # year = year[1]

seq(from=1, to=5, by=1) # 수열(벡터) 생성 함수
seq(1, 5)
1:5
aa = seq(1, 10, 2)
aa
seq(1, 10, length.out=2) # 개수
seq(1, 10, length.out=5)

rep(1:3, times=3)
rep(1:3, 3)
rep(1:3, each=3)
rep(1:3, each=5, times=2)

aa = c(1:10,13,20:25,-5:-8) # combine function
is.vector(aa) # TRUE

# 배열이기 때문에 타입이 일치해야함
# character가 가장 강함
c(1, 3.5, TRUE, F) # 1.0 3.5 1.0 0.0
c(1, TRUE, F) # 1 1 0
c(1, 3.5, TRUE, F, '8') #"1"  "3.5"   "TRUE"  "FALSE" "8"   

age = c(10, 20, 30)
names(age) = c("홍길동", "한국인", "신기해") # vector에 칼럼명 부여
age
age[1]
age["홍길동"]

age = c(age, 40) # 값 추가
age
age[10]="tom"
age

age2 = append(age, 60, after = 6) # 여섯번째 이후에 값 들어감
age2
age = NULL
age2 = NULL
age

# 인덱싱, 슬라이싱 : 첨자 이용
v1 = c(13, -5, 20:23, 12, -2:3)
v1
v1[1]
v1[c(2, 3, 5)]
v1[c(2, 3, 5, 6:8)]
v1[-1] # -를 붙이면 여집합 출력(첫번째 빼고)
v1[-c(1, 3, 5:8)]
v1[2: (length(v1)-8)]

# 연산
a = 1:5
a
a + 5 # 각각의 벡터에 5를 더함
a ^ 2
a ** 2 #(^ = **)

a = 1:3
b = 4:6
a
b
a + b # 벡터끼리의 연산
a - b
a * b
a / b

a[4] = 2
a
b[4] = 2
b
union(a, b)   # 합집합 (중복 X)
c(a, b)       # 합집합 (중복 O)
setdiff(a, b) # 차집합 (a에는 있느나 b에 없음)
intersect(a, b)



# Matrices(Matrix) : 2차원의 dataset 이다. 이는 매트릭스 함수에 벡터를 제공함으로써 만들 수 있다.
# 동일 데이터 타입을 갖는 2차원 배열(행렬 구조).
# 선형대수학 정리 http://kipid.tistory.com/entry/Linear-Algebra
# - 생성 함수 : dim(), matrix(), rbind(), cbind()
# : matrix: 긴 벡터를 잘라서 행렬로 변환
# : cbind: 여러 개의 벡터를 좌우로 붙여서 행렬로 변환
# : rbind: 여러 개의 벡터를 위아래로 붙여서 행렬로 변환
# - 처리함수 : apply()

a = 1:8
dim(a) # NULL
dim(a) <- c(2, 4) # 2행 4열
a
class(a) # "matrix" "array"
mode(a) # "numeric"

m = base::matrix(1:5) # base package의 matrix
m # 2차원, 5행 1열
m = base::matrix(1:9, nrow = 3, byrow = T) # byrow : 데이터 열부터 채움
m
m2 = matrix(1:10, 2)
m2
m2 = matrix(1:10, 3)
m2
dim(m2)
mode(m2)
m2
m2[2,] # 2행만 출력
m2[2:3,] # 2행과 3행
m2[c(1, 3),] # 1행과 3행
m2[,1] # 1열 출력
m2[1:3, c(1, 3)]
m2[,-1] # 1열 제외

matrix(c(1,2.2,'kbs'))

a = matrix(c(1:9), nrow=3, dimnames = list(c("r1","r2","r3"),c("c1","c2","c3")))
a # 이름부여

length(a)
ncol(a)
nrow(a)
dim(a) # 3행 3열

rownames(a) = c("1행", "2행", '3행')
colnames(a) = c("1열", "2열", '3열')
a

a = matrix(c(1,2,3,4),nrow = 2, ncol = 2)
a
b = matrix(5:8, 2, 2)
b

a + b
a - b
a / b
a * b   # Hadamard(아다마르 곱) : 행렬 곱
a %*% b # 행렬의 곱 **

a
diag(a) # 대각요소값만 출력 **
diag(3) # 주대각이 1 **
a
t(a) # 전치행렬(행과 열의 위치를 변환) **

x1 = c(5, 40, 50:52)
x1
x2 = c(30, 5, 6:8)
x2
mr = rbind(x1, x2) # 행을 기준으로 매트릭스 생성
mr

mc = cbind(x1, x2) # 열을 기준으로 매트릭스 생성
mc

x = matrix(1:9, 3, 3)
x
apply(x, 1, max) # 행 단위 최대값 구하기 함수
apply(x, 2, max) # 열 단위 최대값 구하기 함수


# Arrays : matrix는 2차원에 한정되지만 arrays는 어떠한 차원으로도 만들 수 있다. 
# 동일 데이터 타입을 갖는 다차원 배열. (활용도는 다소 낮다)
# - matrix는 행과 열을 갖는 2차원 자료구조다.
# - Array는 행과 열, page를 갖는 3차원 자료구조다.
# - 생성 함수 : array(data, dim)
d = c(1:12)
d
class(d) # "integer"
arr1 = array(d) # 1차원 배열
arr1
class(arr1) # "array"

arr2 = array(1:12, dim = c(6, 2)) # 6행 2열
arr2 # 2차원 배열
dim(arr2)

arr3 = array(1:12, dim = c(3, 2, 2)) # dim{행, 열, 면}
arr3 # 3차원 배열
dim(arr3)

# 배열 조회
arr3[,,1]
arr3[,1,2]
arr3[1,,2]
arr3[1,1,2]

# List : 서로 다른 타입의 데이터를 기억할 수 있다.
# - 성격이 다른 데이터(벡터, 행렬, 데이터프레임 등 모든 데이터)의 기억이 가능,
# c의 구조체, java의 레코드형 기억장소와 유사
# - 생성 함수 : list()
# - 처리 함수 : unlist(), lapply(), sapply()
li = list("1","한국인",95,"2","tom",88)
li
class(li) # "list"
unli = unlist(li)
class(unli) # "character"
datas = list(x=1:5, y=6:10)  # key, value 형식으로 리스트 생성
datas
datas$x
datas$y


# *************************************************************
# Data Frames : 구조화된 데이터 오브젝트다. 
# 데이터베이스의 테이블 구조와 유사, 칼럼 단위로 type이 달라도 됨
# - 가장 많이 사용되는 객체 타입
# - 데이터프레임과 행렬은 모두 2차원 데이터이지만 다음과 같은 점이 다르다.
# 데이터프레임의 각 열은 서로 다른 자료형이 될 수 있다.
# 데이터프레임은 열 이름, 행 이름을 가질 수 있다.
# - 생성 함수 : data.frame(열이름1=요소, 열이름2=요소, …)
# - 처리 함수 : apply(), str(), ncol(), nrow(), summary()

# 방법1 : vector를 이용해 data.frame 작성
no = c(1,2,3)
name = c('hong','lee','kim')
pay = c(200, 250, 300)
df = data.frame(bunho=no,irum=name,pay=pay)
df
class(df) # "data.frame"
mode(df)  # "list"
is(df)

df = data.frame(irum=c('james','oscar','tom'),nai=c(34, 23, 42))
df
nrow(df)
ncol(df)
str(df) # 'data.frame':	3 obs. of  2 variables:
summary(df)
head(df, n=2)
tail(df, n=2)
names(df) # column names

# 방법2 : matrix를 이용해 data.frame 작성
m <- matrix(c(1,'hong',400,2,'lee',500,3,'kim',350), 3, by=T) # 행3개, 행우선
m

mdf <- data.frame(m)
mdf
colnames(mdf) <- c('번호','이름','급여')
mdf
str(mdf)

mdf['번호']
mdf$번호
typeof(mdf['번호']) # "list"
typeof(mdf$번호) # "character"
mdf
mdf[1] # 1열만 출력
mdf[-1] # 1열만 빼고 출력(여집합)
mdf[1,c(1, 3)]

# 조건을 지정해 특정 행 출력
mdf[mdf$번호 == 2,] # 번호가 2인 행
subset(mdf, 번호 == 2)

mdf[mdf$번호 == 2 & mdf$이름 == 'lee',] # 번호가 2번이고 이름이 lee인 행
subset(mdf, 번호 == 2 & 이름 == 'lee')

mdf[mdf$번호 == 2 | mdf$번호 == 1,] # 번호가 2번이거나 1인 행
subset(mdf, 번호 == 2 | 번호 == 1)

mdf[mdf$번호 == 1, c(1,2)]
subset(mdf, 번호 == 1, select = c(1,2))

# 행, 열 추가
mdf
mdfr = rbind(mdf, c("4", 'park', '550'))
mdfr
mdfc = cbind(mdf, 번호=c("5"), 이름=c("choi"), 급여=c('550'))
mdfc

# 행 삭제
mdfc[-1,]

# 열 삭제
mdfc[,"번호"] = NULL
mdfc

# base package가 제공하는 iris dataset 사용
head(iris, n=3)
class(iris)
str(iris)
mean(iris$Sepal.Length)
apply(iris[1:4], 1, mean) # 행방향
apply(iris[1:4], 2, mean) # 열방향

# data.table type : data.frame을 개선한 패키지가 제공됨
install.packages("data.table")
library(data.table)
dt = as.data.table(mdf)
dt
class(dt) # "data.table"

idata = as.data.table(iris)
head(idata,3)

# merge : data.frame들을 합성
height = data.frame(id=c(1,2,2), h=c(180,175,178))
height
weight = data.frame(id=c(1,2,3), w=c(80,75,88))
weight

merge(height, weight)
merge(height, weight, by.x = "id", by.y = "id") # id를 기준으로 병합(기본값)

aa = merge(height, weight, all = T) # 데이터가 없는 것도 참여

subset(aa, h >= 175)
subset(aa, h >= 175, select = c(1, w))
subset(aa, h >= 175, select = c(-1, -w))
