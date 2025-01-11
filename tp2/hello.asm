;afficher un message de bienvenue

data segment
    message db "j'aime pas assembleur:(","$", 13, 10 ;message principal                                                Marque de fin de chaine
data ends

code segment
    assume ds:data, cs:code 
begin:
    mov ax, data 
    mov ds, ax

    lea dx, message ;charger l'adresse du message dans DX
    mov ah, 09h ;afficher une chaine
    int 21h

    mov ah, 4Ch  
    int 21h                      
code ends
end begin
