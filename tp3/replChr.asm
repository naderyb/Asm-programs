data segment
    chaine db 'Bonjour, je suis Nader!', 13, '$'      ;Chaine de caracteres a modifier
    msgOriginal db 'Message original: $', 0            ;Message "Message original: "
    msgApresRempl db 'Message apres remplacement: $', 0 ;Message "Message apres remplacement: "
    msgDemandeCarac db 'Entrez le caractere a remplacer: $', 0 ;Message pour demander le caractere a remplacer
    msgRemplacerPar db 'Entrez le caractere de remplacement: $', 0 ;Message pour demander le caractere de remplacement
data ends

code segment
    assume cs:code, ds:data, es:data

begin:
    ;etape 1: Initialiser le segment de donnees ES
    mov AX, data
    mov DS, AX
    mov ES, AX

    ;Afficher le message "Message original:"
    lea DX, msgOriginal
    mov AH, 09h
    int 21h

    ;Afficher la chaine de caracteres originale
    lea DX, chaine
    mov AH, 09h
    int 21h

    ;Afficher le message demandant a l'utilisateur de saisir le caractere a remplacer
    lea DX, msgDemandeCarac
    mov AH, 09h
    int 21h

    ;Saisir le caractere a remplacer
    mov AH, 01h
    int 21h
    mov AL, DL            ;Sauvegarder le caractere saisi dans AL (caractere a remplacer)

    ;Afficher le message pour le caractere de remplacement
    lea DX, msgRemplacerPar
    mov AH, 09h
    int 21h

    ;Saisir le caractere de remplacement
    mov AH, 01h
    int 21h
    mov BL, DL            ;Sauvegarder le caractere de remplacement dans BL

    ;etape 3: Charger l'adresse de la chaine dans DI
    lea DI, chaine

    ;etape 4: Rechercher et remplacer le caractere specifie dans la chaine
REPLACE_LOOP:
    mov AL, [DI]          ;Charger le caractere actuel de la chaine dans AL
    cmp AL, 13             ;Comparer avec le caractere de fin de chaine (ASCII 13)
    je END_REPLACE        ;Si fin de chaine, sortir de la boucle

    cmp AL, [SI]           ;Comparer avec le caractere a remplacer
    jne NEXT_CHAR          ;Si ce n'est pas le caractere a remplacer, passer au suivant

    ;Remplacer le caractere
    mov [DI], BL           ;Remplacer le caractere trouve par le caractere de remplacement
NEXT_CHAR:
    inc DI                 ;Passer au caractere suivant
    jmp REPLACE_LOOP       ;Refaire la boucle

END_REPLACE:
    ;Afficher le message "Message apres remplacement:"
    lea DX, msgApresRempl
    mov AH, 09h
    int 21h

    ;Afficher la chaine modifiee
    lea DX, chaine
    mov AH, 09h
    int 21h

    ;etape 7: Arrêter le programme
    mov AH, 4Ch
    int 21h

code ends
    end begin
