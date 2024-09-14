# Task1: Установить компилятор и текстовый редактор. Реализовать и вызвать Hello World c комментарием. (ну как всегда)
printf("Hello, World!\n")

# Принять имя пользователя как аргумент программы. Поздороваться с пользователем с использованием форматирования строки. Спросить какой язык у пользователя любимый, в случае, если это ruby, ответить что пользователь подлиза, иначе обязательно ответить, что скоро будет ruby и поставить различные комментарии для нескольких языков.
if ARGV.length > 0
  name = ARGV[0]
  printf("Привет, %s!\n", name)
end

ARGV.clear

printf("Какой твой любимый язык?\n")
language = gets.chomp
case language
when "ruby"
  printf("А ты подлиза, %s)\n", name)
when "python"
  print("Фи, зачем ты на нем пишешь?\n")
when "go"
  print("Вот это уважаемо. Go - самые православный ЯП.\n")
else
  printf("О, да ты фанат %s. Ты полюбишь Ruby совсем скоро, обещаю.\n", language, name)
end

# Продолжение предыдущего задания. Попросить пользователя ввести команду языка ruby. И команду OC. Выполнить команду руби и команду операционной системы.
print("Введи команду языка Ruby:\n")
ruby_command = gets.chomp
print(eval(ruby_command))

print("Введи команду ОС:\n")
os_command = gets.chomp
print(`#{os_command}`)