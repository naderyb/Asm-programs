;programme 4: faire l'addition en 32bits

data segment
    a_high dw 8765h ;partie haute de a
    a_low dw 4321h ;partie basse de a
    b_high dw 1234h ;partie ahute de b
    b_low dw 5678h ;partie basse de b
    c dw ? ;contient la partie basse du resultat
    d dw ? ;contient la valeur haute du resultat
data ends
code segment
    assume ds: data, cs: code
    begin: 
        mov ax, data
        mov ds, ax
        mov ax, a_low ;charger la valeur basse de a dans ax (registre en 16bits)
        add ax, b_low ;ajouter la valeur de b a la valeur charger dans ax soit de a
        mov c, axcharger la valeur de ax danx c
        mov ax, a_high ;chrager la valeur de la partie haute de a dans ax
        adc ax, b_high ;ajouter la valeur de ax a bx
        mov d, ax ;charger le resultat des parties haute dans d
        mov ax, d ;charger la valeur de c dans ax
        mov dx, c ;charger la valeur de d dans dx
        mov ah, 4ch
        int 21h
code ends
    end begin
