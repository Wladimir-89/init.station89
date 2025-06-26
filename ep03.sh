##!/bin/bash

clear

cat << "EOF"
[СТАНЦИЯ 89] ГЛАВА 2: ПРОСТРАНСТВО
EOF

ask_command() {
  local prompt="$1"
  local expected="$2"
  local user_input

  while true; do
    read -p "$prompt > " user_input
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

echo
echo ">> Внутри станции — коридоры каталогов. Посмотри вокруг:"
ask_command "\$" "ls"

echo ">> Ты можешь явно указать каталог, например — /usr"
ask_command "\$" "ls /usr"

echo ">> Или посмотреть подробности:"
ask_command "\$" "ls -l"

echo ">> Теперь — отсортируй по времени:"
ask_command "\$" "ls -lt"

echo ">> И наоборот:"
ask_command "\$" "ls -ltr"

echo ">> Перейди в каталог /usr/bin"
ask_command "\$" "cd /usr/bin"

echo ">> Определи тип исполняемого файла, например bash:"
ask_command "\$" "file bash"

echo ">> Посмотри содержимое исполняемого файла:"
ask_command "\$" "less bash"


echo
echo ">> Готов ли ты к следующему шагу?"
while true; do
  read -p "> " input
  input=$(echo "$input" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
  if [[ "$input" == "next" ]]; then
    echo ">>> Переход к следующей главе..."
    exit 0
  elif [[ "$input" == "exit" ]]; then
    echo ">>> Завершение сеанса. До встречи в глубинах структуры."
    exit 0
  else
    echo "Неверный ввод. Введи 'next' или 'exit'."
  fi
done
