2021-0512-01)���̺� ��ü
1. ���̺� ����(2���迭�� ���� �⺻)
-������ �����ͺ��̽��� �⺻����
-��� ���� ����
-���̺���� �ش� �����ͺ��̽����� ������ �ĺ����̾�� �� //ex)buyer, buyprod, cart, ...
-TBL(���̺��� ����)�� �տ� ���̱⵵ ��
(�������)
CREATE TABLE ���̺��(
 �÷���1 ������Ÿ��[(ũ��)][NOT NULL][DEFAULT ��][,]
 �÷���2 ������Ÿ��[(ũ��)][NOT NULL][DEFAULT ��][,]
                        :
 �÷���n ������Ÿ��[(ũ��)][NOT NULL][DEFAULT ��][,]
 
 CONSTRAINT �⺻Ű������ PRIMARY KEY(�÷���[,�÷���,...])[,]
 CONSTRAINT �ܷ�Ű������ FOREIGN KEY(�÷���[,�÷���,...])
    REFERENCES ���̺��(�÷���[,�÷���,...])[,]
 CONSTRAINT �ܷ�Ű������ FOREIGN KEY(�÷���[,�÷���,...])
     REFERENCES ���̺��(�÷���[,�÷���,...])[,]
                            :
 CONSTRAINT �ܷ�Ű������n FOREIGN KEY(�÷���[,�÷���,...])
     REFERENCES ���̺��(�÷���[,�÷���,...]);
     
 ��뿹) ���ȿ��� �־��� �ѱ��Ǽ��� ������ DB�� �𵨸��� �ڷḦ �̿��Ͽ� ���̺��� 
        �����Ͻÿ�
 1)������̺�
    (1)���̺��: EMPLOYEE
    (2)�÷� �� �������
        ---------------------------------------------------------------------------
        �÷���               ������Ÿ��            NULL       PK/FK
        ---------------------------------------------------------------------------
        EMP_ID              CHAR(4)              N.N        PK
        EMP_NAME            VARCHAR2(20)         N.N 
        EMP_ADDR            VARCHAR2(80)            
        TEL_NO              VARCHAR2(20)
        EMP_POSITION        VARCHAR2(30)
        DEPT_NAME           VARCHAR2(20)
        ----------------------------------------------------------------------------
CREATE TABLE EMPLOYEE(
 EMP_ID       CHAR(4) NOT NULL,
 EMP_NAME     VARCHAR2(20) NOT NULL,
 EMP_ADDR     VARCHAR2(80),
 TEL_NO       VARCHAR2(20),
 EMP_POSITION VARCHAR2(30),
 DEPT_NAME    VARCHAR2(20),
 CONSTRAINT pk_employee PRIMARY KEY(EMP_ID));
 
 2)����� ���̺�
    (1)���̺��: SITE
    (2)�÷� �� �������
        ---------------------------------------------------------------------------
        �÷���               ������Ÿ��            NULL       PK/FK
        ---------------------------------------------------------------------------
        SITE_NO             CHAR(6)              N.N        PK  --������ȣ
        SITE_NAME           VARCHAR2(50)         N.N            --������
        SITE_ADDR           VARCHAR2(80)                        --������ּ�
        SITE_TEL_NO         VARCHAR2(20)                        --�������ȭ��ȣ
        AMOUNT_CON          NUMBER(11)           DEFAULT 0      --����ݾ�
        INPUT_MAN_CNT       NUMBER(4)                           --�����ο�
        START_DATE          DATE                                --�ð�����
        COMPLITE_DATE       DATE                                --�ϰ�����
        REMARKS             VARCHAR2(200)                       --���
        ---------------------------------------------------------------------------
 CREATE TABLE SITE(
 SITE_NO        CHAR(6),      
 SITE_NAME      VARCHAR2(50) NOT NULL,
 SITE_ADDR      VARCHAR2(80),
 SITE_TEL_NO    VARCHAR2(20),
 AMOUNT_CON     NUMBER(11)   DEFAULT 0,
 INPUT_MAN_CNT  NUMBER(4),
 START_DATE     DATE,
 COMPLITE_DATE  DATE,
 REMARKS        VARCHAR2(200),
 CONSTRAINT pk_site PRIMARY KEY(SITE_NO));
 
 3)��������� ���̺�
    (1)���̺��: SITE_ITEM
    (2)�÷� �� �������
        ---------------------------------------------------------------------------
        �÷���               ������Ÿ��            NULL       PK/FK
        ---------------------------------------------------------------------------
        SITE_ITEM_ID        CHAR(6)             N.N         PK  --�����ڵ�
        SITE_ITEM_NAME      VARCHAR2(30)        N.N             --�����
        QTY                 NUMBER(3)                           --����
        PRICE               NUMBER(8)                           --����
        BUY_DATE            DATE                                --������
        SITE_NO             CHAR(6)                         FK  --������ȣ
        -----------------------------------------------------------------------------
 CREATE TABLE SITE_ITEM(
 SITE_ITEM_ID        CHAR(6),                          
 SITE_ITEM_NAME      VARCHAR2(30)        NOT NULL,             
 QTY                 NUMBER(3),                           
 PRICE               NUMBER(8),                          
 BUY_DATE            DATE,                        
 SITE_NO             CHAR(6),
 CONSTRAINT pk_site_item PRIMARY KEY(SITE_ITEM_ID),
 CONSTRAINT fk_site_item_SITE FOREIGN KEY(SITE_NO) REFERENCES SITE(SITE_NO));
 
 4)�ٹ� ���̺�
    (1)���̺��: TBL_WORK
    (2)�÷� �� �������
        ---------------------------------------------------------------------------
        �÷���               ������Ÿ��            NULL       PK/FK
        ---------------------------------------------------------------------------
        EMP_ID              CHAR(4)              N.N        PK,FK  --�����ȣ
        SITE_NO             CHAR(6)              N.N        PK,FK  --����ڹ�ȣ
        INS_DATE            DATE           DEFAULT SYSDATE
        ----------------------------------------------------------------------------
 CREATE TABLE TBL_WORK(
 EMP_ID              CHAR(4)  NOT NULL,
 SITE_NO             CHAR(6)  NOT NULL,           
 INS_DATE            DATE     DEFAULT SYSDATE,
 CONSTRAINT pk_tblwork PRIMARY KEY(EMP_ID,SITE_NO),
 CONSTRAINT fk_tblwork_emp FOREIGN KEY(EMP_ID)
    REFERENCES EMPLOYEE(EMP_ID),
 CONSTRAINT fk_tblwork_site FOREIGN KEY(SITE_NO)
    REFERENCES SITE(SITE_NO));
    
 
 
 