require "./entities"

def main()
  students = []

  students << Student.new(
    :id => 1,
    surname: "Anikin",
    name: "Mark",
    patronymic: "Andreevich",
    phone: "89320509129",
    git: "github.com/Corray333"
  )
  students << Student.new({
    id:2,
    surname: "Masenko",
    name: "Maria",
    patronymic: "Sergeevna",
    phone: "89234567890",
  })

  students[0].set_contacts({
    tg_username: "@corray9",
    email: "mark.corray.off@gmail.com"
  })

  students.each do |student|
    p(student)
  end
end

