data segment
    t db 61h, 84h ;tableau avec deux nombres signes
    msg_pos1 db 'Nombre 1 positif$', 0Dh, 0Ah
    msg_neg1 db 'Nombre 1 negatif$', 0Dh, 0Ah
    msg_pos2 db 'Nombre 2 positif$', 0Dh, 0Ah
    msg_neg2 db 'Nombre 2 negatif$', 0Dh, 0Ah
data ends

code segment
    assume ds: data, cs: code

begin:
    mov ax, data    
    mov ds, ax

    lea si, t ;si pointe sur le tableau
    
    mov al, [si] ;charger le premier nombre dans AL
    test al, 80h ;verifier le BPf (bit 7)
    jnz negatif1 ;si BPf = 1 le nombre est negatif
    lea dx, msg_pos1 ;sinon il est positif
    jmp affiche1

negatif1:
    lea dx, msg_neg1 ;charger le message "Nombre 1 negatif"

affiche1:
    mov ah, 09h    
    int 21h

    inc si ;passer au deuxieme nombre dans le tableau
    mov al, [si] ;charger le deuxieme nombre dans AL
    test al, 80h ;verifier le BPf (bit 7)
    jnz negatif2 ;si BPf = 1, le nombre est negatif
    lea dx, msg_pos2 ;sinon il est positif
    jmp affiche2

negatif2:
    lea dx, msg_neg2 ;charger le message "Nombre 2 negatif"

affiche2:
    mov ah, 09h     
    int 21h
    
    mov ah, 4Ch  
    int 21h

code ends
end begin
