; --------------------------------------- Les Constantes ------------------------------------------------------------------
Fin EQU '$'						; Fin = Code ASCII du caract�re $	
CR EQU 13						; Fin = Code ASCII du caract�re qui repr�sente un Retour chariot
LF EQU 10						; Fin = Code ASCII du caract�re qui repr�sente un saut de ligne
Virgule EQU ','					; Virgule = Code ASCII du caract�re ,
PointVirgule EQU ';'			; PointVirgule = Code ASCII du caract�re ;

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

; ------------------------------------- Les Proc�dures ------------------------------------------------------------------
; ------------ Proc�dure Remplacer ---------------------------
; Param�tres d'entr�e :
; 		AL <- Code ASCII du caract�re � remplacer
; 		AH <- Code ASCII du caract�re de remplacement
; 		SI <- Adresse effective du texte source
; 		DI <- Adresse effective du texte destination
; 		CX <- Taille du texte source
; Param�tres de sortie : N�ant
Remplacer PROC NEAR
	CLD							; Incr�mentation automatique des registres index SI et DI
Rechercher:
	CMP BYTE PTR [SI], AH 	; Est-ce-que le caract�re est une virgule
	JNE Pas_Virgule				; Si c'est NON Alors Aller � Pas_Virgule
	STOSB 						; Si c'est OUI Alors Remplacer la virgule par la point virgule
	INC SI						; L'Index SI n'est pas incr�ment� automatiquement. Nous devons le faire nous m�me
	JMP Changement_Fait
Pas_Virgule:
	MOVSB						; Copier la valeur telle qu'elle est
Changement_Fait:					
	LOOP Rechercher
	RET							; Retour au programme principal
Remplacer ENDP

; ------------------------------------- Les Proc�dures ------------------------------------------------------------------
; ------------ Proc�dure Afficher ---------------------------
; Param�tres d'entr�e : N�ant
; Param�tres de sortie : N�ant
Afficher PROC NEAR
	MOV AH, 09h
	LEA DX, TexteSource
	INT 21h						; Affichage du TexteSource avant le remplacement
	LEA DX, TexteDestination	
	INT 21h						; Affichage du TexteSource apr�s le remplacement
	RET							; Retour au programme principal
Afficher ENDP

Debut:
	MOV AX, Data 				; AX re�oit l�adresse du segment Data
	MOV DS, AX
	MOV ES, AX					; Initialiser ES car il est utilis� par STOS
	LEA SI, TexteSource			; SI re�oit l'adresse effective de TexteSource
	LEA DI, TexteDestination	; DI re�oit l'adresse effective de TexteDestination
	MOV AL, PointVirgule
	MOV AH, Virgule
	MOV CX, Taille				; CX re�oit la taille de TexteSource
	
	CALL Remplacer				; Appel de la proc�dure qui remplace , par ;
	CALL Afficher				; Appel de la proc�dure qui affiche TexteSorce et TexteDestination

	MOV AH, 4Ch 				; Mettre fin au programme
	INT 21H	
Code ENDS
END Debut						; Fin du programme avec indication o� commence son execution