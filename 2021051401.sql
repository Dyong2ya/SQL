2021-0514-01)
2. ������
  -���� �� �Ǽ��� ����
  -NUMBER Ÿ�� ����
  (�������)
  �÷��� NUMBER[(���е�|*[,������])];
   .������� : 10 * e-130 ~ 9.99999...99 * e125 --�� 10�� 126��(e�� 10�̾�): ���� ��� ���� �� ���Ե�
   '���е�|*' : ���е��� �ý��ۿ� ������ ��� '*' ���
 
 1) ���е�>������
  .���е� : ��ü �ڸ���(1~30)
  .�������� ��� : �Ҽ������� �ڸ���(84~127)
  .�������� ����: �����κ��� �ڸ���
--------------------------------------------------
�Է°�         ����              ��ﰪ     
--------------------------------------------------
1234.5678     NUMBER            1234.5678
1234.5678     NUMBER(7,3)       1234.568
1234.5678     NUMBER(*,3)       1234.568
1234.5678     NUMBER(7)         1235
1234.5678     NUMBER(5,3)       �����߻�
1234.5678     NUMBER(7,-2)      1200
--------------------------------------------------

 2) ���е�<������
  .����� ���
  .���е� : 0�� �ƴ� ��ȿ������ ����
  .������ - ���е� : �Ҽ��� ������ �����ؾ��ϴ� 0�� ����
--------------------------------------------------
�Է°�         ����              ��ﰪ     
--------------------------------------------------
0.2345        NUMBER(4,5)       ����
1.2345        NUMBER(3,5)       ����
0.0123        NUMBER(3,4)       0.0123  
0.0012345     NUMBER(3,5)       0.00123
--------------------------------------------------

3. ��¥��
  -��,��,��,��,�ʸ� �����ϴ� �ڷ���
  -DATE, TIMESTAMP�� ����
 
 1)DATE
  .ǥ�س�¥��
  .'+'��'-'�� ��� : �������� ��¥�� --�ٰ��� ��¥(+), ������ ��¥(-)
  .��¥�� - ��¥�� : ����� �ϼ�
  (�������)
  �÷��� DATE; 
   -����Ǵ� ��¥ ������ ����->ȯ�漳��->�����ͺ��̽�->NLS���� ������ ����
��뿹)
CREATE TABLE TEMP05(
  COL1  DATE,
  COL2  DATE,
  COL3  DATE);
  
  INSERT INTO TEMP05 VALUES(SYSDATE,SYSDATE-20,SYSDATE+30);
  
  SELECT * FROM TEMP05;
  
  *��/��/�� �� �ð������� ǥ���� �� : TO_CHAR�Լ� ���
SELECT TO_CHAR(COL1,'YYYY-MM-DD PM HH24:MI:SS'),
       TO_CHAR(COL2,'YYYY-MM-DD AM HH24:MI:SS'),
       TO_CHAR(COL3,'YYYY-MM-DD AM HH24:MI:SS')
    FROM TEMP05;
    
    
  SELECT TRUNC(SYSDATE)-TRUNC(COL2) FROM TEMP05;
 
  SELECT MOD((TRUNC(SYSDATE)-TO_DATE'00010101'))-1,7) FROM DUAL; 
  
  2)TIMESTAMP
  .�ð�������(TIMEZONE)�� 10����� 1�� ������ �ð����� ����
  .�������α׷�(java�� jsp��� �ð��� 1/1000�� ���)
  (�������)
  �÷��� TIMESTAMP;
  �÷��� TIMESTAMP WITH TIME ZONE;
  �÷��� TIMESTAMP WITH LOCAL TIME ZONE;
  .'TIMESTAMP': �ð��� ���� ����
  .'TIMESTAMP WITH TIME ZONE' : �ð��� ���� ����
  .'TIMESTAMP WITH LOCAL TIME ZONE' : ������ ��ġ�� �ð��� ���� =  TIME ZONE
    �� ����
��뿹)
CREATE TABLE TEMP06(
  COL1  TIMESTAMP,
  COL2  TIMESTAMP WITH TIME ZONE,
  COL3  TIMESTAMP WITH LOCAL TIME ZONE);
  
  INSERT INTO TEMP06 VALUES(SYSDATE,SYSDATE,SYSDATE);
  
  SELECT * FROM TEMP06
  
4. ��Ÿ �ڷ���
  -���� �ڷḦ ó���ϱ� ���� �ڷ��� --�ַ� Ư���� ��쿡 ���ȴ�
  -BLOB, BFILE, RAW, LONG RAW
  1)RAW
  .���� ũ���� �����ڷ� ����
  .����Ŭ���� �ؼ��̳� ��ȯ�۾��� �������� ����
  .�ִ� 2000 BYTE ���� ����
  .�ַ� ����, ���� �� ����
  .16���� �� 2���� ���� ����
  (�������)
  �÷��� RAW(ũ��);
  
��뿹)
CREATE TABLE TEMP07(
  COL1  RAW(1000),
  COL2  RAW(2000));
  
  INSERT INTO TEMP07 VALUES(HEXTORAW('7DEF'),'11001001'); 
  
  SELECT * FROM TEMP07;
  
  2)BFILE
  .�����ڷ� ����
  .�����ڷḦ ���̺� '�ܺ�'�� �����ϰ� ���̺��� ���(���丮: ����) ������ ����
  .4GB���� ���� ����           
  (�������)
  �÷��� BFILE;
  
  �׸��������
  (1)�����ڷᰡ ����� ���丮 ��ü ����
    .���丮 ��Ī(Alias) 30BYTE, ���ϸ� 256BYTE ���� ��� ����
    
  CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle\workspace'
    .���丮 ��Ī: TEST_DIR
    
  (2)������ ����� ���̺� ����-�÷�=>BFILE Ÿ������ ����
  CREATE TABLE TEMP08(
    COL1 BFILE);
    
  (3)���� ����
  INSERT INTO TEMP08 VALUES(BFILENAME('TEST_DIR','SAMPLE.jpg'));
  
  SELECT * FROM TEMP08;
  
  