; lab04.asm
SECTION .data ; Начало секции данных
	lab04: DB 'Kirill Cheluhaev',10 
	lab04Len: EQU $-lab04 ; Длина строки lab04
SECTION .text ; Начало секции кода
	GLOBAL _start
_start: ; Точка входа в программу
	mov eax,4 ; Системный вызов для записи (sys_write)
	mov ebx,1 ; Описатель файла '1' - стандартный вывод
	mov ecx,lab04; Адрес строки lab04 в ecx
	mov edx,lab04Len ; Размер строки lab04
	int 80h ; Вызов ядра
	mov eax,1 ; Системный вызов для выхода (sys_exit)
	mov ebx,0 ; Выход с кодом возврата '0' (без ошибок)
	int 80h ; Вызов ядра
