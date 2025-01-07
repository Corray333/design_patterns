-- +goose Up
-- +goose StatementBegin
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,           
    surname VARCHAR(100) NOT NULL,   
    name VARCHAR(100) NOT NULL,      
    patronymic VARCHAR(100) NOT NULL,        
    birthdate BIGINT NOT NULL,                  
    phone VARCHAR(15) UNIQUE,               
    tg_username VARCHAR(128) UNIQUE,            
    email VARCHAR(255) UNIQUE,              
    git VARCHAR(255) UNIQUE                 
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE students;
-- +goose StatementEnd
