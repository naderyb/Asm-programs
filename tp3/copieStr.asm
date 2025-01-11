data segment
    blocsource db 100 dUP (?) ;taille maximale de la chaine
                db '$' ;ajout du caractere de fin pour l'affichage
data ends
Extra segment
    blocdestination db 100 dUP(?) ;zone pour la chaine destination
                db '$' ;ajout du caractere de fin pour l'affichage
Extra ends

code segment
assume cs:code, ds:data, es:Extra

debut:
    ;etape 1: initialiser les segments
    mov ax, data
    mov ds, ax
    mov ax, extra
    mov es, ax

    ;etape 2: lire une chaine de caracteres
    lea dX, blocsource
    mov AH, 0Ah
    int 21h

    ;etape 3: charger les adresses source et destination
    lea Si, blocsource + 2  ;sauter les 2 premiers octets
    lea di, blocdestination

    ;etape 4: charger la taille de la chaine
    mov cL, blocsource[1]   ;longueur de la chaine saisie
    mov cH, 0

    ;etape 5: effacer le drapeau de direction
    cLd

    ;etape 6: copier les donnees
    REP movsb

    ;ajouter un caractere `$` a la fin de la destination
    mov bYTE PTR [di], '$'

    ;etape 7: Afficher les chaines source et destination
    ;Afficher "bloc Source: "
    mov AH, 09h
    lea dX, blocsource + 2  ;la chaine commence apres les 2 premiers octets
    int 21h

    ;afficher un retour a la ligne
    mov AH, 02h
    mov dL, 0dh
    int 21h
    mov dL, 0Ah
    int 21h

    ;afficher "bloc destination: "
    mov AH, 09h
    lea dX, blocdestination
    int 21h

    ;etape 8: arrêter le programme
    mov AH, 4ch
    int 21h

code ends
end debut
