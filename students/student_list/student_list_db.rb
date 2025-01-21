require 'pg'
require './entities/student'
require './entities/student_short'

class StudentListDB
  def initialize
    @connection = PG.connect(
      dbname: 'students',
      user: 'postgres',
      password: 'w4OiIiE9Sx52',
      host: 'localhost',
      port: 5432
    )
  end

  def get_student_by_id(id)
    result = @connection.exec_params('SELECT * FROM students WHERE student_id = $1', [id])
    return nil if result.ntuples.zero?
    Student.from_hash(
        id: result[0]['student_id'].to_i,
        surname: result[0]['surname'],
        name: result[0]['name'],
        patronymic: result[0]['patronymic'],
        git: result[0]['git'],
        phone: result[0]['phone'],
        tg_username: result[0]['tg_username'],
        email: result[0]['email'],
        birthdate: result[0]['birthdate'].to_i
    )
  end

  def get_student_page(page, limit)
    offset = (page - 1) * limit
    query = <<~SQL
      SELECT student_id, surname, name, patronymic, git, phone, tg_username, email FROM students
      ORDER BY surname, name, patronymic
      LIMIT $1 OFFSET $2
    SQL

    result = @connection.exec_params(query, [limit, offset])
    students = result.map { |row| StudentShort.from_student(
        Student.from_hash(
        id: row['student_id'].to_i,
        surname: row['surname'],
        name: row['name'],
        patronymic: row['patronymic'],
        git: row['git'],
        phone: row['phone'],
        tg_username: row['tg_username'],
        email: row['email'],
        birthdate: row['birthdate'].to_i
    )
    ) }

    data_list = DataListStudentShort.new(students)
    data_list.index = offset
    data_list.data = students
    data_list
  end

  def add_student(student)
    new_id = next_id
    query = <<~SQL
      INSERT INTO students (student_id, surname, name, patronymic, git, phone, tg_username, email, birthdate)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      RETURNING student_id
    SQL

    @connection.exec_params(query, [
      new_id,
      student.surname,
      student.name,
      student.patronymic,
      student.git,
      student.phone,
      student.tg_username,
      student.email,
      student.birthdate
    ])

    new_id
  end

  def update_student(student)
    p("Birthdate: #{student.birthdate}")
    query = <<~SQL
      UPDATE students
      SET surname = $1, name = $2, patronymic = $3, git = $4, phone = $5, tg_username = $6, email = $7, birthdate = $8
      WHERE student_id = $9
    SQL

    @connection.exec_params(query, [
      student.surname,
      student.name,
      student.patronymic,
      student.git,
      student.phone,
      student.tg_username,
      student.email,
      student.birthdate,
      student.id
    ])
  end

  def delete_by_id(id)
    @connection.exec_params('DELETE FROM students WHERE student_id = $1', [id])
  end

  def count
    result = @connection.exec('SELECT COUNT(*) FROM students')
    result[0]['count'].to_i
  end

  @instance = nil 

  private_class_method :new 

  def self.instance
    @instance ||= new 
  end
end
