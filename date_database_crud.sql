-- Employee
INSERT INTO Employee (first_name, last_name, date_of_birth, gender, join_date)
VALUES ('Kiran', 'Sharma', '1995-08-15', 'Male', '2024-01-01');

-- Contact Details
INSERT INTO ContactDetails (employee_id, phone, email, address, city, state, pincode)
VALUES (1, '9876543210', 'kiran.sharma@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001');

-- Bank Details
INSERT INTO BankDetails (employee_id, account_holder_name, account_number, bank_name, ifsc_code)
VALUES (1, 'Kiran Sharma', '1234567890', 'SBI', 'SBIN0001234');

-- Documents
INSERT INTO Documents (employee_id, document_type, document_path)
VALUES 
(1, 'Aadhar', '/docs/aadhar.pdf'),
(1, 'PAN', '/docs/pan.pdf');
-- View all Employees
SELECT * FROM Employee;

-- View ContactDetails
SELECT * FROM ContactDetails;

-- View BankDetails
SELECT * FROM BankDetails;

-- View Documents
SELECT * FROM Documents;

-- Join Query (Employee + Contact + Bank)
SELECT 
    e.employee_id, e.first_name, e.last_name,
    c.phone, c.email,
    b.bank_name, b.account_number
FROM Employee e
LEFT JOIN ContactDetails c ON e.employee_id = c.employee_id
LEFT JOIN BankDetails b ON e.employee_id = b.employee_id;
-- Update Employee name
UPDATE Employee
SET first_name = 'Kiran Kumar'
WHERE employee_id = 1;

-- Update Contact Details
UPDATE ContactDetails
SET city = 'Bangalore', phone = '9123456789'
WHERE employee_id = 1;

-- Update Bank
UPDATE BankDetails
SET bank_name = 'HDFC', ifsc_code = 'HDFC0005678'
WHERE employee_id = 1;

-- Update Document path
UPDATE Documents
SET document_path = '/docs/aadhar_updated.pdf'
WHERE document_id = 1;
-- Delete one document only
DELETE FROM Documents
WHERE document_id = 2;

-- Delete employee (and cascade delete from contact, bank, documents)
DELETE FROM Employee
WHERE employee_id = 1;
