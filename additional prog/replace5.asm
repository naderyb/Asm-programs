INCLUDE Lib.inc					; Inclure le fichier où sont declarées les constantes et les macros

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
; Paramètres d'entrée : Transmission par pile
; 		Pamarètre 1 : Code ASCII du caractère à remplacer et Code ASCII du caractère de remplacement
; 		Pamarètre 2 : Adresse effective du texte source
; 		Pamarètre 3 : Adresse effective du texte destination
; 		Pamarètre 4 : Taille du texte source
; Paramètres de sortie : Néant
Remplacer PROC NEAR
	PUSH BP						; Sauvegarder le contenu de BP
	MOV BP, SP					; BP pointe le sommet de la pile
	MOV AL,[BP+10]				; Récuparation de la pile du code ASCII du caractère à remplacer 
	MOV AH,[BP+11]				; Récuparation de la pile du code ASCII du caractère de remplacement
	MOV SI,[BP+8]				; Récuparation de la pile de l'adresse effective du texte source 
	MOV DI,[BP+6]				; Récuparation de la pile de l'adresse effective du texte destination
	MOV CX,[BP+4]				; Récuparation de la pile de la taille du texte source
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
	POP BP						; Restaurer le contenu de BP
	RET							; Retour au programme principal
Remplacer ENDP

; ------------------------------------- Les Procédures ------------------------------------------------------------------
; ------------ Procédure Afficher ---------------------------
; Paramètres d'entrée : Néant
; Paramètres de sortie : Néant
Afficher PROC NEAR
	Affichage TexteSource		; Affichage du TexteSource avant le remplacement
	Affichage TexteDestination	; Affichage du TexteSource après le remplacement
	RET							; Retour au programme principal
Afficher ENDP

Debut:
	MOV AX, Data 				; AX reçoit l’adresse du segment Data
	MOV DS, AX
	MOV ES, AX					; Initialiser ES car il est utilisé par STOS
	MOV AL, PointVirgule		; AL reçoit le code ASCII du caractère en remplacement
	MOV AH, Virgule				; AH reçoit le code ASCII du caractère à remplacer
	PUSH AX						; Placer le 1ier paramètre dans la pile
	LEA AX, TexteSource			; AX reçoit l'adresse effective de TexteSource
	PUSH AX						; Placer le 2ème paramètre dans la pile
	LEA AX, TexteDestination	; AX reçoit l'adresse effective de TexteDestination
	PUSH AX						; Placer le 3ème paramètre dans la pile
	MOV AX, Taille				; AX reçoit la taille de TexteSource
	PUSH AX						; Placer le 4ème paramètre dans la pile
	
	CALL Remplacer				; Appel de la procédure qui remplace , par ;
	CALL Afficher				; Appel de la procédure qui affiche TexteSorce et TexteDestination

	ArreterProgramme 			; Mettre fin au programme
Code ENDS
END Debut						; Fin du programme avec indication où commence son execution
