%include 'in_out.asm'

SECTION .data
    msg_ask: db "Как Вас зовут?", 0
    msg_hello: db "Меня зовут ", 0
    filename: db "name.txt", 0 ; Имя файла (может быть изменено в коде)

SECTION .bss
    name_buffer: resb 256 ; Буфер для ввода имени (достаточно большой)

SECTION .text
    global _start

_start:
    ; ---- 1. Вывод приглашения ----
    mov eax, msg_ask
    call sprint

    ; ---- 2. Ввод имени ----
    mov ecx, name_buffer  ; Адрес буфера
    mov edx, 255        ; Максимальная длина (оставляем место для завершающего нуля)
    call sread

    ; ---- 3. Создание файла ----
    mov eax, filename   ; Имя файла
    mov ebx, 0777o      ; Права доступа: rw-r--r-- (octal - файл доступен на чтение и запись владельцу, на чтение - группе и остальным пользователям)
    mov ecx, 8            ; SYS_CREAT ( create or truncate) - создает или перезаписывает файл
    mov eax, 8
    int 80h             ; Вызов системного вызова create
    mov esi, eax        ; Сохраняем файловый дескриптор

    ; ---- 4. Запись сообщения "Меня зовут" ----
    mov eax, msg_hello
    call slen             ; Вычисляем длину сообщения
    mov edx, eax          ; Длина сообщения
    mov eax, msg_hello
    mov ebx, esi          ; Файловый дескриптор
    mov ecx, eax
    mov eax, 4            ; SYS_WRITE
    int 80h              ; Вызов системного вызова write

    ; ---- 5. Дозапись введенного имени ----
    mov eax, name_buffer
    call slen             ; Вычисляем длину введенного имени
    mov edx, eax          ; Длина имени
    mov eax, name_buffer
    mov ebx, esi          ; Файловый дескриптор
    mov ecx, eax          ; Адрес имени
    mov eax, 4            ; SYS_WRITE
    int 80h              ; Вызов системного вызова write

    ; ---- 6. Закрытие файла ----
    mov eax, esi         ; Файловый дескриптор
    mov eax, 6            ; SYS_CLOSE
    int 80h              ; Вызов системного вызова close

    call quit           ; Завершение программы
