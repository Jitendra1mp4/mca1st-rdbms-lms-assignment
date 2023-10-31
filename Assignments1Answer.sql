
-- Create a table to store deposit information
CREATE TABLE DEPOSIT(
  ACTNO VARCHAR2(5),
  CNAME VARCHAR2(20),
  BNAME VARCHAR2(18),
  AMOUNT NUMBER(8,2),
  ADATE DATE
);

-- Create a table to store branch information
CREATE TABLE BRANCH (
  BNAME VARCHAR2(18),
  CITY VARCHAR(18)
);

-- Create a table to store loan information
CREATE TABLE BORROW (
  LOANNO VARCHAR2(5),
  CNAME VARCHAR2(20),
  BNAME VARCHAR2(18),
  AMOUNT NUMBER(8,2)
);

-- Create a table to store customer information
CREATE TABLE CUSTOMER (
  CNAME VARCHAR2(20),
  CITY VARCHAR2(18)
);

-- Insert data into the DEPOSIT table
INSERT ALL 
INTO DEPOSIT VALUES ('100','ANIL','VRCE','1000',  '03-01-1995')
INTO DEPOSIT VALUES ('101','SUNIL','AJNI','5000', '01-04-1996')
INTO DEPOSIT VALUES ('102','MEHUL','KAROLBAGH','3500', '11-17-1995')
INTO DEPOSIT VALUES ('103','MADHURI','MG ROAD','1200', '12-17-1995')
INTO DEPOSIT VALUES ('104','PRAMOD','ANDHERI','3000', '03-31-1996')
INTO DEPOSIT VALUES ('105','SANDIP','VIRAR','2000', '09-05-1995')
INTO DEPOSIT VALUES ('106','SHIVANI','NEHRU PALACE','1000', '06-02-1995')=
INTO DEPOSIT VALUES ('107','KRANTI','POWAI','5000', '08-10-1995')
INTO DEPOSIT VALUES ('108','SHALINI','VRCE','7000', '10-28-1996')
INTO DEPOSIT VALUES ('109','SANJANA','ANDHERI','4000', '04-04-1996')
INTO DEPOSIT VALUES ('110','JITENDRA','INDIRA CHOWK','9000', '10-02-1998')
INTO DEPOSIT VALUES ('111','YOGEN','GANDHI CHOWK','9000', '02-02-1998')
SELECT * FROM DUAL;

-- Insert data into the BRANCH table
INSERT ALL 
INTO BRANCH VALUES ('JITENDRA CHOWK','RAIPUR')
INTO BRANCH VALUES ('VRCE','NAGPUR')
INTO BRANCH VALUES ('AJNI','NAGPUR')
INTO BRANCH VALUES ('KAROLBAGH','DELHI')
INTO BRANCH VALUES ('MG ROAD','BANGLORE')
INTO BRANCH VALUES ('ANDHERI','MUMBAI')
INTO BRANCH VALUES ('VIRAR','MUMBAI')
INTO BRANCH VALUES ('NEHRU PALACE','DELHI')
INTO BRANCH VALUES ('POWAI','MUMBAI')
INTO BRANCH VALUES ('GE ROAD','BANGLORE')
INTO BRANCH VALUES ('INDIRA CHOWK','ARANG')
SELECT * FROM DUAL;

-- Insert data into the BORROW table
INSERT ALL
INTO BORROW VALUES (201, 'ANIL', 'VRCE',10000)
INTO BORROW VALUES (206, 'MEHUL', 'KAROLBAGH',50000) 
INTO BORROW VALUES (311, 'SUNIL', 'AJNI', 30000) 
INTO BORROW VALUES (599,'JITENDRA','JITENDRA CHOWK',12000)
INTO BORROW VALUES (321, 'MADHURI', 'ANDHERI', 20000)
INTO BORROW VALUES (375, 'PRAMOD', 'VIRAR', 80000)
INTO BORROW VALUES (481, 'SANJANA', 'NEHRU PALACE',30000) 
INTO BORROW VALUES (499,'YOGEN','DHAMTARI ROAD',10000)
SELECT * FROM DUAL;

-- Insert data into the CUSTOMER table
INSERT ALL 
INTO CUSTOMER VALUES ('ANIL', 'KOLKATA')
INTO CUSTOMER VALUES ('SUNIL', 'DELHI')
INTO CUSTOMER VALUES ('MEHUL', 'BARODA')
INTO CUSTOMER VALUES ('JITENDRA', 'RAIPUR')
INTO CUSTOMER VALUES ('MADHURI', 'PATNA')
INTO CUSTOMER VALUES ('PRAMOD', 'NAGPUR')
INTO CUSTOMER VALUES ('SANDIP', 'NAGPUR')
INTO CUSTOMER VALUES ('SHIVANI', 'SURAT')
INTO CUSTOMER VALUES ('KRANTI', 'MUMBAI')
INTO CUSTOMER VALUES ('SHALINI', 'MUMBAI')
INTO CUSTOMER VALUES ('YOGEN', 'BILASPUR')
SELECT * FROM DUAL;




*********************************
ASUR PART 2 
*********************************

Give account number and deposit amount of customer having account opened between dates 1-
12-96 and 01-06-96

SELECT CNAME , ACTNO FROM DEPOSIT WHERE ADATE between date '1996-01-12' AND date '1996-01-06'

last qn

SELECT 
  CUSTOMER.CNAME AS CUSTOMER_NAME , 
  CUSTOMER.CITY AS LIVING_CITY , 
  BRANCH.CITY AS BRANCH_CITY , 
  ACTNO, 
  DEPOSIT.BNAME AS DEPOSIT_BRANCH_NAME,
  DEPOSIT.AMOUNT AS DEPOSTI_AMOUNT,
  DEPOSIT.ADATE AS DEPOSTI_DATE,
  LOANNO,
  BORROW.BNAME AS BORROW_BRANCH_NAME,
  BORROW.AMOUNT AS BORROW_AMOUNT
FROM 
  CUSTOMER INNER JOIN DEPOSIT ON CUSTOMER.CNAME = DEPOSIT.CNAME
  INNER JOIN BORROW  ON CUSTOMER.CNAME = BORROW.CNAME
  INNER JOIN BRANCH ON  DEPOSIT.BNAME = BRANCH.BNAME

WHERE DEPOSIT.CNAME = 'ANIL' AND CUSTOMER.CNAME = 'ANIL' AND BORROW.CNAME =  'ANIL'





*********************************
ASUR PART 3
*********************************

-- Give name of Customer having living city Mumbai and Branch city NAGPUR

SELECT CNAME , CUSTOMER.CITY AS CUSTOMER_CITY , BRANCH.CITY AS BRANCH_CITY 
FROM CUSTOMER INNER JOIN DEPOSIT USING(CNAME) 
INNER JOIN BRANCH USING(BNAME) 
WHERE CUSTOMER.CITY='MUMBAI' AND BRANCH.CITY='NAGPUR' ;




-- Give names of Customer having the same living city as their Branch City.

SELECT CNAME , CUSTOMER.CITY AS CUSTOMER_CITY , BRANCH.CITY AS BRANCH_CITY 
FROM CUSTOMER INNER JOIN DEPOSIT USING(CNAME) 
INNER JOIN BRANCH USING(BNAME) 
WHERE CUSTOMER.CITY=BRANCH.CITY 



-- Give names of Customers who are borrowers as well as depositers and living city NAGPUR

SELECT CNAME , CUSTOMER.CITY AS CUSTOMER_CITY FROM DEPOSIT
INNER JOIN BORROW USING(CNAME)
INNER JOIN CUSTOMER USING (CNAME)
WHERE CUSTOMER.CITY ='NAGPUR';


-- Give names of Customers who are depositors and have the same branch city as that of Mr. SUNIL

SELECT CNAME , BNAME, BRANCH.CITY  AS BRANCH_CITY FROM DEPOSIT 
INNER JOIN BRANCH USING(BNAME) 
WHERE BRANCH.CITY = (SELECT CITY FROM CUSTOMER WHERE CNAME = 'SUNIL') ;

-- OPTIONAL 
SELECT CITY FROM CUSTOMER WHERE CNAME = 'SUNIL' ;


-- Give names of depositors having the same living city as that of Mr. ANIL and having the deposit amount greater than 2000.

SELECT CNAME , DEPOSIT.AMOUNT FROM DEPOSIT
INNER JOIN BRANCH USING(BNAME) 
INNER JOIN CUSTOMER USING(CNAME)
WHERE DEPOSIT.AMOUNT > 2000
AND CUSTOMER.CITY = (SELECT CITY FROM CUSTOMER WHERE CNAME = 'ANIL') ;



-- Give names of borrowers having deposit amount greater than 1000 and loan amount greater than 20000

SELECT CNAME,DEPOSIT.AMOUNT AS DEPOSIT_AMOUNT ,BORROW.AMOUNT AS BORROW_AMOUNT 
FROM BORROW INNER JOIN DEPOSIT USING(CNAME)
WHERE DEPOSIT.AMOUNT>1000 AND BORROW.AMOUNT>20000;



-- Give names of depositors having the same branch as the branch of SUNIL

SELECT CNAME FROM DEPOSIT 
WHERE BNAME = (select BNAME from DEPOSIT where cname='SUNIL')
AND CNAME <> 'SUNIL' ;


-- Give names of borrowers having loan amount greater than the loan amount of Pramod

SELECT CNAME FROM BORROW
WHERE AMOUNT > (SELECT AMOUNT FROM BORROW WHERE CNAME='PRAMOD') 


-- Give names of customers living in the City where branch of Depositer SUNIL is located
--SUNIL KA BRANCH JIS CITY ME HAI US CITY ME JO BANDE HAIN USKA NAME CHAHIYE ;

SELECT CNAME , CITY AS LIVING_CITY 
FROM CUSTOMER WHERE
CITY = (SELECT CITY FROM BRANCH WHERE BRANCH.BNAME 
     = (SELECT BNAME FROM DEPOSIT WHERE CNAME='SUNIL')
) ;




-- Give loan number and loan amount of borrowers having the same branch as that of SUNIL
SELECT LOANNO , CNAME,AMOUNT FROM BORROW 
WHERE BNAME= (SELECT BNAME FROM BORROW WHERE CNAME = 'SUNIL')
AND CNAME <> 'SUNIL'

-- Give loan number, Loan Amount, Account number and deposit amount of customer having in city NAGPUR


SELECT ACTNO, LOANNO ,CNAME,BORROW.AMOUNT AS LOAN_AMOUNT,DEPOSIT.AMOUNT AS DEPOSIT_AMOUNT,CITY
FROM BORROW
INNER JOIN DEPOSIT USING(CNAME)
INNER JOIN CUSTOMER  USING(CNAME)
WHERE CUSTOMER.CITY='NAGPUR';





--  Give Loan number, Loan Amount, Account number and deposit amount of customer having branch located in Mumbai

SELECT
  B.LOANNO, B.AMOUNT AS LOAN_AMOUNT, 
  D.ACTNO AS ACCOUNT_NUMBER,
  D.AMOUNT AS DEPOSIT_AMOUNT
FROM BORROW B
  JOIN DEPOSIT D ON B.CNAME = D.CNAME
  JOIN BRANCH BR ON B.BNAME = BR.BNAME
WHERE BR.CITY = 'MUMBAI';

--  Give Loan number, Loan Amount, Account number, deposit amount, Branch Name, Branch City and Living City of Pramod
SELECT 
    D.ACTNO ,C.CNAME , B.LOANNO  , B.AMOUNT AS LOAN_AMOUNT , D.AMOUNT AS DEPOSIT_AMOUNT,
   BR.BNAME, C.CITY AS LIVING_CITY , BR.CITY AS BRANCH_CITY 
FROM
  CUSTOMER C INNER JOIN DEPOSIT D ON C.CNAME = D.CNAME
  INNER JOIN  BRANCH BR ON D.BNAME = BR.BNAME
  INNER JOIN BORROW B ON D.CNAME = B.CNAME
WHERE C.CNAME='PRAMOD'


--  Give deposit details and loan details of customer in the city where Pramod is living
SELECT 
 CNAME , BORROW.LOANNO ,
 BORROW.AMOUNT AS BORROW_AMOUNT ,
 DEPOSIT.ACTNO ,
 DEPOSIT.AMOUNT AS DEPOSIT_AMOUNT
FROM 
 DEPOSIT FULL OUTER JOIN BORROW USING(CNAME)
INNER JOIN CUSTOMER USING(CNAME) 
WHERE CUSTOMER.CITY = (SELECT CITY FROM CUSTOMER WHERE CNAME = 'PRAMOD')
AND CNAME <> 'PRAMOD'



--  Give names of depositors having the same branch city as that of Mr. SUNIL and having the same living city as that of Mr. ANIL
SELECT 
 CNAME 
FROM 
 CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
 INNER JOIN BRANCH USING(BNAME) 
WHERE CUSTOMER.CITY = (SELECT CITY FROM CUSTOMER WHERE CNAME = 'SUNIL')
AND BRANCH.CITY =
 (SELECT CITY  FROM DEPOSIT , BRANCH WHERE DEPOSIT.CNAME = 'ANIL' AND DEPOSIT.BNAME = BRANCH.BNAME ) 
AND CNAME <> 'SUNIL'



--  Give names of depositors having amount greater than 5000 and having the same living city as Mr. Pramod
SELECT CNAME FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
WHERE AMOUNT > 5000 
AND CITY = (select city from customer WHERE CNAME = 'PRAMOD')
AND CNAME <> 'PRAMOD'



--  Give city of customer having the same branch city as that of Mr. Pramod
SELECT CNAME FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
INNER JOIN BRANCH USING (BNAME) 
WHERE BRANCH.CITY = (SELECT CITY FROM BRANCH WHERE BNAME = (SELECT BNAME FROM DEPOSIT WHERE CNAME='PRAMOD'))



--  Give branch city and living city of Pramod
SELECT  BRANCH.CITY AS BRANCH_CITY, CUSTOMER.CITY AS LIVING_CITY  FROM 
CUSTOMER FULL JOIN DEPOSIT USING(CNAME)
INNER JOIN BRANCH USING(BNAME) 
INNER JOIN BORROW USING(CNAME)
WHERE CNAME = 'PRAMOD'





--  Give branch city of SUNIL and branch city of ANIL

SELECT CNAME, CITY AS BRANCH_CITY
FROM
  DEPOSIT INNER JOIN BRANCH USING(BNAME)
WHERE CNAME IN ('SUNIL', 'ANIL')




--  Give the living city of Mehul and the living City of 

SELECT CNAME,CITY AS LIVING_CITY FROM CUSTOMER 
WHERE CNAME IN('MEHUL','SANJANA');



*********************************
ASUR PART 4
*********************************
Assignment No. - 4

-- List all the customers who are depositers but not borrowers
select cname from 
DEPOSIT left join borrow using (cname)
where borrow.loanno IS NULL;


-- List all the customers who are both depositers and borrowers.
select cname , actno , loanno from deposit inner join borrow using(cname);

-- List all the customers, along with their amount who are either borrowers or depositers and living city NAGPUR
select cname , deposit.amount as deposit_amount , borrow.amount as borrow_amount FROM 
DEPOSIT FULL JOIN BORROW USING (CNAME)
FULL JOIN CUSTOMER USING(CNAME) 
WHERE CITY = 'NAGPUR'


-- List all the depositers having deposit in all the branches where SUNIL is having an account.
SELECT CNAME FROM 
DEPOSIT INNER JOIN BRANCH USING (BNAME)
WHERE CITY = (SELECT CITY  FROM 
              DEPOSIT INNER JOIN BRANCH USING (BNAME) 
              WHERE CNAME='SUNIL'
             )
AND CNAME <> 'SUNIL'



-- List all the customers living in City NAGPUR and having branch city Mumbai or Delhi
SELECT CNAME, CUSTOMER.CITY AS LIVING_CITY , BRANCH.CITY AS BRANCY_CITY FROM
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
INNER JOIN BRANCH USING(BNAME) 
WHERE BRANCH.CITY IN ('MUMBAI','DELHI')



-- List all the depositers living in city NAGPUR
SELECT CNAME, CUSTOMER.CITY AS LIVING_CITY FROM
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
WHERE CITY ='NAGPUR'




-- List all the depositers living in city NAGPUR and having branch in city Mumbai
SELECT CNAME, CUSTOMER.CITY AS LIVING_CITY , BRANCH.CITY AS BRANCY_CITY FROM
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
INNER JOIN BRANCH USING(BNAME)
WHERE CUSTOMER.CITY ='NAGPUR' AND BRANCH.CITY = 'MUMBAI'



-- List the branch city of ANIL and SUNIL
SELECT CNAME FROM DEPOSIT INNER JOIN BORROW USING(CNAME)
 WHERE DEPOSIT.AMOUNT > 1000 AND BORROW.AMOUNT < 10000 

 
-- List the customers having deposit greater than 1000 and loan less than 10000.
SELECT CNAME FROM DEPOSIT INNER JOIN BORROW USING(CNAME)
 WHERE DEPOSIT.AMOUNT > 1000 AND BORROW.AMOUNT < 10000 ;



-- List the borrowers having branch city same as that of Mr. SUNIL.
SELECT CNAME, CITY AS BRANCH_CITY 
FROM 
BORROW INNER JOIN BRANCH USING(BNAME)
WHERE 
CITY = (SELECT CITY FROM BRANCH INNER JOIN BORROW USING(BNAME) 
       WHERE CNAME = 'SUNIL'
       )
AND CNAME <> 'SUNIL'




-- List the cities of depositers having branch VRCE

SELECT CNAME ,CITY AS LIVING_CITY ,BNAME FROM DEPOSIT 
INNER JOIN CUSTOMER USING (CNAME)
WHERE BNAME = 'VRCE';

-- List the depositer having tha same living city as that of Mr. SUNIL and the same branch city as that of mr. SUNIL.

SELECT 
  CUSTOMER.CNAME ,
  CUSTOMER.CITY AS LIVING_CITY , 
  BRANCH.CITY AS BRANCH_CITY
FROM
 CUSTOMER INNER JOIN DEPOSIT ON CUSTOMER.CNAME= DEPOSIT.CNAME
 INNER JOIN BRANCH ON BRANCH.BNAME = DEPOSIT.BNAME
WHERE 
CUSTOMER.CITY = (SELECT CITY FROM CUSTOMER WHERE CNAME='SUNIL')
AND
BRANCH.CITY = (SELECT CITY FROM BRANCH INNER JOIN DEPOSIT USING(BNAME) WHERE CNAME = 'SUNIL')
AND CUSTOMER.CNAME <> 'SUNIL' ;



-- List the depositors having amount less than 1000 and living in the same city as Mr. ANIL


SELECT CNAME FROM DEPOSIT INNER JOIN CUSTOMER USING (CNAME) WHERE
AMOUNT < 1000  AND CITY = 
(SELECT CITY FROM CUSTOMER WHERE CNAME='ANIL')
AND CNAME <> 'ANIL'


-- List all the customers who are both depositors and borrowers and living in the same city as Mr. ANIL



SELECT CNAME FROM DEPOSIT INNER JOIN CUSTOMER USING (CNAME)
INNER JOIN BORROW USING(CNAME) 
WHERE 
CITY = (SELECT CITY FROM CUSTOMER WHERE CNAME='ANIL')
AND CNAME <> 'ANIL'




-- List all the cities where branches of ANIL and SUNIL are located

SELECT BRANCH.CITY FROM   
DEPOSIT INNER JOIN BRANCH USING (BNAME)
FULL JOIN BORROW USING(CNAME) 
WHERE 
BORROW.BNAME IN (SELECT BNAME FROM DEPOSIT WHERE CNAME IN ('ANIL','SUNIL'))




-- List all the customers name and amount for depositers living in the city where either ANIL or SUNIL is Living


SELECT CNAME , AMOUNT FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
WHERE CITY IN (SELECT CITY FROM CUSTOMER WHERE CNAME IN ('ANIL','SUNIL'))


-- List the amount for the depositers living in the city whete ANIL is living

SELECT CNAME AS DEPOSITOR , AMOUNT FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
WHERE CITY IN (SELECT CITY FROM CUSTOMER WHERE CNAME ='ANIL')


-- List the cities which are either branch city of ANIL or living city of SUNIL



SELECT CNAME, CUSTOMER.CITY AS LIVING_CITY , BRANCH.CITY AS BRANCH_CITY FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
FULL JOIN BRANCH USING(BNAME) 
WHERE BRANCH.CITY = 
(SELECT CITY FROM BRANCH INNER JOIN DEPOSIT USING(BNAME) WHERE CNAME = 'ANIL')
OR CUSTOMER.CITY = (SELECT CITY FROM CUSTOMER WHERE CNAME = 'SUNIL')

-- List the customers who are borrowers or depositers and having living city NAGPUR and branch city as that of Mr. SUNIL.

SELECT CNAME FROM BRANCH INNER JOIN DEPOSIT USING(BNAME)
INNER JOIN BORROW USING(CNAME)
INNER JOIN CUSTOMER USING(CNAME) 
WHERE CUSTOMER.CITY = 'NAGPUR' 
AND 
BRANCH.CITY = (SELECT CITY FROM BRANCH INNER JOIN DEPOSIT USING(BNAME) WHERE CNAME = 'SUNIL')



-- List the customers who are both borrowers and depositers and having the same branch city as that of Mr. ANIL.

SELECT CNAME 
FROM 
BRANCH INNER JOIN DEPOSIT USING(BNAME)
INNER JOIN BORROW USING(CNAME) 
WHERE 
CITY = (SELECT CITY FROM DEPOSIT INNER JOIN BRANCH USING(BNAME) WHERE CNAME = 'ANIL')


**********************************
-- Assignment No. - 5
-- asur 5
******************************

-- 1. List total loan
select sum(amount) as total_loan from borrow ;


-- 2. List total deposit
select sum(amount) as total_deposit from deposit;

-- 3. List total loan taken from KAROLBAGH branch.
SELECT SUM(AMOUNT) AS TOTAL_LOAN 
FROM 
BORROW INNER JOIN BRANCH USING (BNAME)
WHERE BNAME = 'KAROLBAGH'



-- 4. List total deposit of customer having account date later than 1 Jan 96.
SELECT CNAME ,SUM(AMOUNT) FROM  
DEPOSIT WHERE ADATE > DATE '1996-01-01' 
GROUP BY (CNAME,ADATE)


-- 5. List total deposit of customers living in city NAGPUR
SELECT 
CNAME , CITY , 
SUM(AMOUNT) AS TOTAL_DEPOSIT 
FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
WHERE CITY = 'NAGPUR'
GROUP BY CNAME, CITY ;

-- 6. List maximum deposit of customer living in Mumbai

SELECT MAX(AMOUNT) AS MAX_DEPOSIT_AMOUNT FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
WHERE CITY = 'MUMBAI'

-- 7. List total deposit of cutomers having branch city Delhi

SELECT BRANCH.CITY AS BRANCH_CITY , SUM(AMOUNT)
FROM
CUSTOMER INNER JOIN DEPOSIT USING(CNAME) 
INNER JOIN BRANCH USING(BNAME) 
WHERE BRANCH.CITY = 'DELHI'
GROUP BY BRANCH.CITY


-- 8. List total deposit of customers living in city where SUNIL is living.
SELECT CITY , SUM(AMOUNT) FROM
CUSTOMER INNER JOIN DEPOSIT USING (CNAME)
WHERE CITY =(SELECT CITY FROM CUSTOMER WHERE CNAME = 'SUNIL')
GROUP BY CITY ;



-- 9. Count total number of Branch cities
SELECT COUNT(DISTINCT CITY) NUMBER_OF_CITIES FROM 
BRANCH


-- 10. Count total number of Customer cities

SELECT COUNT(DISTINCT CITY) NUMBER_OF_CITIES FROM 
CUSTOMER


-- 11. Give branch name and branchwise deposit
SELECT BNAME , SUM (AMOUNT) FROM DEPOSIT 
GROUP BY BNAME


-- 12. Give city name and citywise deposit
SELECT CITY BRANCH_CITY, SUM(AMOUNT) TOTAL_DEPOSIT 
FROM
DEPOSIT INNER JOIN BRANCH USING(BNAME)
GROUP BY CITY 


-- 13. Give citywise name and branchwise deposit
SELECT CUSTOMER.CITY , CUSTOMER.CNAME , DEPOSIT.BNAME , SUM(DEPOSIT.AMOUNT) TOTAL_AMOUNT
FROM 
CUSTOMER INNER JOIN DEPOSIT ON CUSTOMER.CNAME = DEPOSIT.CNAME 
INNER JOIN BRANCH ON DEPOSIT.BNAME = BRANCH.BNAME 
GROUP BY CUSTOMER.CITY , DEPOSIT.BNAME , CUSTOMER.CNAME ;


-- 14. Give the branchwise deposit of customer after account date 1 Jan 96
SELECT C.CITY , C.CNAME , D.BNAME , SUM(D.AMOUNT) TOTAL_AMOUNT
FROM 
CUSTOMER C INNER JOIN DEPOSIT D ON C.CNAME = D.CNAME 
INNER JOIN BRANCH B ON D.BNAME = B.BNAME 
GROUP BY C.CITY , D.BNAME , C.CNAME ;



-- 15. Give branchwise loan of customer living in NAGPUR
SELECT BNAME , SUM(AMOUNT)
FROM 
BORROW INNER JOIN BRANCH USING(BNAME)
WHERE CITY = 'NAGPUR'
GROUP BY BNAME ;


-- 16. Count total number of Customers
SELECT COUNT(CNAME) FROM CUSTOMER ;

-- 17.  Count total number of depositors branch wise

SELECT BNAME, COUNT(CNAME) NUMBER_OF_DEPOSITOR FROM
DEPOSIT
GROUP BY BNAME 


-- 18. Give maximum loan from branch VRCE
SELECT BNAME, MAX(AMOUNT) NUMBER_OF_DEPOSITOR FROM BORROW 
WHERE BNAME = 'VRCE' GROUP BY BNAME



-- 19. Give living citywise loan of borrowers
SELECT CITY , SUM(AMOUNT) TOTAL_LOAN FROM 
CUSTOMER INNER JOIN BORROW USING (CNAME)
GROUP BY CITY 


-- 20. Give the number of customers who are depositers as well as borrowers
SELECT COUNT(CNAME) FROM DEPOSIT INNER JOIN BORROW USING(CNAME) 


*******************************************
-- Assignment No. - 6
-- Group by and Having
********************************************

--  List the branches having sum of deposit more than 50000
SELECT BNAME, SUM(AMOUNT) TOTAL_AMOUNT
FROM DEPOSIT GROUP BY BNAME HAVING SUM(AMOUNT) > 50000



--  List the branches having a sum of deposit more than 50000 and located in city Mumbai

SELECT BNAME, SUM(AMOUNT) TOTAL_AMOUNT
FROM DEPOSIT INNER JOIN CUSTOMER USING(CNAME)
WHERE CITY = 'MUMBAI'
GROUP BY BNAME HAVING SUM(AMOUNT) > 50000



--  List the names of customers having deposit in the branches where the average deposit is more
-- than 50000
SELECT CNAME FROM CUSTOMER INNER JOIN DEPOSIT USING (CNAME)
INNER JOIN(
SELECT BNAME , AVG(AMOUNT) AS AVG_AMOUNT FROM 
DEPOSIT GROUP BY BNAME HAVING AVG(AMOUNT) > 50000
) AVG_DEPOSITS ON DEPOSIT.BNAME = AVG_DEPOSITS.BNAME ;



--  List the names of customers having maximum deposit
SELECT CNAME , SUM(AMOUNT) FROM  DEPOSIT GROUP BY CNAME 
HAVING SUM(AMOUNT) =(
    SELECT MAX(SUM_AMOUNT) FROM (SELECT SUM(AMOUNT) AS SUM_AMOUNT FROM DEPOSIT GROUP BY CNAME )
)


-- or you can also use query below 
SELECT CNAME FROM DEPOSIT WHERE AMOUNT = (
SELECT MAX(AMOUNT) FROM DEPOSIT
)


--  List the names of customers having maximum deposit living in NAGPUR

SELECT CNAME FROM DEPOSIT INNER JOIN CUSTOMER USING (CNAME) 
WHERE  CITY = 'NAGPUR' AND AMOUNT = (
SELECT MAX(AMOUNT) FROM DEPOSIT
)


--  List the names of branches having the highest number of depositer

SELECT BNAME FROM DEPOSIT 
GROUP BY BNAME HAVING COUNT(AMOUNT) = (
SELECT MAX(NO_OF_DEPOSITS) AS MAX_NUM_OF_DEPOSIT 
FROM (
    SELECT COUNT(AMOUNT) AS NO_OF_DEPOSITS FROM DEPOSIT GROUP BY AMOUNT
    )
)



--  Count the number of depositors living in NAGPUR
SELECT COUNT(CNAME) AS NUMBER_OF_DEPOSITOR FROM 
CUSTOMER INNER JOIN DEPOSIT USING(CNAME)
WHERE CITY = 'NAGPUR'


--  Give names of customers in VRCE branch having more deposit than all customer from SB
-- branch Andheri
SELECT CNAME FROM DEPOSIT 
WHERE BNAME = 'VRCE' 
AND AMOUNT > (
SELECT SUM(AMOUNT) FROM DEPOSIT WHERE BNAME='ANDHERI' 
GROUP BY BNAME
)


--  Give names of customers in VRCE branch having more deposit than any other customer in
-- Andheri branch
SELECT CNAME FROM DEPOSIT 
WHERE BNAME = 'VRCE' 
AND AMOUNT > (
SELECT MAX(AMOUNT) FROM DEPOSIT WHERE BNAME='ANDHERI' 
)



--  Give names of customers having highest deposit in the branch where SUNIL is having deposit

SELECT CNAME FROM DEPOSIT WHERE AMOUNT = (
   SELECT MAX(AMOUNT) FROM DEPOSIT WHERE BNAME=(
      SELECT BNAME FROM DEPOSIT WHERE CNAME = 'SUNIL'
    )
) AND BNAME = ( SELECT BNAME FROM DEPOSIT WHERE CNAME = 'SUNIL')
  AND CNAME <> 'SUNIL'

  
--  Give names of customers having highest deposit in the city where branch of SUNIL is located

SELECT CNAME FROM DEPOSIT WHERE AMOUNT = (
   SELECT MAX(AMOUNT) FROM DEPOSIT INNER JOIN BRANCH USING(BNAME) WHERE CITY=(
      SELECT CITY FROM DEPOSIT INNER JOIN BRANCH USING(BNAME) WHERE CNAME = 'SUNIL'
    )
)



--  Give names of customers having more deposit than the average deposit in their respective
-- branches.
SELECT CNAME,BNAME,  AMOUNT , AVG_DEPOSIT FROM DEPOSIT INNER JOIN (
    SELECT BNAME , AVG(AMOUNT) AS AVG_DEPOSIT FROM DEPOSIT 
    GROUP BY BNAME 
) AVG_DEPOSIT USING(BNAME) 
WHERE AMOUNT > AVG_DEPOSIT 


--  Give names of customers having maximum deposit among deposits of NAGPUR for branch VRCE.
***** SIR KO PUCHNA HAI

--  Give name of branch where number of depositers is more than 5.
SELECT BNAME , COUNT(CNAME) FROM DEPOSIT 
GROUP BY BNAME HAVING COUNT(CNAME) > 5 ;


--  Give name of city having more customers living in than NAGPUR
SELECT CITY , COUNT(CITY) FROM CUSTOMER 
GROUP BY CITY HAVING COUNT(CITY) > (
SELECT COUNT(CITY) FROM CUSTOMER 
WHERE CITY = 'NAGPUR'
GROUP BY CITY 
)


--  Give names of branches having the number of depositers more than the number of borrowers.
SELECT DEPOSIT.BNAME, COUNT(DEPOSIT.BNAME) FROM DEPOSIT 
FULL JOIN BORROW USING (CNAME) 
GROUP BY DEPOSIT.BNAME 
HAVING COUNT(DEPOSIT.BNAME) > COUNT(BORROW.BNAME);


--  Give the names of cities in which the maximum number of branches are located.

SELECT CITY FROM BRANCH INNER JOIN 
(SELECT BNAME FROM DEPOSIT 
 GROUP BY BNAME 
  HAVING COUNT(BNAME) = (
      SELECT MAX(COUNT(BNAME)) AS MAX_BNAME FROM DEPOSIT GROUP BY BNAME 
  )
) MAX_COUNT_BNAME USING(BNAME)



--  Give the names of customers living in the city where the maximum number of depositers are located
SELECT CNAME FROM CUSTOMER WHERE CITY =(
SELECT CITY FROM CUSTOMER 
  GROUP BY CITY HAVING COUNT(CITY) =(
    SELECT MAX(COUNT(CITY)) FROM CUSTOMER
    INNER JOIN DEPOSIT USING(CNAME) GROUP BY CITY
  )
)


--  Give the name of borrowers having the same branch city and highest borrowers.

SELECT CNAME , CUSTOMER.CITY FROM 
  BRANCH INNER JOIN (
     SELECT CNAME, BNAME FROM BORROW WHERE AMOUNT =(
        SELECT MAX(AMOUNT) FROM BORROW )
  )
 MAX_BORROW_BNAME USING(BNAME) 
INNER JOIN CUSTOMER USING(CNAME) ;



--  Count the number of customers living in the city where branch is located
SELECT COUNT(CNAME) CUSTOMER_IN_BRANCH_CITIES FROM CUSTOMER 
WHERE CITY IN(
   SELECT DISTINCT CITY FROM BRANCH
)



-- Assignment No. - 7
-- The Update statement
-- 1. Give 10% interest to all depositers
  
  
UPDATE DEPOSIT
SET AMOUNT = AMOUNT * 1.10;


-- 2. Give 10% interest to all depositers having branch VRCE
-- 3. Give 10% interest to all depositers living in NAGPUR
-- 4. Give 10% interest to all depositers living in NAGPUR and having branch in city Mumbai
-- 5. Add hundred rupees to the deposit of ANIL and assign it to SUNIL.
-- 6. Change the deposit of VRCE branch to 1000 and change the branch as VRCE-Ambazari
-- 7. Assign to the deposit of ANIL the maximum deposit from VRCE branch
-- 8. Change the living city of VRCE branch Borrowers to NAGPUR.
-- 9. Update deposit of ANIL, give him maximum deposit from depositors in living city NAGPUR
-- 10. Deposit the sum of the deposits of SUNIL and VIJAY in the account of ANIL.
-- 11. Transfer Rs. 500 from the account of ANIL to the account of SUNIL
-- 12. Transfer Rs. 500 from the account of ANIL to the account of SUNIL if both are having the same
-- branch.
-- 13. Transfer Rs. 10 from the account of ANIL to the account of SUNIL if both are living in NAGPUR.
-- 14. Transfer Rs. 10 from the account of ANIL to the account of SUNIL if they are living in the same
-- city.
-- 15. Transfer Rs. 10 from the account of ANIL to the account of SUNIL if they are having the same
-- branches.
-- 16. Add Rs. 1000 to the account of all those depositers who are having the highest deposit amount
-- in their respective branches.
-- 17. Add Rs. 100 to the amount of all depositers having deposit higher than the average deposit.
-- 18. Add Rs. 100 to the amount of all depositers having deposit higher than the average deposit of
-- their branch
-- 19. Add Rs. 100 to the amount of all customers living in the city where their branch is located
-- 20. Add Rs. 100 to the amount of all depositers having deposit higher than the average deposit of
-- their branch.
-- Assignment No. - 8
-- The Delete Statement
-- 1. Delete depositers of branches having the number of customer between 1 and 3
-- 2. Delete branches having average deposit less than 5000
-- 3. Delete the branches having maximum loan more than 5000
-- 4. Delete branches of having deposit from NAGPUR
-- 5. Delete deposit of ANIL and SUNIL if both are having branch VIRAR
-- 6. Delete deposit of ANIL and SUNIL if both are having living city NAGPUR
-- 7. Delete deposit of ANIL and SUNIL if both are having same living city
-- 8. Delete deposit of ANIL and SUNIL if both are having less deposit than VIJAY
-- 9. Delete deposit of VIJAY
-- 10. Delete customer from BOMBAY City
-- 11. Delete depositer if the branch is VIRAR and depositer name is AJAY
-- 12. Delete depositer having deposit less than 5000
-- 13. Delete borrower having loan more than 1000 and branch KAROLBAGH
-- 14. Delete the names of those depositers of VRCE branch who live in city BOMBAY




assignOne
7th sub-assignment 

1. update Deposit  set amount=amount*1.10;



2. update Deposit  set amount=amount*1.10 where bname='VRCE';


3. update deposit set amount=amount*1.10 where cname IN (select cname from customer where city = 'NAGPUR');


4. UPDATE DEPOSIT  SET AMOUNT=AMOUNT*1.10 WHERE CNAME In (select cname from customer where city = 'NAGPUR') AND BNAME IN (select bname from branch where city = 'MUMBAI');

5.update deposit set amount=amount+100 where cname = 'ANIL' OR cname = 'SUNIL';

6.update deposit set amount=1000, bname='VRCE-Ambazari' where bname = 'VRCE';

7.update deposit set amount = (select max(amount) from deposit where bname = 'VRCE') where cname = 'ANIL'; 

8. update customer set city = 'NAGPUR' where cname in (select cname from borrow where bname = 'VRCE');


9
UPDATE DEPOSIT
SET AMOUNT = (
  SELECT MAX(AMOUNT)
  FROM DEPOSIT D
  JOIN CUSTOMER C ON D.CNAME = C.CNAME
  WHERE C.CITY = 'NAGPUR'
)
WHERE CNAME = 'ANIL';

10.




UPDATE DEPOSIT
SET AMOUNT = AMOUNT + (
  SELECT SUM(AMOUNT)
  FROM DEPOSIT
  WHERE CNAME IN ('SUNIL', 'VIJAY')
)
WHERE CNAME = 'ANIL';




11.
UPDATE DEPOSIT
SET AMOUNT = AMOUNT - 500
WHERE CNAME = 'ANIL';

UPDATE DEPOSIT
SET AMOUNT = AMOUNT + 500
WHERE CNAME = 'SUNIL';



12.




UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT - 500
WHERE A.CNAME = 'ANIL'
  AND EXISTS (
    SELECT 1
    FROM DEPOSIT B
    WHERE B.CNAME = 'SUNIL'
      AND B.BNAME = A.BNAME
);


13.

UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT - 10
WHERE A.CNAME = 'ANIL'
  AND EXISTS (
    SELECT 1
    FROM CUSTOMER C
    WHERE C.CNAME = 'SUNIL'
      AND C.CITY = 'NAGPUR'
);




14.


UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT - 10
WHERE A.CNAME = 'ANIL'
  AND EXISTS (
    SELECT 1
    FROM CUSTOMER C
    WHERE C.CNAME = 'SUNIL'
      AND C.CITY = A.CITY
)
AND A.AMOUNT >= 10


15.




UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT - 10
WHERE A.CNAME = 'ANIL'
  AND EXISTS (
    SELECT 1
    FROM DEPOSIT B
    WHERE B.CNAME = 'SUNIL'
      AND B.BNAME = A.BNAME
);


16.

UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT + 1000
WHERE A.AMOUNT = (
  SELECT MAX(B.AMOUNT)
  FROM DEPOSIT B
  WHERE B.BNAME = A.BNAME
);



17.


UPDATE DEPOSIT
SET AMOUNT = AMOUNT + 100
WHERE AMOUNT > (
  SELECT AVG(AMOUNT)
  FROM DEPOSIT
);


18.


UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT + 100
WHERE A.AMOUNT > (
  SELECT AVG(B.AMOUNT)
  FROM DEPOSIT B
  WHERE B.BNAME = A.BNAME
);


19.

UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT + 100
WHERE A.CITY = (
  SELECT B.CITY
  FROM BRANCH B
  WHERE B.BNAME = A.BNAME
);



20.
UPDATE DEPOSIT A
SET A.AMOUNT = A.AMOUNT + 100
WHERE A.AMOUNT > (
  SELECT AVG(B.AMOUNT)
  FROM DEPOSIT B
  WHERE B.BNAME = A.BNAME
);





DELETE queries

1


DELETE FROM DEPOSIT
WHERE BNAME IN (
    SELECT B.BNAME
    FROM BRANCH B
    JOIN CUSTOMER C ON B.BNAME = C.BNAME
    GROUP BY B.BNAME
    HAVING COUNT(C.CNAME) BETWEEN 1 AND 3
);


2


DELETE FROM BRANCH
WHERE BNAME IN (
    SELECT B.BNAME
    FROM BRANCH B
    JOIN DEPOSIT D ON B.BNAME = D.BNAME
    GROUP BY B.BNAME
    HAVING AVG(D.AMOUNT) < 5000
);



3.


DELETE FROM BRANCH
WHERE BNAME IN (
    SELECT B.BNAME
    FROM BRANCH B
    JOIN BORROW L ON B.BNAME = L.BNAME
    GROUP BY B.BNAME
    HAVING MAX(L.AMOUNT) > 5000
);


DELETE FROM BRANCH
WHERE BNAME IN (
    SELECT B.BNAME
    FROM BRANCH B
    WHERE B.CITY = 'NAGPUR'
);




DELETE FROM DEPOSIT
WHERE (CNAME = 'ANIL' OR CNAME = 'SUNIL')
  AND BNAME = 'VIRAR';





DELETE FROM DEPOSIT
WHERE (CNAME = 'ANIL' OR CNAME = 'SUNIL')
  AND CITY = 'NAGPUR';





DELETE FROM DEPOSIT
WHERE CNAME IN ('ANIL', 'SUNIL')
  AND CITY IN (
    SELECT CITY
    FROM CUSTOMER
    WHERE CNAME IN ('ANIL', 'SUNIL')
    GROUP BY CITY
    HAVING COUNT(*) > 1
);




DELETE FROM DEPOSIT
WHERE CNAME IN ('ANIL', 'SUNIL')
  AND AMOUNT < (
    SELECT MIN(AMOUNT)
    FROM DEPOSIT
    WHERE CNAME = 'VIJAY'
);





DELETE FROM DEPOSIT
WHERE CNAME = 'VIJAY';


DELETE FROM CUSTOMER
WHERE CITY = 'BOMBAY';




DELETE FROM DEPOSIT
WHERE CNAME = 'AJAY'
  AND BNAME = 'VIRAR';






DELETE FROM DEPOSIT
WHERE AMOUNT < 5000;





DELETE FROM BORROW
WHERE AMOUNT > 1000
  AND BNAME = 'KAROLBAGH';






DELETE FROM DEPOSIT
WHERE BNAME = 'VRCE'
  AND CITY = 'BOMBAY';
