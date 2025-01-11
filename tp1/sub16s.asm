;programme 6: faire la soustraction en 16bits

data segment
    a dw 1567h
    b dw 2345h
    c dw ?
data ends
code segment 
    assume ds: data, cs: code
    begin:
        mov ax, data
        mov ds, ax
        mov ax, a
        sbb ax, b
        mov c, ax
        mov ax, 4ch
        int 21h
code ends
    end begin