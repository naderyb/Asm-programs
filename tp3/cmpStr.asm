data segment
    chaine1 db 'je suis nader', 13, '$'         ;Premiere chaine de caracteres, terminee par 13 (CR)
    chaine2 db 'je suis', 13, '$'         ;Deuxieme chaine de caracteres, terminee par 13 (CR)
    msgIdentique db 'Les deux chaines sont identiques.$'
    msgDifferentes db 'Les deux chaines sont differentes.$'
data ends

code segment
    assume cs:code, ds:data, es:data

begin:
    ;etape 1: initialiser le segment de donnees DS et le segment supplementaire ES
    mov AX, data
    mov DS, AX
    mov ES, AX

    ;etape 2: charger l'adresse de la chaine source dans SI et celle de la destination dans DI
    lea SI, chaine1
    lea DI, chaine2

    ;etape 3: charger la taille de la chaine source dans CX (jusqu'au retour chariot 13)
    mov CX, 0 ;initialiser CX
COUNT_LOOP:
    LODsb ;charger le caractere de la chaine source dans AL
    cmp AL, 13 ;comparer avec le caractere de fin de chaine (ASCII 13)
    je SET_COUNT ;si egal, la chaine est terminee
    inc CX ;incrementer le compteur
    jmp COUNT_LOOP

SET_COUNT:
    ;CX contient maintenant la taille de la chaine source

    ;etape 4: effacer le drapeau de direction DF
    CLD ;clear Direction Flag pour l'increment automatique de SI et DI

    ;etape 5: comparer caractere par caractere avec cmpS
    lea SI, chaine1 ;recharger l'adresse de la chaine source dans SI
    lea DI, chaine2 ;recharger l'adresse de la chaine destination dans DI
    mov AX, CX ;charger la longueur de la chaine source dans AX
    mov BX, CX ;Sauvegarder la longueur de la chaine source dans BX
    repz cmpsb ;Comparer les caracteres des deux chaines jusqu'a ZF = 0 ou CX = 0

    jne DIFFERENT ;Si une difference est detectee, aller a DIFFERENT

    ;Verifier si les deux chaines ont la même longueur
    mov CX, BX ;Restaurer la longueur de la chaine source
    cmp CX, 0 ;Si CX est egal a zero, les chaines sont identiques
    jne DIFFERENT

IDENTICAL:
    ;etape 7: Afficher "Les deux chaines sont identiques"
    lea DX, msgIdentique
    mov AH, 09h
    int 21h
    jmp FIN

DIFFERENT:
    ;etape 7: Afficher "Les deux chaines sont differentes"
    lea DX, msgDifferentes
    mov AH, 09h
    int 21h

FIN:
    ;etape 8: Arrêter le programme
    mov AH, 4Ch
    int 21h

code ends
    end begin
