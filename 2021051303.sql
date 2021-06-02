2021-0513-03)������ Ÿ��
 -����Ŭ���� ���Ǵ� ������Ÿ���� ���ڿ�, ����, ��¥, �����ڷ����� ����
 
 1. ���ڿ�
  -���ڿ� �ڷ�� ''�ȿ� ���ǵ� �ڷ�
  -��ҹ��ڸ� �����Ͽ� ���
  -�������̿� �������� Ÿ������ ����
  -CHAR, VARCHAR,VARCHAR2,NVARCHAR,NVARCHAR2,LONG,CLOB(--��뷮 4GB)
 1)CHAR
  . �������� ���ڿ��� �����Ѵ�
  (�������)
  �÷��� CHAR(n [CHAR|BYTE]);
   -n : Ȯ���� �������� ũ��� �ִ� 2000 BYTE���� ��� ����
   -�����Ͱ� ������ ���� ����(������)�� �������� ä����
   -�����Ͱ� n���� ũ�� ����
   -�ѱ� �ѱ��ڴ� 3BYTE�� ó����
   -'CHAR|BYTE': n�� ���ڼ����� ����Ʈ���� ����
     n�� ���ڼ��� ��Ÿ��� ��ü 2000BYTE�� �ʰ��� �� ����
     =>�ѱ��� 2000�ڱ��� ó������ �� ��(666���ڱ��� ����)
    
��뿹)
CREATE TABLE TEMP01(
  COL1  CHAR(10),
  COL2  CHAR(10 BYTE),
  COL3  CHAR(10 CHAR));
 
ALTER TABLE TEMP01 RENAME COLUMN COL TO COL3;--���� �߰��� ��
  
INSERT INTO TEMP01 VALUES('����','ABCDEFGHIJ','���� �߱� ���𺴿�');
INSERT INTO TEMP01 VALUES('�����','ABC','���𺴿�');

SELECT DISTINCT COL1, COL2, COL3 FROM TEMP01;--���� �߰��� �� 
SELECT * FROM TEMP01;

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
 FROM TEMP01; 
  
 2)VARCHAR2
  . �������� ���ڿ��� �����Ѵ�
  . �ִ� 4000BYTE ���� ���� ����
  . ����ϰ� ���� ������ �ý��ۿ� �ݳ� --����� �߻�X, ū �ڷ����� �� ����
  (�������)
  �÷��� VARCHAR(n [CHAR|BYTE]);
 
��뿹)
CREATE TABLE TEMP02(
  COL1  VARCHAR2(100),
  COL2  VARCHAR2(100 BYTE),
  COL3  VARCHAR2(4000 CHAR));
  
INSERT INTO TEMP02 VALUES('����','ABCDEFGHIJ','���� �߱� ���𺴿�');
INSERT INTO TEMP02 VALUES('�����','ABC','���𺴿�');
  
SELECT * 
  FROM TEMP02
 WHERE COL3='���𺴿�';
 
SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
 FROM TEMP02;
 
 3)LONG
  . �������� ���ڿ��� ����
  . �ִ� 2G ���� ���� ����
  . �������: �����̺� �� �÷��� LONG���� ���� ���� --�ؿ� TEMP03�� COL3���� LONG �� �������� �������� �� �� �� �־�.
  . CLOB Ÿ������ ��ü(LONG �� ��ɰ��� ���񽺴� ����)
  (�������)
  �÷��� LONG;
  -LONG Ÿ�� �÷��� ���Ǵ� ��
  =>SELECT���� SELECT ��, UPDATE���� SET��, INSERT���� VALUES��

��뿹)
CREATE TABLE TEMP03(
  COL1  LONG,
  COL2  VARCHAR2(4000),
  COL3  CLOB);
  
INSERT INTO TEMP03 VALUES('������','������ �߱�','������ �߱� ���ﵿ');

SELECT * FROM TEMP03

SELECT LENGTHB(COL2) FROM TEMP03;

 4)CLOB(Character Large Objects)
  .�������� ���ڿ��� ����
  .�ִ� 4GB���� ���� ����
  .�� ���̺� �������� CLOB Ÿ�� �÷� ���� ����
  .�Ϻ� ����� DBMS_LOB API�� ������ �޾ƾ� ��
  (�������)
  �÷��� CLOB; 

��뿹) 
CREATE TABLE TEMP04(
  COL1  CLOB,
  COL2  VARCHAR2(2000),
  COL3  CLOB,
  COL4  CLOB);
  
INSERT INTO TEMP04 VALUES('IL POSTINO','BOYHOOD','������ �߱� ���ﵿ 500',
                           '���ѹα��� ���ְ�ȭ���̴�');
                           
  SELECT * FROM TEMP04;
  
  SELECT SUBSTR(COL2,4,3) AS "VARCHAR2", --(�ڸ�, ����)
         SUBSTR(COL1,3,5) AS "CLOB1",
         DBMS_LOB.SUBSTR(COL2,3,4) AS "CLOB2", --(������ ����, ������ġ)
         LENGTHB(COL2) AS "COL2",
         LENGTH(COL1) AS "COL1"
         FROM TEMP04;
         
         
  
 
 

  
  
  
  