pile segment stack
    dw 100 dup(?)
pile ends
data segment
    nombre dw 04h
    result db ? ;resultat calcule
data ends
code segment
    assume cs:code, ds:data

;procedure pour calculer la factorielle
factorial proc
    push bp ;sauvegarder le registre BP
    mov bp, sp ;initialiser BP au sommet de la pile
    mov cx, [bp+4] ;charger le parametre (nombre) dans CX
    mov ax, 1 ;initialiser AX a 1 pour le resultat
factorial_loop:
    mul cx ;multiplier AX par CX
    loop factorial_loop ;repeter tant que CX > 0
    pop bp  ;restaurer BP
    ret
factorial endp

;fonction recursive pour la factorielle
factr proc
    pus bp
    mov bp, sp
    mov ax, [bp + 4]
    cmp ax, 1
    je arret
    dec ax
    push ax
    call fact
    pop ax
    mul [pb + 4]
    arret:
        mov [bp + 4], ax
        pop bp
        ret
factr endp
begin:
    mov ax, data    
    mov ds, ax
    ;preparer le parametre (le nombre pour la factorielle)          
    push nombre ;rmpiler le nombre en parametre
    
    call factorial ;appeler la procedure pour calculer la factorielle
    
    ;le resultat est dans AX apres le retour de la procedure
    mov result, al ;stocker le resultat dans la variable

    mov ah, 4ch
    int 21h
code ends
end begin