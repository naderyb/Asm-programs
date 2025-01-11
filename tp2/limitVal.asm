data segment
    t db 12h, 84h, 41h, 0f2h, 05h, 61h, 0efh, 94h, 43h, 02h
    min db 7fh ;stocker la plus petite valeur
    max db 80h ;stocker la plus grande valeur
data ends

code segment
    assume ds: data, cs: code

    begin: 
    mov ax, data
    mov ds, ax

    lea si, t ;si va pointer su le tableau
    mov cx, 0Ah ;init le cpt a 10 soit le nombre d'element du tableau

comparer_loop:
    mov al, [si]
    cmp al, max
    jle verif_min ;si al <= max verifier min
    mov max, al ;sinon al devient le nouveau max

verif_min:
    cmp al, min 
    jge suiv ;si al >= min passer a l'element suivant
    mov min, al ;sinon al devient le nouveau min

suiv:
    inc si
    loop comparer_loop ;continuer jusqu'a cx = 0

    mov dh, max ;charger max dans dh

    mov dl, min ;charger min dans dl

    mov ah, 4ch
    int 21h
code ends
    end begin