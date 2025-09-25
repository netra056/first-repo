
use librarydb;


create table authors(
authorId int primary key,
name varchar(200)
);




insert into authors values('1','darshit');
insert into authors values('2','pranshul');
insert into authors values('3','mahesh');
insert into authors values('4','guru');

select * from authors

create table Books1(
isbn int primary key,
title varchar(255),
publicationdate date,
authorId int foreign key references authors(authorId),
bookId int);


insert into Books1 values('2345','english','2023-04-06','1','10');
insert into Books1 values('6789','maths','2024-06-09','2','20');
insert into Books1 values('1234','science','2021-08-07','3','30');
insert into Books1 values('5678','gk','2020-08-09','4','40');

select * from Books1

create table patrons1(
patronId int primary key,
pname varchar(250)
)


insert into patrons1 values('101','anu');
insert into patrons1 values('102','manu');
insert into patrons1 values('103','sanu');
insert into patrons1 values('104','ganu');

select * from patrons

create table transactions1(
transId int primary key,
bookId int foreign key references books(isbn),
patronId int foreign key references patrons(patronId),
duedate date

)

insert into transactions1 values('267788','2345','101','2025-08-09');
insert into transactions1 values('876545','6789','102','2025-05-09');
insert into transactions1 values('287435','1234','103','2025-08-04');
insert into transactions1 values('269878','5678','101','2025-04-05');

select * from transactions1


/*first Normal Form (1NF):

In the First Normal Form, each table should have a primary key, and there should be no repeating groups or arrays in any column. 
Our initial tables already satisfy 1NF because they have primary keys, and each cell contains a single value.

Second Normal Form (2NF):

To achieve 2NF, we need to ensure that non-key attributes depend on the entire primary key. 
In our initial tables, the Books table has partial dependency because Title and PublicationDate depend only on ISBN, not the entire primary key.
We willl split the Books table into two tables:*/

--Books (2NF):

create table book_auth(
isbn int primary key,
authorId int foreign key(authorId) references authors(authorId)
);
select * from authors

--BookDetails (2NF):

create table bookdetails(
isbn int foreign key(isbn) references Books1(isbn),
title varchar(255),
publicationdate date
);

select * from bookdetails;



--now each table has attributes that depend on the entire primary key.
--Third Normal Form (3NF):

--In 3NF, we eliminate transitive dependencies. 
--The Patrons table has no transitive dependencies, but the Transactions table has a transitive dependency on Books through the BookID. 
--To remove this dependency, we’ll create a new table for transactions:

--Now, the Transactions table only depends on the PatronID, and the BorrowedBooks table manages the relationship between transactions and books.

--Our normalized tables in 3NF are as follows:


--By following the normalization process to 3NF, 
--we’ve improved data integrity, reduced redundancy, and eliminated undesirable dependencies, resulting in a well-structured and normalized library system database.


CREATE TABLE author2 (
authorID INT PRIMARY KEY,
Name VARCHAR(255)
);

--Table for Books
CREATE TABLE Books2 (
ISBN VARCHAR(13) PRIMARY KEY,
AuthorID INT,
FOREIGN KEY (AuthorID) REFERENCES authors(AuthorID)
);

--Table for BookDetails
CREATE TABLE BookDetails1 (
ISBN int,
Title VARCHAR(255),
PublicationDate DATE,
FOREIGN KEY (ISBN) REFERENCES Books1(ISBN)
);

--Table for Patrons
CREATE TABLE Patrons2 (
PatronID INT PRIMARY KEY,
Name VARCHAR(255)
);

--Table for Transactions
CREATE TABLE Transactions2 (
TransactionID INT PRIMARY KEY,
PatronID INT,
DueDate DATE,
FOREIGN KEY (PatronID) REFERENCES Patrons1(PatronID)
);

--Table for BorrowedBooks (to represent the many-to-many relationship between Transactions and Books)
CREATE TABLE BorrowedBooks (
TransactionID INT,
ISBN int,
FOREIGN KEY (TransactionID) REFERENCES Transactions2(TransactionID),
FOREIGN KEY (ISBN) REFERENCES Books1(ISBN)
);

/*Conclusion
Designing a database for a library management system is a complex but essential task.
By starting with an ERD, normalizing the data, and then creating a well-structured database schema, 
you can ensure data integrity, reduce redundancy, and optimize database performance.
This structured approach lays the foundation for a reliable and efficient library system that can effectively manage books, authors, patrons, and transactions.*/


















