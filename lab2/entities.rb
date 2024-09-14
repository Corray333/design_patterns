# student.rb
class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :tg_username, :email, :git

  def initialize(surname, name, patronymic, id = nil, phone = nil, tg_username = nil, email = nil, git = nil)
    @id = id
    @surname = surname
    @name = name
    @patronymic = patronymic
    @phone = phone
    @tg_username = tg_username
    @email = email
    @git = git
  end

  def to_s
    "Student: id = #{@id}, surname = #{@surname}, name = #{@name}, patronymic = #{@patronymic}, phone = #{@phone}, telegram username = #{@tg_username}, email = #{@email}, git = #{@git}"
  end
end
