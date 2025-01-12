;ce programme remplace ',' par ';' dans les chaines de caracteres.

; --------------------------------------- Les Constantes ------------------------------------------------------------------
Fin EQU '$'						; Fin = Code ASCII du caract�re $	
CR EQU 13						; Fin = Code ASCII du caract�re qui repr�sente un Retour chariot
LF EQU 10						; Fin = Code ASCII du caract�re qui repr�sente un saut de ligne
Virgule EQU ','					; Virgule = Code ASCII du caract�re ,
PointVirgule EQU ';'			; PointVirgule = Code ASCII du caract�re ;

; --------------------------------------- Les variables --------------------------------------------------------------------
Data SEGMENT
	TexteSource DB 'Le matin, vers 8 heures, lorsque le temps le permet, je pars en promenade.',CR,LF,FIN
	Taille EQU $-TexteSource	; Taille TexteSource = Cette adresse ($) - Adresse TexteSource
	TexteDestination DB 100 DUP(?)
Data ENDS

; ------------------------------------- Les Instructions ------------------------------------------------------------------
Code SEGMENT
ASSUME CS:Code,DS:Data 			; Faire la correspondance entre les registres segments et les segments
Debut:
	MOV AX, Data 				; AX re�oit l�adresse du segment Data
	MOV DS, AX
	LEA SI, TexteSource			; SI re�oit l'adresse effective de TexteSource
	LEA DI, TexteDestination	; DI re�oit l'adresse effective de TexteDestination
	MOV AL, PointVirgule
	MOV AH, Virgule
	MOV CX, Taille				; CX re�oit la taille de TexteSource
Rechercher:
	CMP BYTE PTR [SI], AH 	; Est-ce-que le caract�re est une virgule
	JNE Pas_Virgule				; Si c'est NON Alors Aller � Pas_Virgule
	MOV BYTE PTR [DI], AL ; Si c'est OUI Alors Remplacer la virgule par la point virgule
	JMP Changement_Fait
Pas_Virgule:
	MOV DL,[SI]					; Copier la valeur telle qu'elle est
	MOV [DI],DL
Changement_Fait:
	INC SI						; Pointer avec SI le prochain caract�re de TexteSource
	INC DI						; Pointer avec DI le prochain caract�re de TexteDestination					
	LOOP Rechercher
	MOV AH, 09h
	LEA DX, TexteSource
	INT 21h						; Affichage du TexteSource avant le remplacement
	LEA DX, TexteDestination	
	INT 21h						; Affichage du TexteSource apr�s le remplacement
	
	MOV AH, 4Ch 				; Mettre fin au programme
	INT 21H	
Code ENDS
END Debut						; Fin du programme avec indication o� commence son execution
