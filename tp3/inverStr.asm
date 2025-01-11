data segment
    inputBuffer db 31            ;Taille maximale de la chaine (30 caracteres + 1 octet pour la longueur)
                db ?             ;Longueur de la chaine entree
                db 30 dup('$')   ;espace pour la chaine entree
    dest db 30 dup('$')          ;Bloc de destination pour la chaine inversee
    msgOriginal db 'Message original: $'
    msginverse db 'Message inverse: $'
data ends

code segment
    assume cs:code, ds:data

begin:
    ;initialisation des segments de donnees
    mov ax, data
    mov ds, ax
    mov es, ax

    ;etape 1: lire une chaine de caracteres a partir du clavier
    lea DX, inputBuffer
    mov AH, 0Ah
    int 21h

    ;charger l'adresse de la chaine dans Si (chaine commence a inputBuffer+2)
    lea Si, inputBuffer + 2

    ;charger l'adresse de destination dans Di
    lea Di, dest

    ;charger la longueur de la chaine dans CX
    mov CL, [inputBuffer + 1] ;charger la longueur de la chaine entree
    mov CH, 0                 ;remplir la partie haute de CX avec 0

    ;ajuster Si pour pointer a la fin de la chaine source
    add Si, CX
    DEC Si  ;pointer sur le dernier caractere de la chaine

    ;copier et inverser la chaine
REVERSE_LOOP:
    cmp CX, 0
    je END_REVERSE
    mov AL, [Si]      ;charger le caractere source
    mov [Di], AL      ;placer le caractere dans la destination
    DEC Si            ;reculer dans la source
    inc Di            ;avancer dans la destination
    DEC CX            ;decrementer le compteur
    jmp REVERSE_LOOP
END_REVERSE:

    ;ajouter un terminateur a la chaine inversee
    mov BYTE PTR [Di], '$'

    ;etape 6: afficher les messages
    ;afficher le message original
    lea DX, msgOriginal
    mov AH, 09h
    int 21h

    ;afficher la chaine source
    lea DX, inputBuffer + 2
    mov AH, 09h
    int 21h

    ;nouvelle ligne
    mov AH, 02h
    mov DL, 0Dh
    int 21h
    mov DL, 0Ah
    int 21h

    ;afficher le message inverse
    lea DX, msginverse
    mov AH, 09h
    int 21h

    ;afficher la chaine inversee
    lea DX, dest
    mov AH, 09h
    int 21h

    ;etape 7: arreter le programme
    mov AH, 4Ch
    int 21h

code ends
    end begin
