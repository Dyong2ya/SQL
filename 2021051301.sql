2021-0513-01)
2. ALTER TABLE (테이블 이름, 구조 변경)
 1)컬럼추가(ADD)
    ALTER TABLE 테이블명
     ADD 컬럼명 데이터타입[(크기)][DEFAULT 값][NOT NULL];
        
사용예)TBL_WORK테이블에 종료일 컬럼을 추가
      종료일은 컬럼명이 END_DATE이고 DATE타입, NULLABLE
    ALTER TABLE TBL_WORK
     ADD END_DATE DATE; --END DATE에 날짜가 없어야(NULLABLE) 아직 근무중이라는 것을 알 수가 있다.
     
 2)컬럼수정(MODIFY) --컬럼의 데이터타입 및 크기 수정 
    ALTER TABLE 테이블명
     MODIFY (컬럼명 데이터타입[(크기)][DEFAULT 값][NOT NULL]);
        -'데이터타입[(크기)': 변경할 테이터타입 및 크기
사용예)사업장자재(SITE_ITEM)테이블에서 자재명(SITE_ITEM_NAME)을 CHAR(20)으로 변경하시오
    ALTER TABLE SITE_ITEM   
     MODIFY(SITE_ITEM_NAME CHAR(20));
     
 3)컬럼삭제(DROP COLUMN)
     ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
사용예)근무테이블(TBL_WORK)에서 종료일컬럼(END_DATE)을 삭제하시오
    ALTER TABLE TBL_WORK DROP COLUMN END_DATE;
    
  4)컬럼이름 변경(RENAME COLUMN)
     ALTER TABLE 테이블명 RENAME COLUMN 이전컬럼명 TO 새컬럼명;
사용예)사업장자개(SITE_ITEM)테이블에서 수량컬럼(QTY)의 이름을 ITEM_QTY로 변경하시오
    ALTER TABLE SITE_ITEM RENAME COLUMN QTY TO ITEM_QTY;
    
 5)제약조건 추가(ADD)
     ALTER TABLE 테이블명 
      ADD CONSTRAINT 기본키설정명|외래키설정명 PRIMARY KEY|FOREIGN KEY
      (컬럼명[,컬럼명,...])[REFERENCES 테이블명(컬럼명,...)];
      
 6)제약조건 변경(MODIFY)
     ALTER TABLE 테이블명 
      MODIFY (CONSTRAINT 기본키설정명|외래키설정명 PRIMARY KEY|FOREIGN KEY
      (컬럼명[,컬럼명,...])[REFERENCES 테이블명(컬럼명,...)]);
    
 7)제약조건 삭제(DROP)
     ALTER TABLE 테이블명 
      DROP CONSTRAINT 기본키설정명|외래키설정명;
      
 8)테이블명 변경
     ALTER TABLE 이전테이블명 RENAME TO 새테이블명;
    
    
      
      

    
 DELETE BUYPROD;
 SELECT + FROM BUYPROD;
 
  
 ROLLBACK;
 COMMIT;

 

 
