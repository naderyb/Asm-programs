;afficher les characters ayant les code ASCii de 0 a 225

code segment
    assume  cs: code

    begin:
    mov cx, 255
    mov dl, 0

    afficher:
    mov ah, 02h
    int 21h
    inc dl
    jnz afficher

    mov ah, 4ch
    int 21h
code ends
    end begin