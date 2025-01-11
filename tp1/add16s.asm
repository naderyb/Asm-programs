;programme 2: faire l'addition en 16bits

data segment
    a dw 0B234h ;commence par 0 parceque la val de a commence avec une lettre
    b dw 5678h
    c dw ?
data ends
code segment
    assume ds: data, cs: code
    begin: 
        mov ax, data
        mov ds, ax
        mov ax, a ;charger a dans ax
        add ax, b ;ajouter la valeur de b a la valeur de a charge dans ax
        mov c, ax ;charger la valeur final dans c
        mov ah, 4ch
        int 21h
code ends
    end begin