#!/bin/bash

clear

cat << "EOF"
[СТАНЦИЯ 89] ГЛАВА 4: Взаимодействие с окружением
***   ***   ***

Теперь ты готов приступить к настоящей работе! В этой главе будут представ-
лены пять наиболее часто используемых команд Linux:

cp     — копирует файлы и каталоги  
mv     — перемещает/переименовывает  
mkdir  — создаёт каталоги  
rm     — удаляет  
ln     — создаёт ссылки  

***   ***   ***
Групповые символы (wildcards):
*        — любая последовательность  
?        — один любой символ  
[abc]    — один символ из набора  
[!abc]   — всё, кроме символов из набора  
[[:digit:]] — символ из класса (например, цифра)

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
echo ">> Создадим рабочую зону — песочницу для экспериментов:"
echo "Перейдите в домашний каталог:"
ask_command "\$" "cd"
echo "Создайте каталог playground:"
ask_command "\$" "mkdir playground"
echo "Перейдите в каталог playground:"
ask_command "\$" "cd playground"
echo "Создайте два подкаталога:"
ask_command "\$" "mkdir dir1 dir2"

echo
echo ">> Скопируем файл /etc/passwd в текущий каталог:"
ask_command "\$" "cp /etc/passwd ."

echo "Проверьте содержимое каталога:"
ask_command "\$" "ls"

echo
echo "Теперь скопируйте файл ещё раз с параметром -v:"
ask_command "\$" "cp -v /etc/passwd passwd2"

echo "Попробуйте скопировать ещё раз с флагом -i (interactive):"
ask_command "\$" "cp -i /etc/passwd passwd2"

echo
echo ">> Переименуем файл passwd в fun:"
ask_command "\$" "mv passwd fun"

echo "Переместите файл fun в каталог dir1:"
ask_command "\$" "mv fun dir1"

echo "Верните его обратно в текущий каталог:"
ask_command "\$" "mv dir1/fun ."

echo "Теперь переместите его в dir2:"
ask_command "\$" "mv fun dir2"

echo "И снова верните:"
ask_command "\$" "mv dir2/fun ."

echo "Теперь ты попробуешь создать связи — как реальные, так и символические.

Жесткие и символические ссылки — это разные способы связать имя с данными.
Ты научишься отличать их, видеть, как устроена файловая система под капотом."

echo ">> Перейдите в каталог ~/playground:"
ask_command "\$" "cd ~/playground"

echo ">> Убедитесь, что файл fun существует:"
ask_command "\$" "ls fun"

echo ">> Создайте жёсткую ссылку:"
ask_command "\$" "ln fun fun-hard"

echo ">> Создайте ещё одну жёсткую ссылку в подкаталоге dir1:"
ask_command "\$" "ln fun dir1/fun-hard"

echo ">> И ещё одну в dir2:"
ask_command "\$" "ln fun dir2/fun-hard"

echo
echo ">> Посмотрите список файлов с деталями:"
ask_command "\$" "ls -l"

echo ">> Посмотрите номера inode (номер индексного узла):"
ask_command "\$" "ls -li"

cat << "EOF"

Обрати внимание на одинаковые номера inode у fun и fun-hard —
это и есть подтверждение, что они ссылаются на одни и те же данные.

Жёсткая ссылка — это как второе имя, записанное рядом на том же камне.

EOF

echo
echo ">> Теперь создадим символическую ссылку:"
ask_command "\$" "ln -s fun fun-sym"

echo ">> И символическую ссылку внутри dir1:"
ask_command "\$" "ln -s ../fun dir1/fun-sym"

echo ">> И в dir2:"
ask_command "\$" "ln -s ../fun dir2/fun-sym"

echo ">> Посмотри, как это выглядит:"
ask_command "\$" "ls -l dir1"

cat << "EOF"

Файл fun-sym в dir1 — это символическая ссылка.
Символ "l" в первом столбце и стрелка -> говорят об этом прямо.

Символическая ссылка — это просто текстовая стрелка.
Она хранит путь, а не данные.

EOF

echo
echo ">> Напоследок — создай символическую ссылку на каталог:"
ask_command "\$" "ln -s dir1 dir1-sym"

echo ">> И посмотри результат:"
ask_command "\$" "ls -l"

cat << "EOF"
Файлы живут, пока на них есть ссылки.  
Удаление — это не уничтожение, а просто убирание имён.

Ты попробуешь убрать ссылки — и посмотреть, как система реагирует.
EOF
echo ">> Перейди в каталог ~/playground:"
ask_command "\$" "cd ~/playground"

echo ">> Удали одну из жёстких ссылок:"
ask_command "\$" "rm fun-hard"

echo ">> Посмотри, как изменилась структура:"
ask_command "\$" "ls -l"

echo
echo ">> Удали основной файл fun, используя флаг -i для подтверждения:"
ask_command "\$" "rm -i fun"

echo ">> Посмотри снова, что произошло с символическими ссылками:"
ask_command "\$" "ls -l"

cat << "EOF"

Ты увидел: fun исчез.  
А символическая ссылка fun-sym осталась — но она теперь «битая».  
Она указывает в пустоту.

Попробуй обратиться к битой ссылке:

EOF

ask_command "\$" "less fun-sym"

cat << "EOF"

Ошибка ожидаема: ссылка ведёт в никуда.

Удалим её — вместе с dir1-sym:

EOF

ask_command "\$" "rm fun-sym dir1-sym"

echo ">> Проверь содержимое каталога:"
ask_command "\$" "ls -l"

cat << "EOF"

Важно: команда rm удаляет **ссылку**, а не файл.  
Если это символическая ссылка — удаляется именно она, а не цель.

EOF

echo
echo ">> Последний шаг: удали всю песочницу:"
ask_command "\$" "cd"
ask_command "\$" "rm -r playground"

cat << "EOF"

Прощай, playground.

Ты завершил главу 4. Удаление — не конец. Это очищение пространства.
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

