require 'json'

class Student
  attr_reader :id, :surname, :name, :patronymic, :phone, :tg_username, :email, :git

  attr_writer :surname :name :patronymic :phone :tg_username :email :git

  @@current_id = 0
  def initialize(params = {})
    @@current_id += 1
    @id = @@current_id
    @surname = params[:surname]
    @name = params[:name]
    @patronymic = params[:patronymic]
    @phone = params[:phone]
    @tg_username = params[:tg_username]
    @email = params[:email]
    @git = params[:git]
  end

  def to_s()
    str = "Student: id = #{@id}, surname = #{@surname}, name = #{@name}, patronymic = #{@patronymic}"
    str += ", phone = #{@phone}" if @phone
    str += ", tg_username = #{@tg_username}" if @tg_username
    str += ", email = #{@email}" if @email
    str += ", git = #{@git}" if @git
    return str
  end

  def ==(other)
    if other.is_a? Student
      @id == other.id
    else
      false
    end
  end

  def to_hash()
    hash = {
      'id' => @id,
      'surname' => @surname,
      'name' => @name,
      'patronymic' => @patronymic
    }

    hash['phone'] = @phone if @phone
    hash['tg_username'] = @tg_username if @tg_username
    hash['email'] = @email if @email
    hash['git'] = @git if @git
    return hash

  end

  def to_json()
    JSON.pretty_generate(to_hash)
  end

  def inspect()
    to_json()
  end
end

student = Student.new(surname: 'Ivanov', name: 'Ivan', patronymic: 'Ivanovich', phone: '1234567', git: 'ivanov')
puts(student)
print(student.to_json)