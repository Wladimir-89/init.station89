#!/bin/bash

clear

cat << "EOF"
[СТАНЦИЯ 89] ГЛАВА 5: Распознавание и Имена  
***   ***   ***

Ты среди команд. Ты используешь их.  
Но знаешь ли ты, кто они?  
Пора научиться распознавать.

Сегодня ты изучишь:

type    — что за команда перед тобой?  
which   — где она находится?  
help    — краткая справка  
man     — полное руководство  
whatis  — краткое описание  
apropos — подходящие команды  
info    — гиперссылочный справочник  
alias   — создание собственных имён

***   ***   ***
EOF

ask_command() {
  local prompt="$1"
  local expected="$2"
  local user_input

  while read -p "$prompt > " user_input; do
    
    if [[ "$user_input" == "$expected" ]]; then
      echo "Верно."
      echo
      break
    else
      echo "Неверно. Попробуй ещё раз."
      echo
    fi
  done
}

echo ">> Проверь тип различных команд:"
ask_command "\$" "type ls"
ask_command "\$" "type cd"
ask_command "\$" "type cp"

echo ">> Определи путь к исполняемой программе:"
ask_command "\$" "which ls"
ask_command "\$" "which cd"

echo ">> Получи краткую справку по встроенной команде:"
ask_command "\$" "help cd"

echo ">> Получи помощь через --help:"
ask_command "\$" "mkdir --help"

echo ">> Открой man-страницу:"
ask_command "\$" "man ls"

echo ">> Выведи краткое описание команды:"
ask_command "\$" "whatis ls"

echo ">> Найди команды, связанные с разделами:"
ask_command "\$" "apropos partition"

echo ">> Попробуй hypertext-справку:"
ask_command "\$" "info ls"

cat << "EOF"
Теперь ты научился находить информацию.  
Ты видишь: команда — это не просто слово.  
У неё есть форма, содержание и история.
EOF

echo
echo ">> Создай псевдоним для последовательности действий:"
ask_command "\$" "alias foo='cd /usr; ls; cd -'"

echo ">> Проверь его:"
ask_command "\$" "type foo"

echo ">> Вызови его:"
ask_command "\$" "foo"

echo ">> Удали псевдоним:"
ask_command "\$" "unalias foo"

cat << "EOF"

Команды можно называть.  
Ты создаёшь имена, ты управляешь действиями.  
Это первый шаг к скриптам и автоматизации.

EOF

echo
echo ">> Глава завершена. Готов ли ты к следующей?"
while true; do
  read -p "> " input
  input=$(echo "$input" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
  if [[ "$input" == "next" ]]; then
    echo ">>> Переход к следующей главе..."
    exit 0
  elif [[ "$input" == "exit" ]]; then
    echo ">>> Завершение сеанса. До встречи."
    exit 0
  else
    echo "Неверный ввод. Введи 'next' или 'exit'."
  fi
done


