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

  CONSTRAINT fk_guest_id_bh FOREIGN KEY (guest_id)
    REFERENCES Guests (guest_id),
  CONSTRAINT fk_room_id_bh FOREIGN KEY (room_id)
    REFERENCES Rooms (room_id),
  CONSTRAINT fk_employee_id_bh FOREIGN KEY (responsible_employee_id)
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
SELECT 1, 'Front Desk Receptionist', 40000.00, 60000.00 FROM DUAL
UNION ALL
SELECT 2, 'Housekeeper', 35000.00, 55000.00 FROM DUAL
UNION ALL
SELECT 3, 'Manager', 70000.00, 120000.00 FROM DUAL
UNION ALL
SELECT 4, 'Chef', 45000.00, 80000.00 FROM DUAL
UNION ALL
SELECT 5, 'Bartender', 30000.00, 50000.00 FROM DUAL;

INSERT INTO Employees (employee_id, name, surname, date_of_birth, date_of_hiring, job_id, salary)
SELECT 1, 'John', 'Doe', TO_DATE('1990-05-15', 'yyyy-mm-dd'), TO_DATE('2015-03-01', 'yyyy-mm-dd'), 5, 50000.00 FROM DUAL
UNION ALL
SELECT 2, 'Jane', 'Doe', TO_DATE('1992-08-27', 'yyyy-mm-dd'), TO_DATE('2016-01-01', 'yyyy-mm-dd'), 2, 35000.00 FROM DUAL
UNION ALL
SELECT 3, 'Robert', 'Smith', TO_DATE('1985-12-10', 'yyyy-mm-dd'), TO_DATE('2014-06-01', 'yyyy-mm-dd'), 3, 75000.00 FROM DUAL
UNION ALL
SELECT 4, 'Linda', 'Johnson', TO_DATE('1987-04-22', 'yyyy-mm-dd'), TO_DATE('2017-02-01', 'yyyy-mm-dd'), 2, 52500.00 FROM DUAL
UNION ALL
SELECT 5, 'David', 'Lee', TO_DATE('1993-10-05', 'yyyy-mm-dd'), TO_DATE('2018-05-01', 'yyyy-mm-dd'), 4, 68000.00 FROM DUAL
UNION ALL
SELECT 6, 'Mary', 'Kim', TO_DATE('1991-06-20', 'yyyy-mm-dd'), TO_DATE('2019-01-01', 'yyyy-mm-dd'), 5, 45000.00 FROM DUAL
UNION ALL
SELECT 7, 'Michael', 'Johnson', TO_DATE('1988-02-01', 'yyyy-mm-dd'), TO_DATE('2015-07-01', 'yyyy-mm-dd'), 1, 60000.00 FROM DUAL
UNION ALL
SELECT 8, 'Emily', 'Smith', TO_DATE('1994-11-15', 'yyyy-mm-dd'), TO_DATE('2017-12-01', 'yyyy-mm-dd'), 3, 100000.00 FROM DUAL
UNION ALL
SELECT 9, 'William', 'Brown', TO_DATE('1986-09-03', 'yyyy-mm-dd'), TO_DATE('2016-06-01', 'yyyy-mm-dd'), 3, 85000.00 FROM DUAL
UNION ALL
SELECT 10, 'Sophia', 'Davis', TO_DATE('1990-03-25', 'yyyy-mm-dd'), TO_DATE('2018-09-01', 'yyyy-mm-dd'), 1, 55000.00 FROM DUAL;

INSERT INTO Guests (guest_id, name, surname, security_number, date_of_birth, address, age, email)
SELECT 1, 'Jan', 'Kowalski', '123456789', TO_DATE('1990-05-15', 'yyyy-mm-dd'), '123 Main St, Anytown USA', 31, 'jandoe@example.com' FROM DUAL
UNION ALL
SELECT 2, 'Lukasz', 'Doe', '987654321', TO_DATE('1968-04-20', 'yyyy-mm-dd'), '456 Wiskitno St, Lodz PL', 29, 'lukaszdoe@example.com' FROM DUAL
UNION ALL
SELECT 3, 'Ola', 'Smith', '2468101214', TO_DATE('1975-02-14', 'yyyy-mm-dd'), '789 First Ave, SomeTown PL', 36, 'osmith@example.com' FROM DUAL
UNION ALL
SELECT 4, 'Mateusz', 'Jones', '3691215182', TO_DATE('2000-12-03', 'yyyy-mm-dd'), '321 Second St, Anytown PL', 28, 'mjones@example.com' FROM DUAL
UNION ALL
SELECT 5, 'David', 'Lee', '5813213245', TO_DATE('1995-06-10', 'yyyy-mm-dd'), '987 Elm St, Anytown USA', 26, 'dlee@example.com' FROM DUAL
UNION ALL
SELECT 6, 'Emily', 'Wilson', '543216789', TO_DATE('1988-07-01', 'yyyy-mm-dd'), '123 Main St, Anytown USA', 33, 'emilywilson@example.com' FROM DUAL
UNION ALL
SELECT 7, 'Ryan', 'Johnson', '123456789', TO_DATE('1992-09-03', 'yyyy-mm-dd'), '456 Broad St, Anytown USA', 29, 'ryanjohnson@example.com' FROM DUAL
UNION ALL
SELECT 8, 'Sophie', 'Garcia', '987654321', TO_DATE('1995-02-14', 'yyyy-mm-dd'), '789 First Ave, Anytown USA', 26, 'sophiegarcia@example.com' FROM DUAL
UNION ALL
SELECT 9, 'William', 'Brown', '2468101214', TO_DATE('1987-12-03', 'yyyy-mm-dd'), '321 Second St, Anytown USA', 34, 'williambrown@example.com' FROM DUAL
UNION ALL
SELECT 10, 'Olivia', 'Davis', '3691215182', TO_DATE('1991-06-21', 'yyyy-mm-dd'), '987 Elm St, Anytown USA', 30, 'oliviadavis@example.com' FROM DUAL
UNION ALL
SELECT 11, 'Noah', 'Taylor', '5813213245', TO_DATE('1993-11-10', 'yyyy-mm-dd'), '555 Fifth Ave, Anytown USA', 28, 'noahtaylor@example.com' FROM DUAL
UNION ALL
SELECT 12, 'Avery', 'Wilson', '234567890', TO_DATE('1989-05-12', 'yyyy-mm-dd'), '246 Oak St, Anytown USA', 32, 'averywilson@example.com' FROM DUAL
UNION ALL
SELECT 13, 'Ethan', 'Harris', '987654321', TO_DATE('1998-09-21', 'yyyy-mm-dd'), '789 Elmwood Dr, Anytown USA', 23, 'ethanharris@example.com' FROM DUAL
UNION ALL
SELECT 14, 'Emma', 'Clark', '123456789', TO_DATE('1995-03-05', 'yyyy-mm-dd'), '321 Pine St, Anytown USA', 26, 'emmaclark@example.com' FROM DUAL
UNION ALL
SELECT 15, 'Alexander', 'Lewis', '987654321', TO_DATE('1984-02-14', 'yyyy-mm-dd'), '444 Maple Ave, Anytown USA', 37, 'alexanderlewis@example.com' FROM DUAL;

INSERT INTO Rooms (room_id, floor, capacity, type, price_per_day)
SELECT 101, 1, 2, 'Standard double bed', 50 FROM DUAL
UNION ALL
SELECT 102, 1, 2, 'Standard double bed', 50 FROM DUAL
UNION ALL
SELECT 103, 1, 2, 'Standard double bed', 50 FROM DUAL
UNION ALL
SELECT 104, 1, 2, 'Deluxe king bed', 75 FROM DUAL
UNION ALL
SELECT 105, 1, 2, 'Deluxe king bed', 75 FROM DUAL
UNION ALL
SELECT 106, 1, 2, 'Deluxe king bed', 75 FROM DUAL
UNION ALL
SELECT 201, 2, 3, 'Executive Suite', 100 FROM DUAL
UNION ALL
SELECT 202, 2, 3, 'Executive Suite', 100 FROM DUAL
UNION ALL
SELECT 203, 2, 3, 'Executive Suite', 100 FROM DUAL
UNION ALL
SELECT 205, 2, 4, 'Family Suite', 125 FROM DUAL
UNION ALL
SELECT 206, 2, 4, 'Family Suite', 125 FROM DUAL
UNION ALL
SELECT 204, 2, 4, 'Family Suite Sea View', 125 FROM DUAL
UNION ALL
SELECT 302, 3, 4, 'Family Suite Sea View', 125 FROM DUAL
UNION ALL
SELECT 303, 3, 4, 'Family Suite Sea View', 125 FROM DUAL
UNION ALL
SELECT 301, 3, 4, 'Presidential Suite', 350 FROM DUAL;

INSERT INTO Employees_history (employee_id, name, surname, date_of_birth, date_of_hiring, job_id, salary, fired_date)
VALUES (10, 'Adam', 'Nowak', TO_DATE('1985-05-10', 'YYYY-MM-DD'), TO_DATE('2010-01-15', 'YYYY-MM-DD'), 1, 50000.00, NULL);

INSERT INTO Employees_history (employee_id, name, surname, date_of_birth, date_of_hiring, job_id, salary, fired_date)
VALUES (11, 'Katarzyna', 'Kowalska', TO_DATE('1992-09-20', 'YYYY-MM-DD'), TO_DATE('2015-07-03', 'YYYY-MM-DD'), 2, 45000.00, NULL);

INSERT INTO Employees_history (employee_id, name, surname, date_of_birth, date_of_hiring, job_id, salary, fired_date)
VALUES (12, 'Piotr', 'Jankowski', TO_DATE('1988-12-05', 'YYYY-MM-DD'), TO_DATE('2012-04-28', 'YYYY-MM-DD'), 3, 75500.00, NULL);

INSERT INTO Employees_history (employee_id, name, surname, date_of_birth, date_of_hiring, job_id, salary, fired_date)
VALUES (13, 'Anna', 'Wójcik', TO_DATE('1991-06-15', 'YYYY-MM-DD'), TO_DATE('2018-02-10', 'YYYY-MM-DD'), 4, 48000.00, NULL);

INSERT INTO Employees_history (employee_id, name, surname, date_of_birth, date_of_hiring, job_id, salary, fired_date)
VALUES (14, 'Tomasz', 'Kamiński', TO_DATE('1987-03-25', 'YYYY-MM-DD'), TO_DATE('2013-09-05', 'YYYY-MM-DD'), 5, 45200.00, NULL);

/*
    # Section 3  
    Functions declarations
*/

/*
    # Section 4 
    Data queries
*/

SELECT COUNT(*) AS total_bookings
FROM bookings;

SELECT AVG(total_price) AS average_price
FROM bookings;

SELECT AVG(end_date - start_date) AS average_duration
FROM bookings;

SELECT responsible_employee, COUNT(*) AS booking_count, SUM(total_price) AS total_price
FROM bookings
GROUP BY responsible_employee
ORDER BY booking_count DESC
FETCH FIRST 1 ROWS ONLY;

SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM date_of_birth)) AS average_age
FROM employees;

SELECT COUNT(*) AS Number_Of_Employees_In_History
FROM employees_history

SELECT MAX(total_price) AS max_total_price
FROM Bookings;

SELECT SUM(total_price) AS total_price_sum
FROM Bookings;

SELECT AVG(total_price) AS average_total_price
FROM Bookings;

SELECT responsible_employee_id, COUNT(*) AS booking_count
FROM Bookings
GROUP BY responsible_employee_id;

SELECT MAX(total_price) AS max_total_price
FROM bookings_history;

SELECT MAX(price_per_day) AS max_price
FROM Rooms;

SELECT COUNT(*) AS total_rooms
FROM Rooms;

SELECT AVG(price_per_day) AS average_price
FROM Rooms;

SELECT *
FROM Rooms
ORDER BY floor ASC;

SELECT CASE
         WHEN age < 18 THEN 'Under 18'
         WHEN age >= 18 AND age <= 30 THEN '18-30'
         WHEN age >= 31 AND age <= 50 THEN '31-50'
         ELSE 'Over 50'
       END AS age_group,
       COUNT(*) AS guest_count
FROM Guests
GROUP BY CASE
           WHEN age < 18 THEN 'Under 18'
           WHEN age >= 18 AND age <= 30 THEN '18-30'
           WHEN age >= 31 AND age <= 50 THEN '31-50'
           ELSE 'Over 50'
         END;
         
SELECT *
FROM Guests
WHERE age = (SELECT MAX(age) FROM Guests);         

/*
    # Section 5
    Procedures declarations
*/

--Add Guest procedure

CREATE OR REPLACE PROCEDURE add_guest(
    guest_id_p IN guests.guest_id%TYPE,
    name_p IN guests.name%TYPE,
    surname_p IN guests.surname%TYPE,
    security_number_p IN guests.security_number%TYPE,
    date_of_birth_p IN guests.date_of_birth%TYPE,
    address_p IN guests.address%TYPE,
    age_p IN guests.age%TYPE,
    email_p IN guests.email%TYPE
)
IS
BEGIN
    INSERT INTO guests (
        guest_id,
        name,
        surname,
        security_number,
        date_of_birth,
        address,
        age,
        email
    ) VALUES (
        guest_id_p,
        name_p,
        surname_p,
        security_number_p,
        date_of_birth_p,
        address_p,
        age_p,
        email_p
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('New guest added');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END add_guest;

-- Add employee procedure

CREATE OR REPLACE PROCEDURE add_employee(
    employee_id_p IN employees.employee_id%TYPE,
    name_p IN employees.name%TYPE,
    surname_p IN employees.surname%TYPE,
    date_of_birth_p IN employees.date_of_birth%TYPE,
    date_of_hiring_p IN employees.date_of_hiring%TYPE,
    job_id_p IN employees.job_id%TYPE,
    salary_p IN employees.salary%TYPE
)
IS
BEGIN
    INSERT INTO employees (
        employee_id,
        name,
        surname,
        date_of_birth,
        date_of_hiring,
        job_id,
        salary
    ) VALUES (
        employee_id_p,
        name_p,
        surname_p,
        date_of_birth_p,
        date_of_hiring_p,
        job_id_p,
        salary_p
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('New employee added');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END add_employee;


-- Delete guest procedure

create or replace PROCEDURE delete_guest(
    guest_id_p IN guests.guest_id%TYPE
) IS
BEGIN
    DELETE FROM guests
    WHERE guest_id = guest_id_p;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Guest deleted');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END delete_guest;

-- Delete employee procedure

create or replace PROCEDURE delete_employee(
    employee_id_p IN employees.employee_id%TYPE
) IS
BEGIN
    DELETE FROM employees
    WHERE employee_id = employee_id_p;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Employee deleted');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END delete_employee;

-- Add booking procedure

create or replace PROCEDURE add_booking(
    guest_id_p IN bookings.guest_id%TYPE,
    room_id_p IN bookings.room_id%TYPE,
    start_date_p in bookings.start_date%TYPE,
    end_date_p in bookings.end_date%TYPE,
    responsible_employee_id_p in bookings.responsible_employee_id%TYPE,
    payment_type_p in bookings.payment_type%TYPE
) 
IS
    num_of_days NUMBER;
    room_price rooms.price_per_day%TYPE;
    total_price_calculated NUMBER;
BEGIN
    num_of_days := end_date_p - start_date_p;
    SELECT price_per_day INTO room_price FROM rooms WHERE room_id = room_id_p;
    total_price_calculated := num_of_days * room_price;
    
    INSERT INTO bookings (
        guest_id,
        room_id,
        start_date,
        end_date,
        responsible_employee_id,
        total_price,
        payment_type
    ) VALUES (
        guest_id_p,
        room_id_p,
        start_date_p,
        end_date_p,
        responsible_employee_id_p,
        total_price_calculated,
        payment_type_p
    );

--    COMMIT;

    DBMS_OUTPUT.PUT_LINE('New booking added');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END add_booking;

-- Cancel booking procedure

CREATE OR REPLACE PROCEDURE cancel_booking(
    booking_id_p IN bookings.booking_id%TYPE
) IS
BEGIN
    DELETE FROM bookings
    WHERE booking_id = booking_id_p;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Booking canceled');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Booking not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END cancel_booking;

-- Add booking review procedure

create or replace PROCEDURE add_booking_review(
    booking_id_p IN bookings_history.booking_id%TYPE,
    review_p IN bookings_history.review%TYPE
)
IS
    guest_id_v bookings_history.guest_id%TYPE;
    room_id_v bookings_history.room_id%TYPE;
    start_date_v bookings_history.start_date%TYPE;
    end_date_v bookings_history.end_date%TYPE;
    responsible_employee_id_v bookings_history.responsible_employee_id%TYPE;
    total_price_v bookings_history.total_price%TYPE;
    payment_type_v bookings_history.payment_type%TYPE;
BEGIN
    SELECT guest_id, room_id, start_date, end_date, responsible_employee_id, total_price, payment_type
    INTO guest_id_v, room_id_v, start_date_v, end_date_v, responsible_employee_id_v, total_price_v, payment_type_v
    FROM bookings_history
    WHERE booking_id = booking_id_p;

    INSERT INTO bookings_history (
        booking_id,
        guest_id,
        room_id,
        start_date,
        end_date,
        responsible_employee_id,
        total_price,
        payment_type,
        review
    ) VALUES (
        booking_id_p,
        guest_id_v,
        room_id_v,
        start_date_v,
        end_date_v,
        responsible_employee_id_v,
        total_price_v,
        payment_type_v,
        review_p
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('New review added');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Booking ID ' || booking_id_p || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END add_booking_review;

-- Moving expired bookings to bookings_history table
CREATE OR REPLACE PROCEDURE daily_bookings_check IS
BEGIN

  INSERT INTO bookings_history (booking_id, guest_id, room_id, start_date, end_date, responsible_employee_id, total_price, payment_type, review)
    SELECT booking_id, guest_id, room_id, start_date, end_date, responsible_employee_id, total_price, payment_type, ''
    FROM bookings
    WHERE end_date < TRUNC(SYSDATE);

  DELETE FROM bookings
  WHERE end_date < TRUNC(SYSDATE);

END;
/*
    # Section 6
    Functions declarations
*/
-- Total revenue from given payment method

create or replace FUNCTION calculate_total_revenue(payment_type IN VARCHAR2)
RETURN NUMBER
IS
    total_revenue NUMBER(10, 2);
BEGIN
    SELECT SUM(total_price) INTO total_revenue
    FROM Bookings
    WHERE payment_type = payment_type;

    DBMS_OUTPUT.PUT_LINE('Total Revenue: ' || total_revenue);
    RETURN total_revenue;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No revenue found.');
        RETURN 0; 
END;

DECLARE
    total_rev NUMBER(10, 2);
BEGIN
    total_rev := calculate_total_revenue('Credit Card'); -- Replace 'Credit Card' with the desired payment type
END;

-- Check if room is available in given date

create or replace FUNCTION is_room_available(
    room_id_p IN NUMBER,
    check_date_p IN DATE
) RETURN BOOLEAN
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM bookings
    WHERE room_id = room_id_p
        AND check_date_p BETWEEN start_date AND end_date;

    IF v_count > 0 THEN
        RETURN FALSE; 
    ELSE
        RETURN TRUE; 
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE; 
END;

DECLARE
    v_room_id NUMBER := 103; -- Replace with the desired room ID
    v_check_date DATE := DATE '2023-05-21'; -- Replace with the desired check date
    v_available BOOLEAN;
BEGIN
    v_available := is_room_available(v_room_id, v_check_date);

    IF v_available THEN
        DBMS_OUTPUT.PUT_LINE('Room ' || v_room_id || ' is available on ' || v_check_date);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Room ' || v_room_id || ' is not available on ' || v_check_date);
    END IF;
END;


/*
    # Section 7
    Triggers declarations
*/

-- Auto id increment for bookings table
CREATE OR REPLACE TRIGGER bookings_trigger
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
  :NEW.booking_id := bookings_seq.NEXTVAL;
END;

-- Move deleted employee to the employees_history table

create or replace TRIGGER employees_delete_trigger
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO Employees_history (
        employee_id,
        name,
        surname,
        date_of_birth,
        date_of_hiring,
        job_id,
        salary,
        fired_date
    )
    VALUES (
        :OLD.employee_id,
        :OLD.name,
        :OLD.surname,
        :OLD.date_of_birth,
        :OLD.date_of_hiring,
        :OLD.job_id,
        :OLD.salary,
        SYSDATE
    );
END;

/*
    # Section 8
    Sequences declarations
*/

CREATE SEQUENCE bookings_seq START WITH 1 INCREMENT BY 1;

/*
    # Section 9
    Other
*/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
    job_name        => 'daily_bookings_scheduler',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN daily_bookings_check; END;',
    start_date      => TRUNC(SYSDATE) + INTERVAL '1' DAY + INTERVAL '8' HOUR,
    repeat_interval => 'FREQ=DAILY; BYHOUR=8',
    enabled         => TRUE
  );
END;

-- BEGIN
--   DBMS_SCHEDULER.DROP_JOB('daily_task_job');
-- END;



