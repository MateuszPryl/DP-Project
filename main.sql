/*
    # Section 1    
    DB and tables creation
*/

-- Create DB
CREATE DATABASE Hotel;

-- Create tables

CREATE TABLE Employees (
  employee_id NUMBER(10) PRIMARY KEY,
  name VARCHAR2(50) NOT NULL,
  surname VARCHAR2(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  date_of_hiring DATE NOT NULL,
  job_id NUMBER(10) NOT NULL,
  salary NUMBER(10, 2) NOT NULL
);

CREATE TABLE Rooms (
  room_id NUMBER(10) PRIMARY KEY,
  floor NUMBER(2) NOT NULL,
  capacity NUMBER(2) NOT NULL,
  type VARCHAR2(50) NOT NULL,
  price_per_day NUMBER(10, 2) NOT NULL
);

CREATE TABLE Guests (
  guest_id NUMBER(10) PRIMARY KEY,
  name VARCHAR2(50) NOT NULL,
  surname VARCHAR2(50) NOT NULL,
  security_number VARCHAR2(20) NOT NULL,
  date_of_birth DATE NOT NULL,
  address VARCHAR2(100) NOT NULL,
  age NUMBER(3) NOT NULL,
  email VARCHAR2(100) NOT NULL
);

CREATE TABLE Jobs (
  job_id NUMBER(10) PRIMARY KEY,
  job_title VARCHAR2(50) NOT NULL,
  salary_min NUMBER(10, 2) NOT NULL,
  salary_max NUMBER(10, 2) NOT NULL
);

CREATE TABLE Bookings (
  booking_id NUMBER(10) PRIMARY KEY,
  guest_id NUMBER(10) NOT NULL,
  room_id NUMBER(10) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  responsible_employee_id NUMBER(10) NOT NULL,
  total_price NUMBER(10, 2) NOT NULL,
  payment_type VARCHAR2(50) NOT NULL,

  CONSTRAINT fk_guest_id FOREIGN KEY (guest_id)
    REFERENCES Guests (guest_id),
  CONSTRAINT fk_room_id FOREIGN KEY (room_id)
    REFERENCES Rooms (room_id),
  CONSTRAINT fk_employee_id FOREIGN KEY (responsible_employee_id)
    REFERENCES Employees (employee_id)
);

CREATE TABLE Bookings_history (
  booking_id NUMBER(10) PRIMARY KEY,
  guest_id NUMBER(10) NOT NULL,
  room_id NUMBER(10) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  responsible_employee_id NUMBER(10) NOT NULL,
  total_price NUMBER(10, 2) NOT NULL,
  payment_type VARCHAR2(50) NOT NULL,
  review VARCHAR2(500),

  CONSTRAINT fk_guest_id FOREIGN KEY (guest_id)
    REFERENCES Guests (guest_id),
  CONSTRAINT fk_room_id FOREIGN KEY (room_id)
    REFERENCES Rooms (room_id),
  CONSTRAINT fk_employee_id FOREIGN KEY (responsible_employee_id)
    REFERENCES Employees (employee_id)
);

CREATE TABLE Employees_history (
  employee_id NUMBER(10) PRIMARY KEY,
  name VARCHAR2(50) NOT NULL,
  surname VARCHAR2(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  date_of_hiring DATE NOT NULL,
  job_id NUMBER(10) NOT NULL,
  salary NUMBER(10, 2) NOT NULL,
  fired_date DATE,
  CONSTRAINT fk_job_id FOREIGN KEY (job_id)
    REFERENCES Jobs (job_id)
);


/*
    # Section 2
    Tables population
*/

INSERT INTO Jobs (job_id, job_title, salary_min, salary_max)
VALUES
  (1, 'Front Desk Receptionist', 40000.00, 60000.00),
  (2, 'Housekeeper', 35000.00, 55000.00),
  (3, 'Manager', 70000.00, 120000.00),
  (4, 'Chef', 45000.00, 80000.00),
  (5, 'Bartender', 30000.00, 50000.00);

INSERT INTO Employees (employee_id, name, surname, date_of_birth, date_of_hiring, job_id, salary)
VALUES
  (1, 'John', 'Doe', TO_DATE('1990-05-15', 'yyyy-mm-dd'), TO_DATE('2015-03-01', 'yyyy-mm-dd'), 5, 50000.00),
  (2, 'Jane', 'Doe', TO_DATE('1992-08-27', 'yyyy-mm-dd'), TO_DATE('2016-01-01', 'yyyy-mm-dd'), 2, 35000.00),
  (3, 'Robert', 'Smith', TO_DATE('1985-12-10', 'yyyy-mm-dd'), TO_DATE('2014-06-01', 'yyyy-mm-dd'), 3, 75000.00),
  (4, 'Linda', 'Johnson', TO_DATE('1987-04-22', 'yyyy-mm-dd'), TO_DATE('2017-02-01', 'yyyy-mm-dd'), 2, 52500.00),
  (5, 'David', 'Lee', TO_DATE('1993-10-05', 'yyyy-mm-dd'), TO_DATE('2018-05-01', 'yyyy-mm-dd'), 4, 68000.00),
  (6, 'Mary', 'Kim', TO_DATE('1991-06-20', 'yyyy-mm-dd'), TO_DATE('2019-01-01', 'yyyy-mm-dd'), 5, 45000.00),
  (7, 'Michael', 'Johnson', TO_DATE('1988-02-01', 'yyyy-mm-dd'), TO_DATE('2015-07-01', 'yyyy-mm-dd'), 1, 60000.00),
  (8, 'Emily', 'Smith', TO_DATE('1994-11-15', 'yyyy-mm-dd'), TO_DATE('2017-12-01', 'yyyy-mm-dd'), 3, 100000.00),
  (9, 'William', 'Brown', TO_DATE('1986-09-03', 'yyyy-mm-dd'), TO_DATE('2016-06-01', 'yyyy-mm-dd'), 3, 85000.00),
  (10, 'Sophia', 'Davis', TO_DATE('1990-03-25', 'yyyy-mm-dd'), TO_DATE('2018-09-01', 'yyyy-mm-dd'), 1, 55000.00);

INSERT INTO Guests (guest_id, name, surname, security_number, date_of_birth, address, age, email)
VALUES
  (1, 'Jan', 'Kowalski', '123456789', TO_DATE('1990-05-15', 'yyyy-mm-dd'), '123 Main St, Anytown USA', 31, 'jandoe@example.com'),
  (2, 'Lukasz', 'Doe', '987654321', TO_DATE('1968-04-20', 'yyyy-mm-dd'), '456 Wiskitno St, Lodz PL', 29, 'lukaszdoe@example.com'),
  (3, 'Ola', 'Smith', '2468101214', TO_DATE('1975-02-14', 'yyyy-mm-dd'), '789 First Ave, SomeTown PL', 36, 'osmith@example.com'),
  (4, 'Mateusz', 'Jones', '3691215182', TO_DATE('2000-12-03', 'yyyy-mm-dd'), '321 Second St, Anytown PL', 28, 'mjones@example.com'),
  (5, 'David', 'Lee', '5813213245', TO_DATE('1995-06-10', 'yyyy-mm-dd'), '987 Elm St, Anytown USA', 26, 'dlee@example.com'),
  (6, 'Emily', 'Wilson', '543216789', TO_DATE('1988-07-01', 'yyyy-mm-dd'), '123 Main St, Anytown USA', 33, 'emilywilson@example.com'),
  (7, 'Ryan', 'Johnson', '123456789', TO_DATE('1992-09-03', 'yyyy-mm-dd'), '456 Broad St, Anytown USA', 29, 'ryanjohnson@example.com'),
  (8, 'Sophie', 'Garcia', '987654321', TO_DATE('1995-02-14', 'yyyy-mm-dd'), '789 First Ave, Anytown USA', 26, 'sophiegarcia@example.com'),
  (9, 'William', 'Brown', '2468101214', TO_DATE('1987-12-03', 'yyyy-mm-dd'), '321 Second St, Anytown USA', 34, 'williambrown@example.com'),
  (10, 'Olivia', 'Davis', '3691215182', TO_DATE('1991-06-21', 'yyyy-mm-dd'), '987 Elm St, Anytown USA', 30, 'oliviadavis@example.com'),
  (11, 'Noah', 'Taylor', '5813213245', TO_DATE('1993-11-10', 'yyyy-mm-dd'), '555 Fifth Ave, Anytown USA', 28, 'noahtaylor@example.com'),
  (12, 'Avery', 'Wilson', '234567890', TO_DATE('1989-05-12', 'yyyy-mm-dd'), '246 Oak St, Anytown USA', 32, 'averywilson@example.com'),
  (13, 'Ethan', 'Harris', '987654321', TO_DATE('1998-09-21', 'yyyy-mm-dd'), '789 Elmwood Dr, Anytown USA', 23, 'ethanharris@example.com'),
  (14, 'Emma', 'Clark', '123456789', TO_DATE('1995-03-05', 'yyyy-mm-dd'), '321 Pine St, Anytown USA', 26, 'emmaclark@example.com'),
  (15, 'Alexander', 'Lewis', '987654321', TO_DATE('1984-02-14', 'yyyy-mm-dd'), '444 Maple Ave, Anytown USA', 37, 'alexanderlewis@example.com');

INSERT INTO Rooms (room_id, floor, capacity, type, price_per_day)
VALUES
  (101, 1, 2, 'Standard double bed', 50),
  (102, 1, 2, 'Standard double bed', 50),
  (103, 1, 2, 'Standard double bed', 50),
  (104, 1, 2, 'Deluxe king bed', 75),
  (105, 1, 2, 'Deluxe king bed', 75),
  (106, 1, 2, 'Deluxe king bed', 75),
  (201, 2, 3, 'Executive Suite', 100),
  (202, 2, 3, 'Executive Suite', 100),
  (203, 2, 3, 'Executive Suite', 100),
  (205, 2, 4, 'Family Suite', 125),
  (206, 2, 4, 'Family Suite', 125),
  (204, 2, 4, 'Family Suite Sea View', 125),
  (302, 3, 4, 'Family Suite Sea View', 125),
  (303, 3, 4, 'Family Suite Sea View', 125),
  (301, 3, 4, 'Presidential Suite', 350);

/*
    # Section 3  
    Functions declarations
*/





/*
    # Section 4
    Procedures declarations
*/





/*
    # Section 5
    Triggers declarations
*/




