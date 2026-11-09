USE zero_hunger;

-- ─── Barangays (all 10, correct names) ───────────────────────────────────────
INSERT IGNORE INTO barangays (name) VALUES
  ('Aguho'),
  ('Magtanggol'),
  ("Martires del '96"),
  ('Poblacion'),
  ('San Pedro'),
  ('San Roque'),
  ('Santa Ana'),
  ('Santo Rosario-Kanluran'),
  ('Santo Rosario-Silangan'),
  ('Tabacalera');

-- ─── Sample users (password: Test1234) ───────────────────────────────────────
INSERT INTO users (name, email, password, role, barangay_id)
VALUES
  ('Test Admin',  'example_admin@barangay.gov.ph',  '$2b$10$9qaieYxQBZXGEaX5ZDy5COlSP0AK/iZq/j9ka6etCbShuumO77YGe', 'Admin', NULL),
  ('Test Staff',  'example_staff@barangay.gov.ph',  '$2b$10$9qaieYxQBZXGEaX5ZDy5COlSP0AK/iZq/j9ka6etCbShuumO77YGe', 'Staff', 4)
ON DUPLICATE KEY UPDATE email = email;

-- ─── Sample families ─────────────────────────────────────────────────────────
INSERT IGNORE INTO families
  (barangay_id, household_id, family_name, address, head_of_family, phone,
   monthly_income, food_assistance_status, is_npa, priority_score, is_active)
VALUES
  (4, 'POB-2026-0001', 'Doe Family',    '123 Main St, Poblacion', 'John Doe',   '09171234567', 9500.00,  '4Ps',          0, 75, 1),
  (1, 'AGU-2026-0002', 'Reyes Household','45 Sampaguita St, Aguho', 'Ana Reyes', '09189876543', 11000.00, 'Senior Citizen', 0, 60, 1),
  (2, 'MAG-2026-0003', 'Garcia Family', 'Mabini Street, Magtanggol', 'Elena Garcia', '09181234567', 7200.00, '4Ps', 0, 88, 1),
  (3, 'MAR-2026-0004', 'Navarro Household', 'Bonifacio Avenue, Martires del 96', 'Ramon Navarro', '09182345678', 12500.00, 'Solo Parent', 0, 69, 1),
  (5, 'SAN-2026-0005', 'Mendoza Family', 'Riverbank Road, San Pedro', 'Lourdes Mendoza', '09183456789', 8600.00, 'Senior Citizen', 0, 81, 1),
  (6, 'SRQ-2026-0006', 'Aquino Household', 'Ilang-Ilang Street, San Roque', 'Danilo Aquino', '09184567890', 9800.00, 'PWD', 0, 73, 1),
  (7, 'STA-2026-0007', 'Flores Family', 'Luna Street, Santa Ana', 'Maricel Flores', '09185678901', 6400.00, '4Ps', 0, 91, 1),
  (8, 'SRK-2026-0008', 'Villanueva Household', 'Kamagong Street, Santo Rosario-Kanluran', 'Oscar Villanueva', '09186789012', 10200.00, 'None', 0, 78, 1),
  (9, 'SRS-2026-0009', 'Castillo Family', 'Sampaguita Street, Santo Rosario-Silangan', 'Nena Castillo', '09187890123', 7900.00, 'Pregnant/Lactating', 0, 84, 1),
  (10, 'TAB-2026-0010', 'Bautista Household', 'P. Herrera Street, Tabacalera', 'Edgar Bautista', '09188901234', 13200.00, 'None', 0, 66, 1);

-- ─── Sample family members ────────────────────────────────────────────────────
INSERT IGNORE INTO family_members
  (family_id, first_name, last_name, date_of_birth, gender, relationship, is_pwd, height_cm, weight_kg, nutritional_status)
VALUES
  (1, 'John',  'Doe',   '1980-03-15', 'Male',   'Head',   0, 168.0, 65.0, 'Normal'),
  (1, 'Jane',  'Doe',   '1983-07-22', 'Female', 'Spouse', 0, 155.0, 52.0, 'Normal'),
  (1, 'Carlo', 'Doe',   '2010-11-05', 'Male',   'Child',  0, 135.0, 28.0, 'Underweight'),
  (2, 'Ana',   'Reyes', '1955-04-18', 'Female', 'Head',   0, 152.0, 48.0, 'Normal');

-- ─── Sample individuals ───────────────────────────────────────────────────────
INSERT IGNORE INTO individuals
  (individual_id, name, date_of_birth, gender, barangay_id, status)
VALUES
  (1, 'Pedro Ramos',    '1959-06-10', 'Male',   1, 'Registered'),
  (2, 'Ana Villanueva', '1992-09-25', 'Female', 4, 'Received'),
  (3, 'Rogelio Cruz', '1955-02-11', 'Male', 2, 'Registered'),
  (4, 'Celia Navarro', '1963-08-03', 'Female', 3, 'Registered'),
  (5, 'Mario Mendoza', '1958-01-19', 'Male', 5, 'Received'),
  (6, 'Teresa Aquino', '1984-05-27', 'Female', 6, 'Registered'),
  (7, 'Lito Flores', '1967-09-14', 'Male', 7, 'Registered'),
  (8, 'Rosario Villanueva', '1949-12-22', 'Female', 8, 'Received'),
  (9, 'Nestor Castillo', '1965-04-06', 'Male', 9, 'Registered'),
  (10, 'Gloria Bautista', '1960-11-30', 'Female', 10, 'Registered');

-- ─── Sample food supplies ─────────────────────────────────────────────────────
INSERT IGNORE INTO food_supplies (food_name, unit, total_quantity)
VALUES
  ('Rice',        'kg',    1000),
  ('Canned Goods','can',    500),
  ('Noodles',     'pack',   300),
  ('Bread',        'pack',   180),
  ('Infant Formula', 'can', 75);

-- ─── Sample distributions ─────────────────────────────────────────────────────
INSERT IGNORE INTO distribution
  (distribution_id, recipient_type, family_id, individual_id, barangay_id, food_id, quantity, date_given, status)
VALUES
  (1, 'Family',     1, NULL, 4, 1, 25, '2026-05-10', 'Completed'),
  (2, 'Individual', NULL, 1, 1, 2,  5, '2026-11-09', 'Pending'),
  (3, 'Family', 3, NULL, 2, 1, 25, '2026-11-09', 'Completed'),
  (4, 'Family', 5, NULL, 5, 2, 10, '2026-11-09', 'Pending'),
  (5, 'Individual', NULL, 7, 7, 3, 3, '2026-11-09', 'Completed'),
  (6, 'Family', 8, NULL, 8, 4, 8, '2026-11-09', 'Pending'),
  (7, 'Family', 9, NULL, 9, 1, 20, '2026-11-09', 'Completed'),
  (8, 'Individual', NULL, 10, 10, 2, 5, '2026-11-09', 'Pending');

-- ─── Sample activity logs ─────────────────────────────────────────────────────
INSERT IGNORE INTO distribution_activity_logs
  (activity_id, distribution_id, action, staff_user_id, staff_name, staff_email, distribution_details, performed_at)
VALUES
  (1, 1, 'distributed', '2', 'Test Staff', 'example_staff@barangay.gov.ph',
   'Distribution #1 • Doe Family • Poblacion • Rice (25 kg) • Status: Completed',
   '2026-05-10 09:30:00'),
  (2, 2, 'created',     '2', 'Test Staff', 'example_staff@barangay.gov.ph',
   'Distribution #2 • Pedro Ramos • Aguho • Canned Goods (5 can) • Status: Pending',
   '2026-11-09 13:45:00'),
  (3, 3, 'distributed', '12', 'Staff Magtanggol', 'staff-magtanggol@pateros.gov.ph',
   'Distribution #3 • Garcia Family • Magtanggol • Rice (25 kg) • Status: Completed',
   '2026-11-09 09:00:00'),
  (4, 4, 'created', '15', 'Staff San Pedro', 'staff-san-pedro@pateros.gov.ph',
   'Distribution #4 • Mendoza Family • San Pedro • Canned Goods (10 can) • Status: Pending',
   '2026-11-09 09:30:00'),
  (5, 5, 'distributed', '17', 'Staff Santa Ana', 'staff-santa-ana@pateros.gov.ph',
   'Distribution #5 • Lito Flores • Santa Ana • Noodles (3 pack) • Status: Completed',
   '2026-11-09 10:00:00'),
  (6, 6, 'created', '18', 'Staff Santo Rosario Kanluran', 'staff-santo-rosario-kanluran@pateros.gov.ph',
   'Distribution #6 • Villanueva Household • Santo Rosario-Kanluran • Bread (8 pack) • Status: Pending',
   '2026-11-09 10:30:00'),
  (7, 7, 'distributed', '19', 'Staff Santo Rosario Silangan', 'staff-santo-rosario-silangan@pateros.gov.ph',
   'Distribution #7 • Castillo Family • Santo Rosario-Silangan • Rice (20 kg) • Status: Completed',
   '2026-11-09 11:00:00'),
  (8, 8, 'created', '20', 'Staff Tabacalera', 'staff-tabacalera@pateros.gov.ph',
   'Distribution #8 • Gloria Bautista • Tabacalera • Canned Goods (5 can) • Status: Pending',
   '2026-11-09 11:30:00');
