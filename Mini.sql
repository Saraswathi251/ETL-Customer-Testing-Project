create database mini;
use mini;
create table customer_source(
customer_id varchar(50) primary key,
customer_name varchar(40) not null,
email_id varchar(40),
city varchar(40),
country varchar(40),
Registration_date date);
desc customer_source;
drop table customer_source;


INSERT INTO customer_source
(customer_id, customer_name, email_id, city, country, Registration_date)
VALUES
('CUST001','John Smith','john.smith@gmail.com','New York','USA','2024-01-05'),
('CUST002','Emma Johnson','emma.j@gmail.com','London','UK','2024-01-08'),
('CUST003','Michael Brown','michael.b@gmail.com','Toronto','Canada','2024-01-10'),
('CUST004','Sophia Davis','sophia.d@gmail.com','Sydney','Australia','2024-01-12'),
('CUST005','William Wilson','william.w@gmail.com','Berlin','Germany','2024-01-15'),
('CUST006','Olivia Moore','olivia.m@gmail.com','Paris','France','2024-01-18'),
('CUST007','James Taylor','james.t@gmail.com','Rome','Italy','2024-01-20'),
('CUST008','Ava Anderson','ava.a@gmail.com','Madrid','Spain','2024-01-22'),
('CUST009','Benjamin Thomas','ben.t@gmail.com','Tokyo','Japan','2024-01-25'),
('CUST010','Isabella Jackson','isabella.j@gmail.com','Seoul','South Korea','2024-01-28'),
('CUST011','Lucas White','lucas.w@gmail.com','Mumbai','India','2024-02-01'),
('CUST012','Mia Harris','mia.h@gmail.com','Chennai','India','2024-02-03'),
('CUST013','Henry Martin','henry.m@gmail.com','Bangalore','India','2024-02-05'),
('CUST014','Charlotte Thompson','charlotte.t@gmail.com','Hyderabad','India','2024-02-07'),
('CUST015','Alexander Garcia','alex.g@gmail.com','Delhi','India','2024-02-10'),
('CUST016','Amelia Martinez','amelia.m@gmail.com','Dubai','UAE','2024-02-12'),
('CUST017','Daniel Robinson','daniel.r@gmail.com','Singapore','Singapore','2024-02-15'),
('CUST018','Harper Clark','harper.c@gmail.com','Kuala Lumpur','Malaysia','2024-02-18'),
('CUST019','Matthew Rodriguez','matt.r@gmail.com','Bangkok','Thailand','2024-02-20'),
('CUST020','Evelyn Lewis','evelyn.l@gmail.com','Jakarta','Indonesia','2024-02-22'),
('CUST021','David Lee','david.l@gmail.com','Beijing','China','2024-02-25'),
('CUST022','Abigail Walker','abigail.w@gmail.com','Shanghai','China','2024-02-28'),
('CUST023','Joseph Hall','joseph.h@gmail.com','Moscow','Russia','2024-03-02'),
('CUST024','Emily Allen','emily.a@gmail.com','Istanbul','Turkey','2024-03-04'),
('CUST025','Samuel Young','samuel.y@gmail.com','Athens','Greece','2024-03-06'),
('CUST026','Elizabeth King','elizabeth.k@gmail.com','Lisbon','Portugal','2024-03-08'),
('CUST027','Christopher Wright','chris.w@gmail.com','Vienna','Austria','2024-03-10'),
('CUST028','Sofia Scott','sofia.s@gmail.com','Prague','Czech Republic','2024-03-12'),
('CUST029','Andrew Green','andrew.g@gmail.com','Warsaw','Poland','2024-03-14'),
('CUST030','Avery Baker','avery.b@gmail.com','Brussels','Belgium','2024-03-16'),
('CUST031','Joshua Nelson','josh.n@gmail.com','Amsterdam','Netherlands','2024-03-18'),
('CUST032','Ella Carter','ella.c@gmail.com','Stockholm','Sweden','2024-03-20'),
('CUST033','Ryan Mitchell','ryan.m@gmail.com','Oslo','Norway','2024-03-22'),
('CUST034','Scarlett Perez','scarlett.p@gmail.com','Helsinki','Finland','2024-03-24'),
('CUST035','Nathan Roberts','nathan.r@gmail.com','Copenhagen','Denmark','2024-03-26'),
('CUST036','Grace Turner','grace.t@gmail.com','Dublin','Ireland','2024-03-28'),
('CUST037','Aaron Phillips','aaron.p@gmail.com','Zurich','Switzerland','2024-03-30'),
('CUST038','Chloe Campbell','chloe.c@gmail.com','Budapest','Hungary','2024-04-02'),
('CUST039','Christian Parker','christian.p@gmail.com','Bucharest','Romania','2024-04-04'),
('CUST040','Victoria Evans','victoria.e@gmail.com','Sofia','Bulgaria','2024-04-06'),
('CUST041','Jonathan Edwards','jonathan.e@gmail.com','Cape Town','South Africa','2024-04-08'),
('CUST042','Lily Collins','lily.c@gmail.com','Nairobi','Kenya','2024-04-10'),
('CUST043','Gabriel Stewart','gabriel.s@gmail.com','Lagos','Nigeria','2024-04-12'),
('CUST044','Hannah Morris','hannah.m@gmail.com','Cairo','Egypt','2024-04-14'),
('CUST045','Jack Rogers','jack.r@gmail.com','Doha','Qatar','2024-04-16'),
('CUST046','Zoe Reed','zoe.r@gmail.com','Riyadh','Saudi Arabia','2024-04-18'),
('CUST047','Julian Cook','julian.c@gmail.com','Auckland','New Zealand','2024-04-20'),
('CUST048','Aria Morgan','aria.m@gmail.com','Melbourne','Australia','2024-04-22'),
('CUST049','Levi Bell','levi.b@gmail.com','Perth','Australia','2024-04-24'),
('CUST050','Nora Murphy','nora.m@gmail.com','Brisbane','Australia','2024-04-26');

select *from mini.customer_source;
SELECT *
INTO OUTFILE '/tmp/customer_source.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM customer_source;

#transformation logic
SELECT
customer_id,
UPPER(customer_name) AS customer_name,
IFNULL(TRIM(email_id),'NA') AS email_address,
city,
country,
registration_date
FROM customer_source;

insert into ecom_tar.order_target
(order_id,customer_id,amount,order_status,order_date,loaded_date)
select
order_id, 
customer_id,
case 
-- when amount<0 then "Negative amount"
when amount is null then "unknown"
else amount
END as amount,
order_status,
case
 when order_date is null  then curdate()
    else order_date
end as order_date,
now()
from ecom_src.order_src
where order_status = "pending";


CREATE TABLE CUSTOMER_TARGET (
    CUSTOMER_ID VARCHAR(50),
    CUSTOMER_NAME VARCHAR(40),
    EMAIL_ADDRESS VARCHAR(40),
    CITY VARCHAR(40),
    COUNTRY VARCHAR(40),
    REGISTRATION_DATE DATE
);