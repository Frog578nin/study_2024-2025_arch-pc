%include 'in_out.asm'   ; Подключение внешнего файла

SECTION .data
    msg_x:   db 'Введите значение x: ', 0
    msg_a:   db 'Введите значение a: ', 0
    msg_res: db 'Результат: ', 0

SECTION .bss
    x:       resd 4     ; Переменные для хранения x и a
    a:       resd 4

SECTION .text
    global _start

_start:
    ; ---- Ввод x ----
    mov eax, msg_x    ; Вывод сообщения "Введите значение x:"
    call sprint
    mov ecx, x        ; Адрес переменной x
    mov edx, 10       ; Максимальная длина ввода
    call sread
    mov eax, x
    call atoi         ; Преобразование строки в целое, результат в EAX
    mov [x], eax

    ; ---- Ввод a ----
    mov eax, msg_a    ; Вывод сообщения "Введите значение a:"
    call sprint
    mov ecx, a        ; Адрес переменной a
    mov edx, 10       ; Максимальная длина ввода
    call sread
    mov eax, a
    call atoi         ; Преобразование строки в целое, результат в EAX
    mov [a], eax

    ; ---- Проверка условия x >= a ----
    mov eax, [x]      ; Загрузка значения x
    mov ebx, [a]      ; Загрузка значения a
    cmp eax, ebx      ; Сравнение x и a
    jge calc_x_minus_a  ; Если x >= a, переходим к вычислению x - a

    ; ---- Если x < a, то f(x) = 5 ----
    mov eax, 5        ; Загрузка значения 5 в eax
    jmp print_result   ; Переход к выводу результата

    ; ---- Вычисление x - a ----
    calc_x_minus_a:
        mov eax, [x]   ; Загрузка значения x
        sub eax, [a]   ; Вычитание a из x (eax = x - a)

    ; ---- Вывод результата ----
    print_result:
        mov edi, eax     ; Результат в edi
        mov eax, msg_res  ; Вывод сообщения "Результат: "
        call sprint
        mov eax, edi    ; Вывод значения результата
        call iprint
        call quit         ; Завершение программы
