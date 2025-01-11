;calculer C = |A + B|, avec A = 4567h, B = 8345h

data segment
    A dw 4567h ;A = 4567h (valeur signee)
    B dw 8345h B = 8345h (valeur signee)
    C dw 0C, resultat du calcul |A + B|
data ends

code segment
    assume ds:data, cs:code    
start:
    mov ax, data
    mov ds, ax

    mov ax, [A] ;charger A dans AX
    add ax, [B] ;ajouter B a AX

    ;verifier si la somme est negative si AX < 0, il faut inverser le signe
    js negative ;si AX < 0 (bit de signe est 1), sauter a "negative"

    ;si le resultat est positif ou nul, le garder tel quel
    mov [C], ax ;stocker le resultat dans C
    jmp end ;sauter a la fin

negative:
    ;si le resultat est negatif, le rendre positif (calculer l'absolu)
    neg ax ;inverser le signe de AX
    mov [C], ax ;stocker le resultat dans C

end:
    mov ah, 4Ch              
    int 21h                    
code ends
end start
