;----------------- Constantes ------------------------------------------
	Fin = '$'
	CR = 13
	LF = 10

;----------------- Mettre fin à un programme --------------------	
FinProgramme MACRO
	MOV AH, 4CH 
	INT 21H	
	ENDM
	
;----------------- Affichage d'un message à l'écran --------------------
; En Entrée : - Texte : chaine de caractére qui se termine par $
Afficher MACRO Texte
	PUSH AX
	PUSH DX
	MOV AH,09h
	LEA DX,Texte
	INT 21h
	POP DX
	POP AX
	ENDM
	
;----------------- Saisie d'un message à l'écran --------------------
; En Entrée : - Texte : chaine de caractére dont les deux premiers octets sont réservé (Taille max à saisir et Nombre de caractères saisies) 
Saisie MACRO Texte
	PUSH AX
	PUSH DX
	MOV AH,0Ah
	LEA DX,Texte
	INT 21h
	POP DX
	POP AX
	ENDM
;----------------- Ecrire un caractère à l'écran --------------------
; En Entrée : - Caractere : contient le code ASCII sur 8 bits du caractère à afficher sur l'écran
Ecrire MACRO Caractere
	PUSH AX
	PUSH DX
	MOV AH,02h
	MOV DL,Caractere
	INT 21h
	POP DX
	POP AX
	ENDM
	
;----------------- Affichage d'un message à l'écran --------------------
SautLigne MACRO 
	PUSH AX
	PUSH DX
	MOV AH,02h
	MOV DL,CR
	INT 21h
	MOV DL,LF
	INT 21h
	POP DX
	POP AX
	ENDM	
;----------------- Lire un caractère à l'écran --------------------
; En Sortie : - Caractere : contient le code ASCII sur 8 bits du caractère saisie
Lire MACRO Caractere
	PUSH AX
	MOV AH,01h	
	INT 21h
	MOV Caractere,AL
	POP AX
	ENDM
;----------------- Affichage d'une valeur binaire sur 16 bits en décimal à l'écran --------------------
; En Entrée : - ValeurBinaire : Nombre binaire sur 16 bits 
; En Sortie : - Sortie : chaine de caractére de 6 octets initialisée avec $
Binaire2ASCII MACRO ValeurBinaire,Sortie 
	LOCAL Chiffre_Suivant,ASCII_Suivant
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	MOV AX,ValeurBinaire 
	MOV CX,0Ah
	XOR BX,BX
Chiffre_Suivant:
	XOR DX,DX
	DIV CX
	PUSH DX
	INC BX
	CMP AX,0
	JNE Chiffre_Suivant
	XOR SI,SI
ASCII_Suivant:
	POP DX
	AND DL,0Fh
	ADD DL,30h
	MOV Sortie[SI],DL
	INC SI
	DEC BX
	JNZ ASCII_Suivant
	MOV Sortie[SI],FIN
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	ENDM

;----------------- Affichage d'une valeur binaire sur 16 bits en décimal à l'écran --------------------
; En Entrée : - Entree : chaine de caractére saisie de 8 octets dont les deux premiers conitiennent le max à lire et le nombre de caractères lu	
; En Sortie : - ValeurBinaire : Nombre binaire sur 16 bits 
;			  - Erreur : 0 resultat correct 1 : Sinon
ASCII2Binaire MACRO Entree,ValeurBinaire,Erreur
	LOCAL ASCII_Suivant, Aucune_Entree, Fin_Convert, Depassement_Capacite, Terminer
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI
	CMP Entree[1],0
	JE Aucune_Entree
	XOR DX,DX
	XOR CX,CX
	XOR DI,DI
	MOV BX,0Ah
ASCII_Suivant :
	MOV AL,Entree[DI+2]
	SUB AL,30h
	JS Non_Numerique
	CMP AL,9
	JA Non_Numerique
	CBW
	ADD AX,CX
	JC Depassement_Capacite
	CMP Entree[DI+3],CR
	JE Fin_Convert
	MUL BX
	CMP DX,0
	JNE Depassement_Capacite
	MOV CX,AX
	INC DI
	JMP ASCII_Suivant
Fin_Convert :
	MOV Erreur,0
	JMP Terminer
Aucune_Entree:
	MOV Erreur,1
	JMP Terminer
Depassement_Capacite :
	MOV Erreur,2
	JMP Terminer
Non_Numerique :
	MOV Erreur,3
Terminer :
	MOV ValeurBinaire,AX
	POP DI
	POP DX
	POP CX
	POP BX
	POP AX
	ENDM