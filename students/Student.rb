require "json"
require "./StudentBase"

class Student < StudentBase
  attr_reader :phone, :tg_username, :email

  def initialize(surname, name, patronymic, id: nil, phone: nil, tg_username: nil, email: nil, git: nil)
    raise ArgumentError, "Invalid or missing surname" unless surname && Student.is_name?(surname)
    raise ArgumentError, "Invalid or missing name" unless name && Student.is_name?(name)
    raise ArgumentError, "Invalid or missing patronymic" unless patronymic && Student.is_name?(patronymic)

    super(id: id, git: git)
    @surname = surname
    @name = name
    @patronymic = patronymic
    @phone = phone
    @tg_username = tg_username
    @email = email
  end

  def self.from_hash(id: nil, surname: nil, name: nil, patronymic: nil, phone: nil, tg_username: nil, email: nil, git: nil)
    return Student.new(
      surname,
      name,
      patronymic,
      id: id,
      phone: phone,
      tg_username: tg_username,
      email: email,
      git: git
      )
  end

  def contact()
    return @phone if @phone
    return @tg_username if @tg_username
    return @email if @email
  end

  def surname=(new_val)
    @surname = new_val if new_val && Student.is_name?(new_val)
  end

  def name=(new_val)
    @name = new_val if new_val && Student.is_name?(new_val)
  end

  def patronymic=(new_val)
    @patronymic = new_val if new_val && Student.is_name?(new_val)
  end

  def email=(new_val)
    @email = new_val if new_val && Student.is_email?(new_val)
  end

  def phone=(new_val)
    @phone = new_val if new_val && Student.is_phone_number?(new_val)
  end 

  def tg_username=(new_val)
    @tg_username = new_val if new_val && Student.is_tg_username?(new_val)
  end

  def write_to_txt(file_path)
    File.open(file_path, "w") do |file|
      file.puts(self.to_json)
    end
  end

  def to_s()
    result = "fio = #{@surname} #{@name[0]}. #{@patronymic[0]}"
    result += ", git = #{@git}" if @git
    result += ", contact = #{self.contact}" if self.contact
    return result
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
      surname: @surname,
      name: @name,
      patronymic: @patronymic
    }

    hash[:id] = @id if @id
    hash[:phone] = @phone if @phone
    hash[:tg_username] = @tg_username if @tg_username
    hash[:email] = @email if @email
    hash[:git] = @git if @git
    return hash
  end

  def self.from_json(serialized_data)
    return Student.new(JSON.parse(serialized_data))
  end

  def self.from_string(serialized_data)
    return Student.from_json(serialized_data)
  end

  def valid?()
    return Student.is_git?(@git) && (Student.is_email?(@email) || Student.is_phone_number?(@phone) || Student.is_tg_username?(@tg_username))
  end

  def set_contacts(phone: nil, tg_username: nil, email: nil)
    self.phone = phone
    self.tg_username = tg_username
    self.email = email
  end
end
