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




