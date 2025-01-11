;programme 12: faire la division en 8bits (bits signes)

data segment 
    a db 94h
    b db 1Bh
    c db ?
    d db ?
data ends
code segment
    assume ds: data, cs: code
    begin:
    mov ax, data
    mov ds, ax
    mov al, a ;charger la valeur de a dans AL (registre en 8bits)
    mov ah, 0h ;charger la valeur 0h dans ah pour eviter les resultats incorrects
    mov bl, b ;charger la valeur de b dans BL (registre en 8bits)
    idiv bl ;diviser la la valeur qui est dans al par bl
    mov c, al ;charger le quotient dans c
    mov d, ah ;charger le reste de la division dans d
    mov ah, 4ch
    int 21h
code ends
    end begin