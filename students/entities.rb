require "json"

class Student
  attr_accessor :surname, :name, :patronymic, :git
  attr_reader :id, :phone, :tg_username, :email

  def initialize(params)
    raise ArgumentError, "Missing :id" unless params.key?(:id)
    raise ArgumentError, "Missing :surname" unless params.key?(:surname)
    raise ArgumentError, "Missing :name" unless params.key?(:name)
    raise ArgumentError, "Missing :patronymic" unless params.key?(:patronymic)

    raise ArgumentError, "Invalid or missing phone number" if params.key?(:phone) && !Student.is_phone_number?(params[:phone])
    raise ArgumentError, "Invalid or missing tg_username" if params.key?(:tg_username) && !Student.is_tg_username?(params[:tg_username])
    raise ArgumentError, "Invalid or missing email" if params.key?(:email) && !Student.is_email?(params[:email])
    raise ArgumentError, "Invalid or missing git" if params.key?(:git) && !Student.is_git?(params[:git])

    @id = params[:id]
    @surname = params[:surname]
    @name = params[:name]
    @patronymic = params[:patronymic]
    @phone = params[:phone]
    @tg_username = params[:tg_username]
    @email = params[:email]
    @git = params[:git]
  end

  def self.read_from_txt(file_path)
    raise ArgumentError, "Invalid file path" unless File.file?(file_path)
    students = []
    File.open(file_path, "r") do |file|
      file.each_line do |line|
        json_data = JSON.parse(line)

        # string keys to symbols
        symbolized_data = json_data.transform_keys(&:to_sym)
        students << Student.new(symbolized_data)
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

  def write_to_txt(file_path)
    File.open(file_path, "w") do |file|
      file.puts(self.to_json)
    end
  end

  def phone=(phone)
    raise ArgumentError, "Invalid phone number" unless Student.is_phone_number?(phone)
    @phone = phone
  end

  def to_s()
    str = "fio = #{@surname} #{@name[0]}. #{@patronymic[0]}"
    str += ", git = #{@git}" if @git
    contact = ""
    if @phone
      contact = @phone
    elsif @tg_username
      contact = @tg_username
    elsif @email
      contact = @email
    end
    str += ", contact = #{contact}"
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
      "id" => @id,
      "surname" => @surname,
      "name" => @name,
      "patronymic" => @patronymic
    }

    hash["phone"] = @phone if @phone
    hash["tg_username"] = @tg_username if @tg_username
    hash["email"] = @email if @email
    hash["git"] = @git if @git
    return hash

  end

  def to_json()
    JSON.generate(to_hash)
  end

  def inspect()
    JSON.pretty_generate(to_hash)
  end

  def self.from_json(json)
    return Student.new(JSON.parse(json))
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

  def valid?()
    return Student.is_git?(@git) && (Student.is_email?(@email) || Student.is_phone_number?(@phone) || Student.is_tg_username?(@tg_username))
  end

  def set_contacts(params = {})
    @phone = params[:phone] if params.key?(:phone) && Student.is_phone_number?(params[:phone])
    @tg_username = params[:tg_username] if params.key?(:tg_username) && Student.is_tg_username?(params[:tg_username])
    @email = params[:email] if params.key?(:email) && Student.is_email?(params[:email])
  end

  def get_info()
    return self.to_s()
  end
end


class StudentShort
  attr_reader :id, :fio, :git, :contact

  def initialize(params = {})
    raise ArgumentError, "Missing :id" unless params.key?(:id)
    raise ArgumentError, "Missing :fio" unless params.key?(:fio)
    raise ArgumentError, "Missing :git" unless params.key?(:git)
    raise ArgumentError, "Missing :contact" unless params.key?(:contact)

    raise ArgumentError, "Invalid git" unless Student.is_git?(params[:git])

    @id = params[:id]
    @fio = params[:fio]
    @git = params[:git]
    @contact = params[:contact]
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
    return StudentShort.new(id: id, fio: fio, git: git, contact: contact)
  end
end