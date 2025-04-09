-- EMPLOYEE TABLE
CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10),
    join_date DATE
);

-- CONTACT DETAILS (1-to-1)
CREATE TABLE ContactDetails (
    contact_id SERIAL PRIMARY KEY,
    employee_id INT UNIQUE,
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    CONSTRAINT fk_contact_employee FOREIGN KEY (employee_id)
        REFERENCES Employee (employee_id)
        ON DELETE CASCADE
);

-- BANK DETAILS (1-to-1)
CREATE TABLE BankDetails (
    bank_id SERIAL PRIMARY KEY,
    employee_id INT UNIQUE,
    account_holder_name VARCHAR(100),
    account_number VARCHAR(20),
    bank_name VARCHAR(100),
    ifsc_code VARCHAR(20),
    CONSTRAINT fk_bank_employee FOREIGN KEY (employee_id)
        REFERENCES Employee (employee_id)
        ON DELETE CASCADE
);

-- DOCUMENTS (1-to-many)
CREATE TABLE Documents (
    document_id SERIAL PRIMARY KEY,
    employee_id INT,
    document_type VARCHAR(50),
    document_path TEXT,
    CONSTRAINT fk_document_employee FOREIGN KEY (employee_id)
        REFERENCES Employee (employee_id)
        ON DELETE CASCADE
);
