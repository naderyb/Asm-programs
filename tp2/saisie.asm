;demander la saisie d'un message depuis le clavier et l'afficher a l'ecran.

data segment
    buffer db 255 ;taille maximale de la saisie
    taille db 0 ;nombre de caracteres effectivement lus
    message db 255 dup('$') ;stocker le message saisi
data ends

code segment
    assume ds:data, cs:code   
begin:
    mov ax, data                 
    mov ds, ax                  

    lea dx, buffer ;charger l'adresse du buffer dans DX
    mov ah, 0Ah ;saisie d'une chaine
    int 21h                    

    lea si, buffer+2 ;si pointe sur le debut des caracteres saisis (apres les 2 premiers octets)
    lea di, message ;di pointe sur la zone de stockage finale (message)
    mov cl, taille ;charger le nombre de caracteres lus dans CL
    mov cl, [buffer+1] ;cl contient le nombre de caracteres saisis (sans CR)
copy_loop:
    mov al, [si] ;charger le caractere courant
    mov [di], al ;copier le caractere dans 'message'
    inc si ;avancer dans 'buffer'
    inc di ;avancer dans 'message'
    loop copy_loop ;repeter jusqu'a ce que CL caracteres soient copies

    mov byte ptr [di], '$' ;ajouter le terminateur '$' a la fin de 'message'

    lea dx, message ;charger l'adresse du message dans DX
    mov ah, 09h ;afficher une chaine
    int 21h                     

    mov ah, 4Ch                  
    int 21h                     
code ends
    end begin
