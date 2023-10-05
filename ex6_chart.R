# 시각화(그래프 출력)
# 이산변수(서열,등간척도) : 막대, 점, 원형 차트 등을 사용
# 연속변수(비율척도) : 박스플롯, 히스토그램, 산점도 등을 사용
# 차트의 종류...

getwd()
setwd("C:/work/rsou/pro1")
stu = read.csv("testdata/ex_studentlist.csv")
head(stu, n=3)
str(stu)

# 세로 막대
graphics::barplot(stu$grade)
graphics::barplot(stu$grade, col=c(1,2,5))
graphics::barplot(stu$grade, col=rainbow(3), main='세로막대', xlab = '학생', ylab = '점수')

# 가로 막대
barplot(stu$grade, col=c(1,2,5), horiz = T)

par(mfrow=c(1, 2)) # 그림 영역 1행 2열
barplot(stu$grade, col=c(1,2,5), horiz = T)
barplot(stu$grade, col=c(1,2,5))

par(mfrow=c(1, 1))
# 점차트
dotchart(stu$grade)
dotchart(stu$grade, color=2:5, cex=1.5, pch=1:3) # cex:크기, pch:모양

# 파이차트
df = na.omit(stu)
df
pie(df$age)
pie(df$age, labels = df$age, lty=3) # lty: line style

# box plot : 연속형 데이터의 분포를 표현
mean(stu$height)
boxplot(stu$height, range = 0)
boxplot(stu$height, range = 1)
boxplot(stu$height, range = 1, notch = T)
abline(h=mean(stu$height), lty=3, col='blue') # 평균값 표시

# histogram
hist(stu$height)
hist(stu$height, breaks = 3) # 막대 간격 변경 

hist(stu$height, breaks = 3, prob=T)
lines(density(stu$height)) # 위 문장과 세트, 밀도 곡선

plot(x=stu$height, y=stu$weight)

head(iris)
plot(iris$Sepal.Length, iris$Petal.Length)

