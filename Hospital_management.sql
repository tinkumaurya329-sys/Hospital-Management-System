CREATE DATABASE hospital_management;
USE hospital_management;

-- 1. DEPARTMENTS
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    phone VARCHAR(20)
);

-- 2. DOCTORS
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(120) UNIQUE,
    consultation_fee DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 3. PATIENTS
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    date_of_birth DATE,
    phone VARCHAR(20),
    city VARCHAR(100),
    blood_group VARCHAR(5),
    registration_date DATE NOT NULL
);

-- 4. APPOINTMENTS
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    appointment_status VARCHAR(30) DEFAULT 'Scheduled',
    reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 5. ROOMS
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(20) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL,
    floor_no INT,
    daily_charge DECIMAL(10,2),
    room_status VARCHAR(30) DEFAULT 'Available'
);

-- 6. ADMISSIONS
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    room_id INT NOT NULL,
    doctor_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    admission_status VARCHAR(30) DEFAULT 'Admitted',
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 7. MEDICINES
CREATE TABLE medicines (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_name VARCHAR(100) NOT NULL,
    category VARCHAR(80),
    manufacturer VARCHAR(100),
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    expiry_date DATE
);

-- 8. PRESCRIPTIONS
CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    prescription_date DATE NOT NULL,
    notes VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 9. PRESCRIPTION ITEMS
CREATE TABLE prescription_items (
    prescription_item_id INT PRIMARY KEY AUTO_INCREMENT,
    prescription_id INT NOT NULL,
    medicine_id INT NOT NULL,
    dosage VARCHAR(100),
    duration_days INT,
    quantity INT,
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- 10. BILLS
CREATE TABLE bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    admission_id INT,
    bill_date DATE NOT NULL,
    consultation_amount DECIMAL(10,2) DEFAULT 0,
    room_amount DECIMAL(10,2) DEFAULT 0,
    medicine_amount DECIMAL(10,2) DEFAULT 0,
    test_amount DECIMAL(10,2) DEFAULT 0,
    other_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) DEFAULT 0,
    payment_status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);

-- 11. PAYMENTS-- 
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30),
    transaction_reference VARCHAR(100),
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
);

-- SAMPLE DATA
INSERT INTO departments (department_name, location, phone) VALUES
('Cardiology', 'Block A - 2nd Floor', '0522-4001001'),
('Neurology', 'Block B - 3rd Floor', '0522-4001002'),
('Orthopedics', 'Block A - 1st Floor', '0522-4001003'),
('Pediatrics', 'Block C - Ground Floor', '0522-4001004'),
('General Medicine', 'Block B - 1st Floor', '0522-4001005');

INSERT INTO doctors
(doctor_name, specialization, department_id, phone, email, consultation_fee) VALUES
('Dr. Anil Sharma', 'Cardiologist', 1, '9876501001', 'anil.sharma@hospital.com', 1200),
('Dr. Priya Singh', 'Neurologist', 2, '9876501002', 'priya.singh@hospital.com', 1500),
('Dr. Rahul Verma', 'Orthopedic Surgeon', 3, '9876501003', 'rahul.verma@hospital.com', 1000),
('Dr. Neha Gupta', 'Pediatrician', 4, '9876501004', 'neha.gupta@hospital.com', 800),
('Dr. Amit Kumar', 'General Physician', 5, '9876501005', 'amit.kumar@hospital.com', 600);

INSERT INTO patients
(patient_name, gender, date_of_birth, phone, city, blood_group, registration_date) VALUES
('Rahul Maurya', 'Male', '1998-04-12', '9876510001', 'Lucknow', 'B+', '2026-01-05'),
('Priya Verma', 'Female', '2001-08-21', '9876510002', 'Kanpur', 'O+', '2026-01-10'),
('Aman Singh', 'Male', '1995-02-15', '9876510003', 'Lucknow', 'A+', '2026-02-01'),
('Sneha Gupta', 'Female', '1999-11-09', '9876510004', 'Ayodhya', 'AB+', '2026-02-14'),
('Rohit Yadav', 'Male', '1988-06-30', '9876510005', 'Lucknow', 'O-', '2026-03-02'),
('Neha Sharma', 'Female', '2012-09-17', '9876510006', 'Barabanki', 'B+', '2026-03-08'),
('Vikas Kumar', 'Male', '1979-01-22', '9876510007', 'Lucknow', 'A-', '2026-03-15'),
('Pooja Singh', 'Female', '1993-12-04', '9876510008', 'Unnao', 'O+', '2026-04-01');

INSERT INTO appointments
(patient_id, doctor_id, appointment_date, appointment_time, appointment_status, reason) VALUES
(1, 1, '2026-09-25', '10:00:00', 'Completed', 'Chest discomfort'),
(2, 2, '2026-09-25', '11:30:00', 'Scheduled', 'Headache'),
(3, 3, '2026-09-26', '09:30:00', 'Scheduled', 'Knee pain'),
(4, 4, '2026-09-26', '12:00:00', 'Scheduled', 'Routine checkup'),
(5, 5, '2026-09-27', '10:30:00', 'Cancelled', 'Fever'),
(6, 4, '2026-09-27', '14:00:00', 'Completed', 'Cold and cough');

INSERT INTO rooms (room_number, room_type, floor_no, daily_charge, room_status) VALUES
('101', 'General Ward', 1, 1500, 'Occupied'),
('102', 'General Ward', 1, 1500, 'Available'),
('201', 'Semi Private', 2, 3000, 'Occupied'),
('202', 'Semi Private', 2, 3000, 'Available'),
('301', 'Private', 3, 5000, 'Occupied'),
('302', 'ICU', 3, 10000, 'Occupied');

INSERT INTO admissions
(patient_id, room_id, doctor_id, admission_date, discharge_date, admission_status, diagnosis) VALUES
(1, 301, 1, '2026-09-20', NULL, 'Admitted', 'Cardiac observation'),
(3, 201, 3, '2026-09-21', '2026-09-24', 'Discharged', 'Knee injury'),
(5, 101, 5, '2026-09-22', NULL, 'Admitted', 'Viral fever'),
(7, 302, 1, '2026-09-23', NULL, 'Admitted', 'Cardiac monitoring');

INSERT INTO medicines
(medicine_name, category, manufacturer, unit_price, stock_quantity, expiry_date) VALUES
('Paracetamol 500mg', 'Pain Relief', 'ABC Pharma', 2.50, 500, '2028-05-31'),
('Amoxicillin 500mg', 'Antibiotic', 'MediCare Labs', 8.00, 300, '2027-12-31'),
('Pantoprazole 40mg', 'Gastric', 'HealthPlus', 5.00, 250, '2028-03-31'),
('Atorvastatin 10mg', 'Cardiac', 'LifeCare', 12.00, 180, '2027-10-31'),
('Vitamin D3', 'Supplement', 'Wellness Pharma', 10.00, 400, '2028-08-31'),
('Ibuprofen 400mg', 'Pain Relief', 'ABC Pharma', 6.00, 220, '2027-11-30');

INSERT INTO prescriptions (patient_id, doctor_id, prescription_date, notes) VALUES
(1, 1, '2026-09-20', 'Take medicines after meals'),
(2, 2, '2026-09-25', 'Follow up after 7 days'),
(3, 3, '2026-09-21', 'Rest and physiotherapy'),
(5, 5, '2026-09-22', 'Maintain hydration');

INSERT INTO prescription_items
(prescription_id, medicine_id, dosage, duration_days, quantity) VALUES
(1, 4, '1 tablet daily', 30, 30),
(1, 3, '1 tablet daily', 15, 15),
(2, 1, '1 tablet as needed', 5, 10),
(3, 6, '1 tablet twice daily', 7, 14),
(4, 1, '1 tablet twice daily', 5, 10),
(4, 2, '1 capsule twice daily', 5, 10);

INSERT INTO bills
(patient_id, admission_id, bill_date, consultation_amount, room_amount,
 medicine_amount, test_amount, other_amount, total_amount, payment_status) VALUES
(1, 1, '2026-09-25', 1200, 25000, 420, 3500, 500, 30620, 'Partial'),
(3, 2, '2026-09-24', 1000, 9000, 300, 1800, 200, 12300, 'Paid'),
(5, 3, '2026-09-25', 600, 6000, 250, 1000, 100, 7950, 'Pending'),
(7, 4, '2026-09-25', 1200, 20000, 650, 5000, 500, 27350, 'Partial');

INSERT INTO payments
(bill_id, payment_date, amount, payment_method, transaction_reference) VALUES
(1, '2026-09-21', 15000, 'UPI', 'UPI-HOSP-10001'),
(2, '2026-09-24', 12300, 'Card', 'CARD-HOSP-10002'),
(4, '2026-09-24', 10000, 'Cash', 'CASH-HOSP-10003');

-- USEFUL VIEWS FOR DATA ANALYTICS
CREATE VIEW patient_appointments AS
SELECT
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    d.specialization,
    dep.department_name,
    a.appointment_date,
    a.appointment_time,
    a.appointment_status,
    a.reason
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dep ON d.department_id = dep.department_id;

CREATE VIEW hospital_revenue AS
SELECT
    b.bill_id,
    p.patient_name,
    b.bill_date,
    b.total_amount,
    COALESCE(SUM(pay.amount), 0) AS amount_paid,
    b.total_amount - COALESCE(SUM(pay.amount), 0) AS amount_due,
    b.payment_status
FROM bills b
JOIN patients p ON b.patient_id = p.patient_id
LEFT JOIN payments pay ON b.bill_id = pay.bill_id
GROUP BY b.bill_id, p.patient_name, b.bill_date,
         b.total_amount, b.payment_status;

CREATE VIEW doctor_performance AS
SELECT
    d.doctor_id,
    d.doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.appointment_status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
    SUM(CASE WHEN a.appointment_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name, d.specialization;

-- STORED PROCEDURE
DELIMITER $$

CREATE PROCEDURE GetPatientDetails(IN p_patient_id INT)
BEGIN
    SELECT
        p.patient_id,
        p.patient_name,
        p.gender,
        p.phone,
        p.city,
        p.blood_group,
        a.appointment_date,
        d.doctor_name,
        d.specialization,
        a.appointment_status
    FROM patients p
    LEFT JOIN appointments a ON p.patient_id = a.patient_id
    LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
    WHERE p.patient_id = p_patient_id;
END$$

DELIMITER ;

-- EXAMPLE ANALYTICS QUERIES
-- Total patients
SELECT COUNT(*) AS total_patients FROM patients;

-- Total doctors by department
SELECT
    dep.department_name,
    COUNT(d.doctor_id) AS doctor_count
FROM departments dep
LEFT JOIN doctors d ON dep.department_id = d.department_id
GROUP BY dep.department_id, dep.department_name;

-- Current admitted patients
SELECT
    p.patient_name,
    r.room_number,
    r.room_type,
    d.doctor_name,
    a.diagnosis,
    a.admission_date
FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
JOIN rooms r ON a.room_id = r.room_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.admission_status = 'Admitted';

-- Revenue by payment status
SELECT payment_status, SUM(total_amount) AS total_billed
FROM bills
GROUP BY payment_status;

-- Low stock medicines
SELECT medicine_name, stock_quantity
FROM medicines
WHERE stock_quantity < 250;

