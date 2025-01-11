;programme 9: faire la multiplication en 16bits (bits non-signes)

data segment 
    a dw 0A847h
    b dw 1234h
    c dw ?
    d dw ?
data ends
code segment
    assume ds: data, cs: code
    begin:
    mov ax, data
    mov ds, ax
    mov ax, a ;charger de a dans ax
    mov bx, b ;charger la valeur de b dans bx
    mul bx ;multiplier la valeur qui est dans bx par la valeur de a qui dans l'accumulateur
    mov c, ax ;charger la partie basse du resultat dans c
    mov d, bx ;charger la partie haute du resultat dans d
    mov ah, 4ch
    int 21h
code ends
    end begin