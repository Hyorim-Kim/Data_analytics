# 원격 DB의 JIKWON 테이블을 이용해 근무년수에 대한 연봉 추론하는 선형회귀모델 작성
# 임의의 새로운 근무년수에 대한 연봉을 예측하기
library(rJava)
library(RJDBC)
# driver  
drv <- JDBC(driverClass="org.mariadb.jdbc.Driver", classPath="C:/Users/user/Downloads/mariadb-java-client-3.1.0.jar")
# db연동(driver, url, uid, upwd)   
conn <- dbConnect(drv, "jdbc:mariadb://127.0.0.1:3307/test","root","seoho123")

dbListTables(conn) # table 목록

query <- "select jikwon_pay,date_format(now(), '%Y') - date_format(jikwon_ibsail, '%Y') + 1 as jikibsa from jikwon"
datas = dbGetQuery(conn, query) # 연결객체 conn, query문
head(datas, 3)
is(datas)
str(datas) # 구조확인
table(datas$jikibsa) # 입사년도별 건수(빈도수)

cor(datas$jikibsa, datas$jikwon_pay) # 상관계수 : 0.9196725

plot(datas$jikibsa, datas$jikwon_pay)
# 인과관계가 있다고 가정하고 선형회귀모델 작성
model <- lm(formula = jikwon_pay ~ jikibsa, data = datas) # 근무년수가 연봉에 영향을 준다
model
abline(model, col='blue') # 추세선

summary(model) # p-value: 6.943e-13 < 0.05(α) 유의한 모델
# 독립변수가 종속변수(분산)를 84.58% 설명(정확도 X, 설명력)

# 키보드로 미지의 근무년수를 입력해 연봉 얻기
y_pred <- predict(model, newdata = data.frame(jikibsa=c(5, 5.5, 7)))
y_pred

go_func <- function(){
  y_num <- readline('근무년수 입력:')
  y_num <- as.numeric(y_num) # 문자에서 숫자로
  new_data <- data.frame(jikibsa=y_num)
  return(predict(model, newdata = new_data))
}

cat("예측결과는 ", go_func())
