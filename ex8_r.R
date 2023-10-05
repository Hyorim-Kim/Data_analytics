# 공분산, 상관계수
plot(1:5, 2:6)
cov(1:5, 2:6) # 공분산
cor(1:5, 2:6) # 상관계수(공분산을 표준화한 값)

plot(10:50, 20:60)
cov(10:50, 20:60)
cor(10:50, 20:60)

plot(1:5, c(3,3,3,3,3))
cov(1:5, c(3,3,3,3,3))
cor(1:5, c(3,3,3,3,3))

plot(1:5, 5:1)
cov(1:5, 5:1)
cor(1:5, 5:1)
# 공분산은 구체적으로 어느정도 비례/반비례 하는지 모름 -> 상관계수를 구해야함

# 아버지와 아들 키의 공분산과 상관계수 구하기
getwd()
hf = read.csv("testdata/galton.csv", header=T)
hf
head(hf, n=3)
dim(hf) # 데이터 개수 보기
str(hf)

hf_man = subset(hf, sex == "M")
head(hf_man)
dim(hf_man) # 465   6
hf_man = hf_man[c('father', 'height')] # 필요한 칼럼 뽑기
head(hf_man)

# 공분산
cov(hf_man$father, hf_man$height) # 2.368441 : 정비례 관계
cor(hf_man$father, hf_man$height) # 0.3913174

plot(hf_man$father, hf_man$height)

cor.test(hf_man$father, hf_man$height, method = 'pearson')

#   y value ~ x value, 출처
plot(height ~ father, data = hf_man, xlab="아버지키", ylab="아들키")
abline(lm(height ~ father, data = hf_man))
