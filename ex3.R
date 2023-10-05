# 데이터 입출력
# 키보드 입력
n = scan() # 숫자 입력
n
sum(1:n)

ss = scan(what="") # 문자열 입력
ss

# edit 함수를 이용해 다량의 데이터 입력
df = data.frame() # 빈 데이터프레임 생성
df1 = edit(df)
df1

# 파일 읽기
getwd()
setwd("C:/work/rsou/pro1")

help("read.table")
? read.table

student = read.table("testdata/student.txt")
student
is(student)
str(student)

student = read.table("testdata/student1.txt", header = TRUE)
student

student = read.table("testdata/student2.txt", header = TRUE, sep=";")
student

student = read.table("testdata/student3.txt", header = TRUE, sep=" ", na.strings = "-")
student
sum(student$total, na.rm = T) # 결측지 NA 처리 방안 : 해당 행 삭제, 평균으로 대체, 0으로 대체...

student = read.csv("testdata/student4.txt", header = TRUE, na.strings = "-")
student
sum(student$total, na.rm = T)

# excel 문서 읽기
install.packages("xlsx")
Sys.setenv("JAVA_HOME='경로'") # 생략 가능
library(xlsx)
student_ex = read.xlsx2(file = "testdata/student.xlsx", sheetIndex = 1)
student_ex

# 저장 ------------------------------------
aa = 10
cat('aa는 ', aa, " 저장됨") # console로 출력
print(aa) # 출력값 한개만 출력

data = read.csv(file.choose(), encoding = "utf-8") # file 선택 창 출력
data

imsi = head(data, n=5)
imsi

write.table(imsi, "output/my1.txt", fileEncoding = "utf-8")
write.table(imsi, "output/my2.txt", row.names = T, fileEncoding = "utf-8")

write.csv(imsi, "output/my3.csv", row.names = T, fileEncoding = "utf-8")
write.csv(imsi, "output/my4.csv", row.names = T, fileEncoding = "utf-8", quote = F)


