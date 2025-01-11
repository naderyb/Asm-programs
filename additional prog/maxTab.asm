;programme qui trouve la plus grande valeur dans un tableau

data segment
    T db 72h, 87h, 0C1h, 32h, 05h, 61h, 0EFh, 94h, 43h, 12h
    val db ?
data ends
code segment
    assume ds: data, cs: code
    begin:
    mov ax, data
    mov ds, ax
    mov al, T[0]
    mov si, 0
    suivant:
    inc si
    cmp al, T[si]
    jg superieur
    mov al, T[si]
    superieur:
 cmp si, 9
 jb suivant
 mov val, al
    mov ah, 4ch
    int 21h
code ends
    end begin