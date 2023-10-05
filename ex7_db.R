# 데이터 종류
# -정형 : RDBS의 table
# -반정형 : xml, json...
# -비정형 : sns...

# RDBMS와 연동
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
library(DBI)
#Sys.setenv(JAVA_HOME='C:/Program Files')
library(rJava)
library(RJDBC)

# driver  
drv <- JDBC(driverClass="org.mariadb.jdbc.Driver", classPath="C:/Users/user/Downloads/mariadb-java-client-3.1.0.jar")

# db연동(driver, url,uid,upwd)   
conn <- dbConnect(drv, "jdbc:mariadb://127.0.0.1:3307/test","root","seoho123")

dbListTables(conn) # table 목록

# sangdata 읽기
query = "select * from sangdata"
goodsall = dbGetQuery(conn, query)
goodsall
class(goodsall) # "data.frame"
mean(goodsall$su)
barplot(goodsall$su, col = rainbow(7), names.arg = goodsall$sang)

goods = dbGetQuery(conn, "select * from sangdata where sang like '가죽%'")
goods

# 레코드 추가
query = "insert into sangdata values(6, '우산', 12, 5000)"
dbSendUpdate(conn, query)

query = "select * from sangdata"
goodsall = dbGetQuery(conn, query)
goodsall

df = data.frame(code=7, sang='비닐우산', su=2, dan=4500)
df
dbSendUpdate(conn, "insert into sangdata values(?,?,?,?)", df$code, df$sang, df$su, df$dan )
query = "select * from sangdata"
goodsall = dbGetQuery(conn, query)
goodsall

#레코드 수정
query = "update sangdata set sang='종이우산',dan=1000 where code=7"
dbSendUpdate(conn,query)

query = "select * from sangdata"
goodsall = dbGetQuery(conn, query)
goodsall

#레코드 삭제
query = "delete from sangdata where code=6"
dbSendUpdate(conn,query)

query = "select * from sangdata"
goodsall = dbGetQuery(conn, query)
goodsall

# 여러 개의 행을 가진 data.frame 자료 DB로 추가하기
getwd()
setwd("C:/work/rsou/pro1")
sangdf = read.csv("ex7.csv", header = T, fileEncoding = 'utf-8')
sangdf
class(sangdf)

# 선행 학습 : 문자열 더하기 함수
paste("Hi", "Everybody")  # "Hi Everybody"
paste0("Hi", "Everybody") # "HiEverybody"
# %>% 명령을 계속 이어서 할 수 있도록 하는 연산자
install.packages("dplyr")
library(dplyr)

# 함수 작성
# "insert into sangdata values(?,?,?,?)"
func = function(conn, table, df){  # 연결객체, 대상테이블, df
  batch = apply(df, 1, FUN = function(x) paste0("'", trimws(x), "'", collapse = ",")) %>%
              paste0("(",.,")", collapse = ",\n")  # 구분자:,
  print(batch)
  query = paste("insert into", table, "values", batch)
  print(query)
  dbSendUpdate(conn, query)
}

func(conn, "sangdata", sangdf)

query = "select * from sangdata"
goodsall = dbGetQuery(conn, query)
goodsall

