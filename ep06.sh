#!/bin/bash

clear

#!/bin/bash

clear

cat << "EOF"
[СТАНЦИЯ 89] ГЛАВА 6: Потоки и Перенаправление  
***   ***   ***

Ты научился звать команды.  
Теперь научись управлять их голосом.

Программа может говорить — это вывод.  
Программа может слушать — это ввод.  
Программа может жаловаться — это ошибки.

Ты научишься:
>     перенаправлять вывод
>     подавлять ошибки
>     читать из файлов
>     строить конвейеры

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

echo ">> Перенаправь вывод команды в файл:"
ask_command "\$" "ls -l /usr/bin > out.txt"

echo ">> Посмотри, что получилось:"
ask_command "\$" "cat out.txt"

echo ">> Попробуй вызвать ошибку и сохранить её:"
ask_command "\$" "ls -l /bin/usr 2> err.txt"

echo ">> А теперь выведи ошибки:"
ask_command "\$" "cat err.txt"

echo ">> Перенаправь и вывод, и ошибки в один файл:"
ask_command "\$" "ls -l /bin/usr > all.txt 2>&1"

echo ">> Или используй сокращённую запись:"
ask_command "\$" "ls -l /bin/usr &> all.txt"

echo ">> Создай или очисти файл:"
ask_command "\$" "> zero.txt"

echo ">> Удали ошибки, направив их в бездну:"
ask_command "\$" "ls -l /bin/usr 2> /dev/null"

echo ">> Перенаправь ввод из файла:"
ask_command "\$" "cat < out.txt"

echo ">> Построй конвейер с подсчётом строк:"
ask_command "\$" "ls /bin /usr/bin | sort | uniq | wc -l"

echo ">> Найди команды, связанные с zip:"
ask_command "\$" "ls /bin /usr/bin | sort | uniq | grep zip"

echo ">> Сохрани вывод, но и продолжи работу:"
ask_command "\$" "ls /usr/bin | tee all.txt | grep zip"

cat << "EOF"

Теперь ты управляешь потоками данных.  
Ты знаешь: команды — это ручьи,  
а ты — проводник.

Это уже почти программирование.
Но это — пока только *шаг* к нему.
EOF

echo
echo ">> Глава завершена. Продолжим?"
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

