2021-0510-01)
1. 사용자 계정 생성

CREATE USER EJ94 IDENTIFIED BY java;

2. 권한부여
-GRANT 명령으로 부여
(사용형식)
GRANT 권한명1[,권한명2,...]TO 계정명;

GRANT CONNECT, RESOURCE, DBA TO EJ94;
