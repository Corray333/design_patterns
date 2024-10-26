require "json"

class StudentBase
  attr_reader :id, :git

  def initialize(id: nil, git: nil)
    @id = id
    @git = git
  end

  def git=(new_val)
    @git = new_val if new_val && Student.is_git?(new_val)
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

  def has_contact?()
    return self.contact != nil
  end

  def has_git?()
    return StudentBase.is_git?(@git)
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