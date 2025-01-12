INCLUDE Lib.inc					; Inclure le fichier o� sont declar�es les constantes et les macros

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
; Param�tres d'entr�e : Transmission par pile
; 		Pamar�tre 1 : Code ASCII du caract�re � remplacer et Code ASCII du caract�re de remplacement
; 		Pamar�tre 2 : Adresse effective du texte source
; 		Pamar�tre 3 : Adresse effective du texte destination
; 		Pamar�tre 4 : Taille du texte source
; Param�tres de sortie : N�ant
Remplacer PROC NEAR
	PUSH BP						; Sauvegarder le contenu de BP
	MOV BP, SP					; BP pointe le sommet de la pile
	MOV AL,[BP+10]				; R�cuparation de la pile du code ASCII du caract�re � remplacer 
	MOV AH,[BP+11]				; R�cuparation de la pile du code ASCII du caract�re de remplacement
	MOV SI,[BP+8]				; R�cuparation de la pile de l'adresse effective du texte source 
	MOV DI,[BP+6]				; R�cuparation de la pile de l'adresse effective du texte destination
	MOV CX,[BP+4]				; R�cuparation de la pile de la taille du texte source
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
	POP BP						; Restaurer le contenu de BP
	RET							; Retour au programme principal
Remplacer ENDP

; ------------------------------------- Les Proc�dures ------------------------------------------------------------------
; ------------ Proc�dure Afficher ---------------------------
; Param�tres d'entr�e : N�ant
; Param�tres de sortie : N�ant
Afficher PROC NEAR
	Affichage TexteSource		; Affichage du TexteSource avant le remplacement
	Affichage TexteDestination	; Affichage du TexteSource apr�s le remplacement
	RET							; Retour au programme principal
Afficher ENDP

Debut:
	MOV AX, Data 				; AX re�oit l�adresse du segment Data
	MOV DS, AX
	MOV ES, AX					; Initialiser ES car il est utilis� par STOS
	MOV AL, PointVirgule		; AL re�oit le code ASCII du caract�re en remplacement
	MOV AH, Virgule				; AH re�oit le code ASCII du caract�re � remplacer
	PUSH AX						; Placer le 1ier param�tre dans la pile
	LEA AX, TexteSource			; AX re�oit l'adresse effective de TexteSource
	PUSH AX						; Placer le 2�me param�tre dans la pile
	LEA AX, TexteDestination	; AX re�oit l'adresse effective de TexteDestination
	PUSH AX						; Placer le 3�me param�tre dans la pile
	MOV AX, Taille				; AX re�oit la taille de TexteSource
	PUSH AX						; Placer le 4�me param�tre dans la pile
	
	CALL Remplacer				; Appel de la proc�dure qui remplace , par ;
	CALL Afficher				; Appel de la proc�dure qui affiche TexteSorce et TexteDestination

	ArreterProgramme 			; Mettre fin au programme
Code ENDS
END Debut						; Fin du programme avec indication o� commence son execution
