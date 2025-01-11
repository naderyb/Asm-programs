;convertir un message saisi en minuscule vers majuscule.

data segment
    buffer db 255 ;taille maximale du message saisi (255 caracteres, CR inclus)
    taille db 0 ;nombre de caracteres lus (sans CR)
    message db 255 dup('$') ;stocker le message converti
data ends

code segment
    assume ds:data, cs:code    
begin:
    mov ax, data                 
    mov ds, ax                   

    lea dx, buffer ;charger l'adresse du buffer dans DX
    mov ah, 0Ah ;saisie d'une chaine
    int 21h                      

    mov cl, [buffer+1] ;CL contient le nombre de caracteres saisis (sans CR)
    lea si, buffer+2 ;Si pointe sur les caracteres saisis (apres les 2 premiers octets)
    lea di, message ;Di pointe sur la zone de stockage finale (message)

convert_loop:
    mov al, [si] ;charger le caractere courant dans AL
    cmp al, 'A' ;verifier si AL >= 'A'
    jb not_uppercase ;si AL < 'A', ce n'est pas une majuscule
    cmp al, 'Z' ;verifier si AL <= 'Z'
    ja not_uppercase ;si AL > 'Z', ce n'est pas une majuscule
    or al, 00100000b ;mettre le 6e bit a 0 pour convertir en minuscule
not_uppercase:
    mov [di], al  ;stocker le caractere converti dans `message`
    inc si ;avancer dans le buffer source
    inc di ;avancer dans le buffer destination
    loop convert_loop ;decrementer CX et sauter a `convert_loop` si CX > 0

    mov byte ptr [di], '$';terminer la chaine convertie par '$'

    lea dx, message ;charger l'adresse du message dans DX
    mov ah, 09h ;afficher une chaine
    int 21h           

    mov ah, 4Ch                  
    int 21h                      
code ends
    end begin
