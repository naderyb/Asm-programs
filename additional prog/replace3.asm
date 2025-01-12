; --------------------------------------- Les Constantes ------------------------------------------------------------------
Fin EQU '$'						; Fin = Code ASCII du caractère $	
CR EQU 13						; Fin = Code ASCII du caractère qui représente un Retour chariot
LF EQU 10						; Fin = Code ASCII du caractère qui représente un saut de ligne
Virgule EQU ','					; Virgule = Code ASCII du caractère ,
PointVirgule EQU ';'			; PointVirgule = Code ASCII du caractère ;

; --------------------------------------- La pile --------------------------------------------------------------------
Pile SEGMENT STACK
	DW 100 DUP(?)
Pile ENDS
; --------------------------------------- Les variables --------------------------------------------------------------------
Data SEGMENT
	TexteSource DB 'Le matin, vers 8 heures, lorsque le temps le permet, je pars en promenade.',CR,LF,FIN
	Taille EQU $-TexteSource	; Taille TexteSource = Cette adresse ($) - Adresse TexteSource
	TexteDestination DB 100 DUP(?)
Data ENDS
; ------------------------------------- Les Instructions ------------------------------------------------------------------
Code SEGMENT
ASSUME CS:Code,DS:Data,ES:Data 	; Faire la correspondance entre les registres segments et les segments

; ------------------------------------- Les Procédures ------------------------------------------------------------------
; ------------ Procédure Remplacer ---------------------------
; Paramètres d'entrée :
; 		AL <- Code ASCII du caractère à remplacer
; 		AH <- Code ASCII du caractère de remplacement
; 		SI <- Adresse effective du texte source
; 		DI <- Adresse effective du texte destination
; 		CX <- Taille du texte source
; Paramètres de sortie : Néant
Remplacer PROC NEAR
	CLD							; Incrémentation automatique des registres index SI et DI
Rechercher:
	CMP BYTE PTR [SI], AH 	; Est-ce-que le caractère est une virgule
	JNE Pas_Virgule				; Si c'est NON Alors Aller à Pas_Virgule
	STOSB 						; Si c'est OUI Alors Remplacer la virgule par la point virgule
	INC SI						; L'Index SI n'est pas incrémenté automatiquement. Nous devons le faire nous même
	JMP Changement_Fait
Pas_Virgule:
	MOVSB						; Copier la valeur telle qu'elle est
Changement_Fait:					
	LOOP Rechercher
	RET							; Retour au programme principal
Remplacer ENDP

; ------------------------------------- Les Procédures ------------------------------------------------------------------
; ------------ Procédure Afficher ---------------------------
; Paramètres d'entrée : Néant
; Paramètres de sortie : Néant
Afficher PROC NEAR
	MOV AH, 09h
	LEA DX, TexteSource
	INT 21h						; Affichage du TexteSource avant le remplacement
	LEA DX, TexteDestination	
	INT 21h						; Affichage du TexteSource après le remplacement
	RET							; Retour au programme principal
Afficher ENDP

Debut:
	MOV AX, Data 				; AX reçoit l’adresse du segment Data
	MOV DS, AX
	MOV ES, AX					; Initialiser ES car il est utilisé par STOS
	LEA SI, TexteSource			; SI reçoit l'adresse effective de TexteSource
	LEA DI, TexteDestination	; DI reçoit l'adresse effective de TexteDestination
	MOV AL, PointVirgule
	MOV AH, Virgule
	MOV CX, Taille				; CX reçoit la taille de TexteSource
	
	CALL Remplacer				; Appel de la procédure qui remplace , par ;
	CALL Afficher				; Appel de la procédure qui affiche TexteSorce et TexteDestination

	MOV AH, 4Ch 				; Mettre fin au programme
	INT 21H	
Code ENDS
END Debut						; Fin du programme avec indication où commence son execution
