data segment
    t db 61h, 84h ;tableau avec deux nombres signes
    msg_pai1 db 'Nombre 1 est pair$', 0Dh, 0Ah
    msg_imp1 db 'Nombre 1 est impair$', 0Dh, 0Ah
    msg_pai2 db 'Nombre 2 est pair$', 0Dh, 0Ah
    msg_imp2 db 'Nombre 2 est impair$', 0Dh, 0Ah
data ends

code segment
    assume ds: data, cs: code

begin:
    mov ax, data    
    mov ds, ax

    lea si, t ;si pointe sur le tableau
    
    mov al, [si] ;charger le premier nombre dans AL
    test al, 01h ;verifier le bit de poids faible (Lsb)
    jnz impair1 ;si Lsb = 1, le nombre est impair
    lea dx, msg_pai1 ;sinon il est pair
    jmp affiche1

impair1:
    lea dx, msg_imp1 ;le nombre est impair

affiche1:
    mov ah, 09h    
    int 21h

    inc si
    mov al, [si] ;charger le deuxieme nombre dans AL
    test al, 01h ;verifier le bit de poids faible (Lsb)
    jnz impair2 ;si Lsb = 1 le nombre est impair
    lea dx, msg_pai2 ;sinon il est pair
    jmp affiche2

impair2:
    lea dx, msg_imp2 ;le nombre est impair

affiche2:
    mov ah, 09h     
    int 21h

    mov ah, 4Ch 
    int 21h
code ends
end begin
