;programme qui definit si un nombre est un palindrome
data segment
    a db 5Ah ;exemple du tp 5Ah = 01011010
    tab db 81h, 42h, 24h, 18h ;table pour isloer les bits
    msg_palindrome db 'le nombre est un Palindrome$' 
    msg_notPalindrome db 'le nombre nest pas un Palindrome$'
data ends

code segment
    assume ds: data, cs:code
    begin:
    mov ax, data
    mov ds, ax

    lea si, tab ;si pointe vers tab
    mov cx, 4h ;init le cpt a 4 (4 masques)

suiv:
    mov al, a ;charger la valeur dans al
    and al, [si] ;comparer avec l'element du tab des masques
    jpe pair ;si le resultat est pair les bits sont identiques
    lea dx, msg_notpalindrome ;afficher le message pas palindrome
    mov ah, 09h 
    int 21h
    jmp exit ;termier le programme

pair:
    inc si ;passer a l'element suivant
    dec cx ;dec le cpt
    jnz suiv ;continuer tant que cx != 0
    lea dx, msg_palindrome ;afficher le message palindrome
    mov ah, 09h
    int 21h
    jmp exit ;terminer le programme

exit:
    mov ah, 4ch
    int 21h
code ends
    end begin