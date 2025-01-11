data segment   
    a dw 4567h
    b dw 8345h
    c dw ?
data ends

code segment 
    assume ds: data, cs: code

    begin: 
    mov ax, data
    mov ds, ax

    mov ax, a
    mov bx, b

    add ax, bx ;aditionner les deux valeur

    shr ax, 1 ;diviser par deux
    
    mov c, ax

    mov ah, 4ch
    int 21h
code ends
    end begin
