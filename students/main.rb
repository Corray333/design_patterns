require "./Student"
require "./StudentShort"

def main()
  students = []

  students << Student.new(
    1,
    "Anikin",
    "Mark",
    "Andreevich",
    phone: "89320509129",
    git: "github.com/Corray333"
  )
  students << Student.new(
    2,
    "Masenko",
    "Maria",
    "Sergeevna",
    phone: "89234567890"
  )

  students[0].set_contacts({
    tg_username: "@corray9",
    email: "mark.corray.off@gmail.com"
  })

  students.each do |student|
    p(student)
  end
end

main()