fin = '$'
data segment
    valeur db 72h
    nombre_1 db ?
    message db 'le nombre de bit a 1 est ',fin
data ends

code segment
    assume cs: code, ds:data
    
debut:
    mov ax, data
    mov ds, ax
    mov al, valeur
    xor ah, ah
    mov cx, 8
bit_suivant:
    rcr al, 1
    jnc bit_0
    inc ah
bit_0:
    loop bit_suivant
    mov nombre_1, ah
    lea dx, message
    mov ah, 09h
    int 21h
    mov dl, 30h
    mov ah, 02h
    int 21h
    mov ah, 4ch
    int 21h
code ends
    end debut
