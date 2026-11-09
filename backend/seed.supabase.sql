-- Run this after schema.supabase.sql in the Supabase SQL Editor.
-- Safe to run again: records use fixed IDs and are skipped when present.

INSERT INTO users (user_id, name, email, password, role, barangay_id)
VALUES
  (2, 'Aguho Staff', 'staff@pateros.gov.ph', '$2b$10$yrSJoKTimXxpwms7tleIKeqIP1M89w2JcYnCt/Msb5SvMXZnbVJlK', 'Staff', 1)
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO donors (donor_id, donor_name, contact_info)
VALUES
  (1, 'Barangay Council', 'N/A'),
  (2, 'Private Citizen', 'N/A')
ON CONFLICT (donor_id) DO NOTHING;

INSERT INTO families
  (family_id, barangay_id, household_id, family_name, address, head_of_family, phone,
   monthly_income, food_assistance_status, is_npa, priority_score, is_active)
VALUES
  (1, 1, 'AGU-2026-0001', 'Dela Cruz Family', 'Main Street, Aguho', 'Juan Dela Cruz', '09171234567', 9500, '4Ps', false, 82, true),
  (2, 4, 'POB-2026-0002', 'Santos Household', 'Riverbank, Poblacion', 'Maria Santos', '09179876543', 11000, 'Senior Citizen', false, 76, true),
  (3, 2, 'MAG-2026-0003', 'Garcia Family', 'Mabini Street, Magtanggol', 'Elena Garcia', '09181234567', 7200, '4Ps', false, 88, true),
  (4, 3, 'MAR-2026-0004', 'Navarro Household', 'Bonifacio Avenue, Martires del 96', 'Ramon Navarro', '09182345678', 12500, 'Solo Parent', false, 69, true),
  (5, 5, 'SAN-2026-0005', 'Mendoza Family', 'Riverbank Road, San Pedro', 'Lourdes Mendoza', '09183456789', 8600, 'Senior Citizen', false, 81, true),
  (6, 6, 'SRQ-2026-0006', 'Aquino Household', 'Ilang-Ilang Street, San Roque', 'Danilo Aquino', '09184567890', 9800, 'PWD', false, 73, true),
  (7, 7, 'STA-2026-0007', 'Flores Family', 'Luna Street, Santa Ana', 'Maricel Flores', '09185678901', 6400, '4Ps', false, 91, true),
  (8, 8, 'SRK-2026-0008', 'Villanueva Household', 'Kamagong Street, Santo Rosario-Kanluran', 'Oscar Villanueva', '09186789012', 10200, 'None', false, 78, true),
  (9, 9, 'SRS-2026-0009', 'Castillo Family', 'Sampaguita Street, Santo Rosario-Silangan', 'Nena Castillo', '09187890123', 7900, 'Pregnant/Lactating', false, 84, true),
  (10, 10, 'TAB-2026-0010', 'Bautista Household', 'P. Herrera Street, Tabacalera', 'Edgar Bautista', '09188901234', 13200, 'None', false, 66, true)
ON CONFLICT (family_id) DO NOTHING;

INSERT INTO family_members
  (member_id, family_id, first_name, last_name, date_of_birth, gender, relationship,
   is_pwd, height_cm, weight_kg, nutritional_status)
VALUES
  (1, 1, 'Juan', 'Dela Cruz', '1975-06-12', 'Male', 'Head', false, 168, 62, 'Normal'),
  (2, 1, 'Rosa', 'Dela Cruz', '1978-03-25', 'Female', 'Spouse', false, 155, 50, 'Normal'),
  (3, 1, 'Carlo', 'Dela Cruz', '2005-09-14', 'Male', 'Child', false, 160, 45, 'Underweight'),
  (4, 2, 'Maria', 'Santos', '1955-04-18', 'Female', 'Head', false, 152, 48, 'Normal')
ON CONFLICT (member_id) DO NOTHING;

INSERT INTO individuals
  (individual_id, name, date_of_birth, gender, barangay_id, status)
VALUES
  (1, 'Pedro Ramos', '1959-06-10', 'Male', 1, 'Registered'),
  (2, 'Ana Villanueva', '1992-09-25', 'Female', 4, 'Received'),
  (3, 'Rogelio Cruz', '1955-02-11', 'Male', 2, 'Registered'),
  (4, 'Celia Navarro', '1963-08-03', 'Female', 3, 'Registered'),
  (5, 'Mario Mendoza', '1958-01-19', 'Male', 5, 'Received'),
  (6, 'Teresa Aquino', '1984-05-27', 'Female', 6, 'Registered'),
  (7, 'Lito Flores', '1967-09-14', 'Male', 7, 'Registered'),
  (8, 'Rosario Villanueva', '1949-12-22', 'Female', 8, 'Received'),
  (9, 'Nestor Castillo', '1965-04-06', 'Male', 9, 'Registered'),
  (10, 'Gloria Bautista', '1960-11-30', 'Female', 10, 'Registered')
ON CONFLICT (individual_id) DO NOTHING;

INSERT INTO food_supplies (food_id, food_name, unit, total_quantity, barangay_id)
VALUES
  (1, 'Rice', 'kg', 1000, 1),
  (2, 'Canned Goods', 'can', 500, 1),
  (3, 'Noodles', 'pack', 300, 1),
  (4, 'Bread', 'pack', 180, 4),
  (5, 'Infant Formula', 'can', 75, 7)
ON CONFLICT (food_id) DO NOTHING;

INSERT INTO donations
  (donation_id, donor_id, food_id, food_description, donation_type, quantity, quantity_unit,
   date_given, barangay_id, status, tracking_number)
VALUES
  (1, 1, 1, 'Rice', 'food', 200, 'kg', CURRENT_DATE, 1, 'approved', 'DON-20261109-SEED'),
  (2, 2, 3, 'Noodles', 'food', 120, 'pack', CURRENT_DATE, 4, 'pending', 'DON-20261109-SEED2')
ON CONFLICT (donation_id) DO NOTHING;

INSERT INTO distribution
  (distribution_id, recipient_type, family_id, individual_id, barangay_id, food_id,
   quantity, date_given, status)
VALUES
  (1, 'Family', 1, NULL, 1, 1, 30, CURRENT_DATE, 'Completed'),
  (2, 'Individual', NULL, 1, 1, 2, 5, CURRENT_DATE, 'Pending'),
  (3, 'Family', 3, NULL, 2, 1, 25, CURRENT_DATE, 'Completed'),
  (4, 'Family', 5, NULL, 5, 2, 10, CURRENT_DATE, 'Pending'),
  (5, 'Individual', NULL, 7, 7, 3, 3, CURRENT_DATE, 'Completed'),
  (6, 'Family', 8, NULL, 8, 4, 8, CURRENT_DATE, 'Pending'),
  (7, 'Family', 9, NULL, 9, 1, 20, CURRENT_DATE, 'Completed'),
  (8, 'Individual', NULL, 10, 10, 2, 5, CURRENT_DATE, 'Pending')
ON CONFLICT (distribution_id) DO NOTHING;

INSERT INTO distribution_activity_logs
  (activity_id, distribution_id, action, staff_user_id, staff_name, staff_email,
   distribution_details, performed_at)
VALUES
  (1, 1, 'distributed', '2', 'Aguho Staff', 'staff@pateros.gov.ph', 'Distribution #1 - Dela Cruz Family - Aguho - Rice (30 kg) - Status: Completed', NOW()),
  (2, 2, 'created', '2', 'Aguho Staff', 'staff@pateros.gov.ph', 'Distribution #2 - Pedro Ramos - Aguho - Canned Goods (5 can) - Status: Pending', NOW()),
  (3, 3, 'distributed', '2', 'Aguho Staff', 'staff@pateros.gov.ph', 'Distribution #3 - Garcia Family - Magtanggol - Rice (25 kg) - Status: Completed', NOW()),
  (4, 4, 'created', '2', 'Aguho Staff', 'staff@pateros.gov.ph', 'Distribution #4 - Mendoza Family - San Pedro - Canned Goods (10 can) - Status: Pending', NOW())
ON CONFLICT (activity_id) DO NOTHING;

-- Additional records: 100 families, 200 family members, 100 individuals,
-- 100 distributions, and matching activity logs.
INSERT INTO families
  (family_id, barangay_id, household_id, family_name, address, head_of_family, phone,
   monthly_income, food_assistance_status, is_npa, priority_score, is_active)
SELECT
  n,
  ((n - 1) % 10) + 1,
  CONCAT('HH-', LPAD(n::text, 4, '0')),
  CONCAT((ARRAY['Reyes', 'Cruz', 'Ramos', 'Garcia', 'Mendoza', 'Santos', 'Flores', 'Torres', 'Diaz', 'Lim'])[((n - 1) % 10) + 1], ' Household ', n),
  CONCAT(n, ' Community Street, Pateros'),
  CONCAT((ARRAY['Ana', 'Ramon', 'Lourdes', 'Maria', 'Jose', 'Elena', 'Carlos', 'Nena', 'Oscar', 'Teresa'])[((n - 1) % 10) + 1], ' Resident'),
  CONCAT('0917', LPAD((1000000 + n)::text, 7, '0')),
  6000 + ((n * 731) % 9001),
  (ARRAY['4Ps', 'Senior Citizen', 'PWD', 'None', 'Solo Parent'])[((n - 1) % 5) + 1],
  false,
  55 + ((n * 17) % 46),
  true
FROM generate_series(11, 110) AS series(n)
ON CONFLICT (family_id) DO NOTHING;

INSERT INTO family_members
  (member_id, family_id, first_name, last_name, date_of_birth, gender, relationship,
   is_pwd, height_cm, weight_kg, nutritional_status)
SELECT
  (n - 11) * 2 + member_offset + 4,
  n,
  (ARRAY['Ana', 'Ben', 'Carla', 'Daniel', 'Emy', 'Felix', 'Grace', 'Hugo', 'Iris', 'Joel'])[((n + member_offset) % 10) + 1],
  (ARRAY['Reyes', 'Cruz', 'Ramos', 'Garcia', 'Mendoza', 'Santos', 'Flores', 'Torres', 'Diaz', 'Lim'])[((n - 1) % 10) + 1],
  CURRENT_DATE - ((18 + ((n * member_offset) % 50)) * 365),
  CASE WHEN member_offset = 1 THEN 'Male' ELSE 'Female' END,
  CASE WHEN member_offset = 1 THEN 'Head' ELSE 'Child' END,
  (n % 11 = 0),
  CASE WHEN member_offset = 1 THEN 165 ELSE 145 END,
  CASE WHEN member_offset = 1 THEN 62 ELSE 42 END,
  CASE WHEN n % 7 = 0 THEN 'Underweight' ELSE 'Normal' END
FROM generate_series(11, 110) AS family_series(n)
CROSS JOIN generate_series(1, 2) AS member_series(member_offset)
ON CONFLICT (member_id) DO NOTHING;

INSERT INTO individuals
  (individual_id, name, date_of_birth, gender, barangay_id, status)
SELECT
  n,
  CONCAT((ARRAY['Pedro', 'Rosa', 'Mario', 'Celia', 'Rogelio', 'Gloria', 'Lito', 'Teresa', 'Nestor', 'Rosario'])[((n - 1) % 10) + 1], ' Individual ', n),
  CURRENT_DATE - ((40 + (n % 38)) * INTERVAL '1 year'),
  CASE WHEN n % 2 = 0 THEN 'Female' ELSE 'Male' END,
  ((n - 1) % 10) + 1,
  CASE WHEN n % 3 = 0 THEN 'Received' ELSE 'Registered' END
FROM generate_series(11, 110) AS series(n)
ON CONFLICT (individual_id) DO NOTHING;

INSERT INTO distribution
  (distribution_id, recipient_type, family_id, individual_id, barangay_id, food_id,
   quantity, date_given, status)
SELECT
  n - 2,
  'Family',
  n,
  NULL,
  ((n - 1) % 10) + 1,
  ((n - 11) % 5) + 1,
  5 + (n % 26),
  CURRENT_DATE - (n % 30),
  CASE WHEN n % 3 = 0 THEN 'Completed' ELSE 'Pending' END
FROM generate_series(11, 110) AS series(n)
ON CONFLICT (distribution_id) DO NOTHING;

INSERT INTO distribution_activity_logs
  (activity_id, distribution_id, action, staff_user_id, staff_name, staff_email,
   distribution_details, performed_at)
SELECT
  n - 6,
  n - 2,
  CASE WHEN n % 3 = 0 THEN 'distributed' ELSE 'created' END,
  '2',
  'Aguho Staff',
  'staff@pateros.gov.ph',
  CONCAT('Distribution #', n - 2, ' - Household ', n, ' - Pateros - Food supply - Status: ',
    CASE WHEN n % 3 = 0 THEN 'Completed' ELSE 'Pending' END),
  NOW() - ((n % 30) * INTERVAL '1 day')
FROM generate_series(11, 110) AS series(n)
ON CONFLICT (activity_id) DO NOTHING;

-- Keep identity-generated IDs above the explicit seed IDs for future inserts.
SELECT setval(pg_get_serial_sequence('families', 'family_id'), GREATEST((SELECT MAX(family_id) FROM families), 1));
SELECT setval(pg_get_serial_sequence('family_members', 'member_id'), GREATEST((SELECT MAX(member_id) FROM family_members), 1));
SELECT setval(pg_get_serial_sequence('individuals', 'individual_id'), GREATEST((SELECT MAX(individual_id) FROM individuals), 1));
SELECT setval(pg_get_serial_sequence('distribution', 'distribution_id'), GREATEST((SELECT MAX(distribution_id) FROM distribution), 1));
SELECT setval(pg_get_serial_sequence('distribution_activity_logs', 'activity_id'), GREATEST((SELECT MAX(activity_id) FROM distribution_activity_logs), 1));
