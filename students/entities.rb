require "json"


class StudentBase

  def initialize(id, git: nil)
    raise ArgumentError, "Invalid or missing git" if git && !StudentBase.is_git?(git)

    @id = id
    @git = git
  end

  def to_hash()
    raise NotImplementedError, "to_hash method is not implemented for class #{self}"
  end

  def to_json()
    JSON.generate(to_hash)
  end

  def inspect()
    JSON.pretty_generate(to_hash)
  end

  def self.from_string(serialized_data)
    raise NotImplementedError, "from_string method is not implemented for class #{self}"
  end

  def valid?()
    raise NotImplementedError, "valid? method is not implemented for class #{self}"
  end

  def self.is_phone_number?(phone_number)
    return false if phone_number == nil
    return phone_number.match?(/^\d{11}$/)
  end

  def self.is_email?(email)
    return false if email == nil
    return email.match?(/^[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$/)
  end

  def self.is_tg_username?(tg_username)
    return false if tg_username == nil
    return tg_username.match?(/^@[a-zA-Z0-9_]{5,32}$/)
  end

  def self.is_git?(git)
    return false if git == nil
    return git.match?(/^(https:\/\/)?(www\.)?github.com\/[a-zA-Z0-9_-]+$/)
  end

  def self.is_name?(val)
    return false if val == nil
    return val.match?(/^[A-Z][a-z]+$/)
  end

  def self.read_from_txt(file_path)
    raise ArgumentError, "Invalid file path" unless File.file?(file_path)
    students = []
    File.open(file_path, "r") do |file|
      file.each_line do |line|
        json_data = JSON.parse(line)

        # string keys to symbols
        symbolized_data = json_data.transform_keys(&:to_sym)
        students << self.from_hash(**symbolized_data)
      end
    end
    return students
  end

  def self.write_to_txt(file_path, students)
    File.open(file_path, "w") do |file|
      students.each do |student|
        file.puts(student.to_json)
      end
    end
  end

  def contact()
    raise NotImplementedError, "contact method is not implemented for class #{self}"
  end

end


class Student < StudentBase
  attr_accessor :surname, :name, :patronymic, :git
  attr_reader :id, :phone, :tg_username, :email

  def initialize(id, surname, name, patronymic, phone: nil, tg_username: nil, email: nil, git: nil)
    raise ArgumentError, "Invalid or missing surname" unless surname && Student.is_name?(surname)
    raise ArgumentError, "Invalid or missing name" unless name && Student.is_name?(name)
    raise ArgumentError, "Invalid or missing patronymic" unless patronymic && Student.is_name?(patronymic)

    super(id, git: git)
    self.surname = surname
    self.name = name
    self.patronymic = patronymic
    self.phone = phone
    self.tg_username = tg_username
    self.email = email
  end

  def self.from_hash(id: nil, surname: nil, name: nil, patronymic: nil, phone: nil, tg_username: nil, email: nil, git: nil)
    return Student.new(
      id, 
      surname,
      name,
      patronymic,
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

  private def surname=(new_val)
    @surname = new_val if new_val && Student.is_name?(new_val)
  end

  private def name=(new_val)
    @name = new_val if new_val && Student.is_name?(new_val)
  end

  private def patronymic=(new_val)
    @patronymic = new_val if new_val && Student.is_name?(new_val)
  end

  private def email=(new_val)
    @email = new_val if new_val && Student.is_email?(new_val)
  end

  private def phone=(new_val)
    @phone = new_val if new_val && Student.is_phone_number?(new_val)
  end 

  private def tg_username=(new_val)
    @tg_username = new_val if new_val && Student.is_tg_username?(new_val)
  end


  def write_to_txt(file_path)
    # TODO: mayby "a"?
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
      id: @id,
      surname: @surname,
      name: @name,
      patronymic: @patronymic
    }

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

  def get_info()
    return self.to_s()
  end
end


class StudentShort < StudentBase
  attr_reader :id, :fio, :git, :contact


  def initialize(id, fio, git, contact)
    super(id, git: git)

    @fio = fio
    @contact = contact
  end

  def self.from_hash(id: nil, fio: nil, git: nil, contact: nil)
    raise ArgumentError, "Missing :fio" unless params.key?(:fio)
    raise ArgumentError, "Missing :contact" unless params.key?(:contact)

    return StudentShort.new(id, fio, git, contact)
  end

  def self.from_string(id, data)
    fio = ""
    git = ""
    contact = ""

    data.split(",").map do |field|

      pair = field.split("=")
      
      if pair.length != 2
        raise ArgumentError, "Invalid data format"
      end
      
      case pair[0].strip
      when "fio"
        fio = pair[1].strip
      when "git"
        git = pair[1].strip
      when "contact"
        contact = pair[1].strip
      else
        raise ArgumentError, "Invalid data format"
      end
    end
    return StudentShort.new(id, fio, git, contact)
  end

  def to_hash()
    hash = {
      "id": @id,
      "fio": @fio,
      "git": @git,
      "contact":contact
    }
    return hash
  end

  def valid?()
    contact = @contact.split("=")
    return (Student.is_phone_number?(contact[1]) || Student.is_tg_username?(contact[1]) || Student.is_email?(contact[1])) && Student.is_git?(@git)
  end

end
