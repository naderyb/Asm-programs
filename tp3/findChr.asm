data segment
    chaine db 'Bonjour, je suis Nader', 13, '$'
    msgDemande db 'Entrez un caractere a rechercher: $'
    msgTrouve db 'Le caractere est present dans la chaine.$'
    msgNonTrouve db 'Le caractere est introuvable dans la chaine.$'
data ends

code segment
    assume cs:code, ds:data, es:data

start:
    ;Initialiser les segments
    mov AX, data
    mov DS, AX
    mov ES, AX

    ;Afficher le message de demande
    lea DX, msgDemande
    mov AH, 09h
    int 21h

    ;Lire le caractere de l'utilisateur
    mov AH, 01h
    int 21h
    mov BL, AL  ;Sauvegarder le caractere saisi dans BL

    ;Verifier la presence du caractere dans la chaine
    lea DI, chaine
    CLD
    mov AL, BL
    mov CX, 255 ;Limite arbitraire pour eviter un depassement

RECHERCHE:
    LODSB         ;Charger un octet de la chaine dans AL
    cmp AL, '$'   ;Verifier si fin de chaine
    je NON_TROUVE ;Si oui, aller a NON_TROUVE
    cmp AL, BL    ;Comparer avec le caractere recherche
    je TROUVE     ;Si egal, aller a TROUVE
    LOOP RECHERCHE

NON_TROUVE:
    ;Afficher le message "Introuvable"
    lea DX, msgNonTrouve
    mov AH, 09h
    int 21h
    jmp FIN

TROUVE:
    ;Afficher le message "Trouve"
    lea DX, msgTrouve
    mov AH, 09h
    int 21h

FIN:
    ;Arrêter le programme
    mov AH, 4Ch
    int 21h

code ends
    end start
