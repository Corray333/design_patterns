-- +goose Up
-- +goose StatementBegin
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,           
    surname VARCHAR(100) NOT NULL,   
    name VARCHAR(100) NOT NULL,      
    patronymic VARCHAR(100) NOT NULL,        
    birthdate DATE NOT NULL,                  
    phone VARCHAR(15),               
    tg_username VARCHAR(128),            
    email VARCHAR(255),              
    git VARCHAR(255)                 
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE students;
-- +goose StatementEnd
