require "json"

class Student
  attr_accessor :surname, :name, :patronymic, :tg_username, :email, :git
  attr_reader :phone
  attr_reader :id

  @@current_id = 0
  def initialize(params = {})
    raise ArgumentError, "Attribute id can't be defined" if params.key?(:id)
    raise ArgumentError, "Missing :surname" unless params.key?(:surname)
    raise ArgumentError, "Missing :name" unless params.key?(:name)
    raise ArgumentError, "Missing :patronymic" unless params.key?(:patronymic)

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

  def phone=(phone)
    raise ArgumentError, "Invalid phone number" unless Student.is_phone_number?(phone)
    @phone = phone
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
    JSON.pretty_generate(to_hash)
  end

  def inspect()
    to_json()
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

  
end

