; --------------------------------------- Les Constantes ------------------------------------------------------------------
Fin EQU '$'						; Fin = Code ASCII du caractère $	
CR EQU 13						; Fin = Code ASCII du caractère qui représente un Retour chariot
LF EQU 10						; Fin = Code ASCII du caractère qui représente un saut de ligne
Virgule EQU ','					; Virgule = Code ASCII du caractère ,
PointVirgule EQU ';'			; PointVirgule = Code ASCII du caractère ;

; --------------------------------------- La pile --------------------------------------------------------------------
Pile SEGMENT STACK
	DB 100 DUP(?)
Pile ENDS

; --------------------------------------- Les variables --------------------------------------------------------------------
Data SEGMENT
	Message DB 'Interuption 96h en cours d''execution.....',FIN
Data ENDS


; ------------------------------------- Les Instructions ------------------------------------------------------------------
Code SEGMENT
ASSUME CS:Code,DS:Data 			; Faire la correspondance entre les registres segments et les segments

Interruption PROC FAR
	MOV AH, 09h
	LEA DX, Message
	INT 21h						; Affichage du TexteSource avant le remplacement
	IRET
Interruption ENDP

Debut:
	MOV AX, Data 				; AX reçoit l’adresse du segment Data
	MOV DS, AX

	PUSH DS						; Sauvegarder le contenu du registre segment DS
	XOR AX, AX
	MOV DS, AX					; DS <- 0000h
	MOV BX, 258h				; BX <- 0258h = 96h x 4
	MOV AX, OFFSET Interruption
	MOV [BX], AX				; (DS:BX) <- Adresse effective de la procedure Interruption
	MOV AX, SEG Interruption
	MOV [BX+2], AX				; (DS:BX+2) <- Adresse segment de la procedure Interruption
	POP DS						; Restituer le contenu du registre segment DS
	
	INT 96h						; Appel de l'interruption que nous venons de créer
	
	MOV AH, 4Ch 				; Mettre fin au programme
	INT 21H	
Code ENDS
END Debut						; Fin du programme avec indication où commence son execution
