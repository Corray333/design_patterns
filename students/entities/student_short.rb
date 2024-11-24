require "json"
require "./entities/student_base"


class StudentShort < StudentBase
  attr_reader :fio, :contact, :git

  # private_class_method :new


  def initialize(id, fio, git, contact)
    super(id:id, git: git)
    @fio = fio
    @contact = contact
  end

  def self.from_string(data, id: nil)
    fio = nil
    git = nil
    contact = nil

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
    return new(id, fio, git, contact)
  end

  def to_hash()
    hash = {
      "fio": @fio,
      "contact": @contact
    }
    hash[:id] = @id if @id
    hash[:git] = @git if @git
    return hash
  end

  def to_s()
    return "id: #{@id}, fio: #{@fio}, git: #{@git}, contact: #{@contact}"
  end

  def valid?()
    return (Student.is_phone_number?(@contact) || Student.is_tg_username?(@contact) || Student.is_email?(@contact)) && Student.is_git?(@git)
  end

end
