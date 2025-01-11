include lib.inc

data segment
    text db "Bonjour, contacte moi,"
    longueur equ $-text
data ends

code segment
    assume cs: code, ds: data

begin:
    mov ax, data
    mov ds, ax
    mov es,ax

    lea di, text
    mov cx, longueur ;taille max

change:
    mov al, ',' ;caractere a rechercher

replace_loop:
    repne scasb ;comparer AL avec le caractere pointe par Di
    JCXZ fin1
    jne check_end ;si ce n'est pas une virgule, verifier la fin
    mov byte ptr [di-1], '.' ;remplacer la virgule par un point
check_end:
    cmp byte ptr [di-1], '$' ;verifier si on atteint la fin de la chaine
    jne replace_loop ;continuer si ce n'est pas la fin

fin1:
    Afficher text

    mov ah, 4Ch  
    int 21h

code ends
end begin
