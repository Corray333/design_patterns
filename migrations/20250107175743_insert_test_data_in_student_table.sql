-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO students (surname, name, patronymic, birthdate, phone, tg_username, email, git) VALUES
('Doe', 'John', 'Michael', 631152000, '1234567890', 'johndoe', 'john.doe@example.com', 'https://github.com/johndoe'),
('Smith', 'Jane', 'Ann', 696902400, '0987654321', 'janesmith', 'jane.smith@example.com', 'https://github.com/janesmith'),
('Brown', 'Charlie', 'David', 574560000, '1122334455', 'charliebrown', 'charlie.brown@example.com', 'https://github.com/charliebrown'),
('Johnson', 'Emily', 'Grace', 797299200, '2233445566', 'emilyjohnson', 'emily.johnson@example.com', 'https://github.com/emilyjohnson'),
('Williams', 'Daniel', 'James', 737856000, '3344556677', 'danielwilliams', 'daniel.williams@example.com', 'https://github.com/danielwilliams'),
('Jones', 'Olivia', 'Marie', 646790400, '4455667788', 'oliviajones', 'olivia.jones@example.com', 'https://github.com/oliviajones'),
('Garcia', 'Lucas', 'Henry', 615168000, '5566778899', 'lucasgarcia', 'lucas.garcia@example.com', 'https://github.com/lucasgarcia'),
('Martinez', 'Sophia', 'Isabella', 776275200, '6677889900', 'sophiamartinez', 'sophia.martinez@example.com', 'https://github.com/sophiamartinez'),
('Rodriguez', 'Mason', 'Alexander', 842688000, '7788990011', 'masonrodriguez', 'mason.rodriguez@example.com', 'https://github.com/masonrodriguez'),
('Lee', 'Ava', 'Elizabeth', 876096000, '8899001122', 'avale', 'ava.lee@example.com', 'https://github.com/avale');

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM students WHERE email IN (
    'john.doe@example.com',
    'jane.smith@example.com',
    'charlie.brown@example.com',
    'emily.johnson@example.com',
    'daniel.williams@example.com',
    'olivia.jones@example.com',
    'lucas.garcia@example.com',
    'sophia.martinez@example.com',
    'mason.rodriguez@example.com',
    'ava.lee@example.com'
);