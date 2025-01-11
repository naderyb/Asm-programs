data segment
    chaine db 'ana je suis fatigue', 13 ;chaine terminee par le caractere de retour chariot
    msgResult db 'Longueur de la chaine: $'
    longueur db 4 dup('$') ;espace pour stocker la longueur convertie en chaine
    msgCaracteres db ' caracteres.$'
data ends

code segment
    assume cs:code, ds:data

begin:
    ;etape 1: initialiser le segment de donnees
    mov AX, data
    mov DS, AX

    ;etape 2: initialiser le compteur CL a 0
    xor CX, CX

    ;etape 3: charger l'adresse de la chaine dans le registre Si
    lea Si, chaine

LONGUEUR_LOOP:
    ;etape 4: charger dans AL chaque caractere avec LODS
    LODsb ;charger [Si] dans AL et incrementer Si

    ;etape 5: comparer AL avec 13 (ASCii du retour chariot)
    cmp AL, 13
    je FiN_LONGUEUR ;si egal, fin de la chaine

    inc CX ;incrementer le compteur
    jmp LONGUEUR_LOOP ;continuer la boucle

FiN_LONGUEUR:
    ;etape 6: stocker le resultat
    ;convertir la longueur (dans CX) en chaine de caracteres
    mov AX, CX ;charger la longueur dans AX
    call CONVERTiR ;convertir en ASCii (fonction ci-dessous)

    ;etape 7: afficher le message et la longueur
    lea DX, msgResult
    mov AH, 09h
    int 21h

    ;afficher la longueur
    lea DX, longueur
    mov AH, 09h
    int 21h

    ;afficher "caracteres"
    lea DX, msgCaracteres
    mov AH, 09h
    int 21h

    ;etape 8: arreter le programme
    mov AH, 4Ch
    int 21h

;fonction pour convertir un nombre en chaine ASCii
;entree: AX contient le nombre
;sortie: La chaine ASCii est stockee dans [longueur]
CONVERTIR PROC
    xor BX, BX ;effacer BX
    mov BX, 10 ;diviseur pour obtenir les chiffres
    lea Di, longueur ;charger l'adresse de destination
    xor CX, CX ;compteur de chiffres
CONV_LOOP:
    xor DX, DX ;effacer le reste
    div BX ;siviser AX par 10, reste dans DX, quotient dans AX
    add DL, '0' ;convertir le chiffre en ASCii
    push DX ;sauvegarder le chiffre ASCii
    inc CX ;incrementer le compteur de chiffres
    cmp AX, 0 ;verifier si le quotient est nul
    jne CONV_LOOP

POP_CHIFFRES:
    POP AX ;recuperer un chiffre
    mov [Di], AL ;stocker dans la chaine
    inc Di ;avancer le pointeur
    LOOP POP_CHiFFRES ;repeter pour tous les chiffres

    mov BYTE PTR [Di], '$' ;ajouter le terminateur
    RET
CONVERTIR ENDP

code ends
    end begin
