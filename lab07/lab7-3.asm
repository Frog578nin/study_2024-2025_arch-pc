%include 'in_out.asm'  ; Подключение внешнего файла

SECTION .data
    msg1:   db 'Введите A: ', 0
    msg2:   db 'Введите B: ', 0
    msg3:   db 'Введите C: ', 0
    msg_res: db 'Наименьшее число: ', 0
    A:      dd 0  ; Переменные для хранения A, B, и C
    B:      dd 0
    C:      dd 0

SECTION .bss
    min:    resd 4  ; Переменная для хранения наименьшего числа

SECTION .text
    global _start

_start:
    ; ---- Ввод A ----
    mov eax, msg1    ; Вывод сообщения "Введите A:"
    call sprint
    mov ecx, A       ; Адрес переменной A
    mov edx, 10      ; Максимальная длина ввода
    call sread        ; Ввод значения
    mov eax, A
    call atoi        ; Преобразование строки в целое, результат в EAX
    mov [A], eax       ; Записываем преобразованное число в A

    ; ---- Ввод B ----
    mov eax, msg2    ; Вывод сообщения "Введите B:"
    call sprint
    mov ecx, B       ; Адрес переменной B
    mov edx, 10      ; Максимальная длина ввода
    call sread        ; Ввод значения
    mov eax, B
    call atoi        ; Преобразование строки в целое, результат в EAX
    mov [B], eax       ; Записываем преобразованное число в B

     ; ---- Ввод C ----
    mov eax, msg3    ; Вывод сообщения "Введите C:"
    call sprint
    mov ecx, C       ; Адрес переменной C
    mov edx, 10      ; Максимальная длина ввода
    call sread        ; Ввод значения
    mov eax, C
    call atoi        ; Преобразование строки в целое, результат в EAX
    mov [C], eax       ; Записываем преобразованное число в C

    ; ---- Сравнение A и B ----
    mov eax, [A]     ; Загрузка значения A в eax
    mov ebx, [B]     ; Загрузка значения B в ebx
    cmp eax, ebx      ; Сравнение A и B
    jle check_C      ; Если A <= B, перейти к сравнению с C
    mov eax, ebx      ; Если A > B, то  eax = B
    ; иначе  eax = A
    mov [min],eax      ; Сохраняем меньшее из A и B в min
    jmp check_C_2    ; Пропустить следующую строчку, если A<=B

    check_C:
      mov eax,[A]    ; eax = A
    mov [min],eax    ; Сохраняем меньшее из A и B в min


     check_C_2:
    ; ---- Сравнение min и C ----
    mov eax, [min]   ; Загрузка значения min(A,  в eax
    mov ebx, [C]     ; Загрузка значения C в ebx
    cmp eax, ebx      ; Сравнение min(A,и C
    jle fin          ; Если min(A, <= C, перейти к fin
    mov eax, ebx      ; Если min(A,B) > C, то min(A,B,C) = C
    mov [min],eax
    ; иначе min(A,B,C)=min(A,B)

    ; ---- Вывод результата ----
    fin:
        mov eax, msg_res ; Вывод сообщения "Наименьшее число: "
        call sprint
        mov eax, [min] ; Загрузка наименьшего числа из min
        call iprint    ; Вывод наименьшего числа
        call quit       ; Завершение программы
