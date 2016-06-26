.stack 100h
.data 

A dw ?
B dw ? 
C dw ?

star1 db '                ----- Assembly Language -----     $'
star2 db 0dh,0ah,0dh,0ah,'         ----Simple Calculator For 16 bit----    $'
star3 db 0dh,0ah,0dh,0ah,'                --- Group-15 ---   $'


s db 0dh,0ah,0dh,0ah,'Press + to add $'
s0 db 0dh,0ah,'Press - to subtract $'
s2 db 0dh,0ah,'Press * to multiply $'
s3 db 0dh,0ah,'Press / to divide $'
s4 db 0dh,0ah,'Press % to mod $'
s5 db 0dh,0ah,'Press ^ to square :  $'

t db 0dh,0ah,'Want to calculate again? : $'

s1 db 0dh,0ah,0dh,0ah,'Enter a number: $'
t1 db 0dh,0ah,0dh,0ah,'Enter another number: $' 

err db 0dh,0ah,'Wrong input! Start from the beginning $'
err2 db 0dh,0ah,0dh,0ah,'Wrong input.Press Y/y or N/n $'
err3 db 0dh,0ah, 0dh,0ah, 'Out of range !$' 

r db 0dh,0ah,0dh,0ah,'the result is : $'

nl db 0dh,0ah,'$'

.code

    mov ax,@data
    mov ds,ax
    
    lea dx,star1
    mov ah,9
    int 21h
    lea dx,star2
    int 21h
    lea dx,star3
    int 21h
    
    mov bx,0
    mov cx,0
    mov dx,0
    mov ax,0


common_input:  

    lea dx,s1
    mov ah,9
    int 21h

indec proc
    
    push bx
    push cx
    push dx
    
    
    begin:
    
    
    xor bx,bx      ;holds total
    
    xor cx,cx       ;sign
                    
    
    mov ah,1        ;char in al
    int 21h
    

    cmp al,'-'       ;-
    je minus        ;yes sign
    cmp al,'+'       ;print
    
    JE plus
    
                   ;yes, get another char
    jmp repeat     ;start processing
    
    minus:
    mov cx,1         ;negative=true
    
    plus:
    
    int 21h          ;read a char
    
    repeat: 
    
    cmp al,48
    jl error
    
    cmp al,57
    jg error
    

    AND AX,00fh       ;convert to digit
    push ax           ;save on stack
    
    mov ax,10          ;get 10
    mul bx              ;ax=total * 10
    pop bx              ;get digit back
    add bx,ax           ;total = total x 10 +digit
    
    
    mov ah,1
    int 21h
    
    cmp al,0dh        ;carriage return
    jne repeat      ;no keep going

    mov ax,bx         ;store in ax
        
    cmp bx,32767
    ja error3
    jo error3
    
    cmp bx,65535
    ja error3
    jo error3
    
    
    or cx,cx          ;neg num
    
    je next
    
    neg ax            ;yes, negate
    
    jmp next
    
    pop dx            ;restore registers
    pop cx
    pop bx
    ret                    ;and return



indec endp


input_add: 

    lea dx,t1
    mov ah,9
    int 21h

indec1 proc
    
    push bx
    push cx
    push dx
    
        
    begin1:
    
    
    xor bx,bx      ;holds total
    
    xor cx,cx       ;sign
                    
    
    mov ah,1        ;char in al
    int 21h


    cmp al,'-'       ;-
    je minus1        ;yes sign
    cmp al,'+'       ;print
    
    JE plus1  
    
    cmp al,48
    jl error
    
    cmp al,57
    jg error
                     ;yes, get another char
    jmp repeat2      ;start processing
    
    minus1:
    mov cx,1         ;negative=true
    
    plus1:
    
    int 21h          ;read a char
    
    repeat2: 
    
    cmp al,48
    jl error
    
    cmp al,57
    jg error


    AND AX,00fh         ;convert to digit
    push ax             ;save on stack
    
    mov ax,10           ;get 10
    mul bx              ;ax=total * 10
    pop bx              ;get digit back
    add bx,ax           ;total = total x 10 +digit
    
    
    mov ah,1
    int 21h
    
    cmp al,0dh          ;carriage return
    jne repeat2         ;no keep going
    
    cmp bx,32767
    ja error3
    jo error3           ; if there is overflow then it will jump to error
    
    cmp bx,65535
    ja error3
    jo error3
   
    mov ax,bx           ;store in ax
    
    or cx,cx            ;neg num
    
    je add_

    neg ax               ;yes, negate
    
    jmp add_
    
    pop dx               ;restore registers
    pop cx
    pop bx
    ret                  ;and return
    
    

indec1 endp   

input_sub: 

    lea dx,t1
    mov ah,9
    int 21h

indec2 proc
    
    push bx
    push cx
    push dx
    
    
    begin2:
    
    
    xor bx,bx      ;holds total
    
    xor cx,cx       ;sign
                    

    mov ah,1        ;char in al
    int 21h
    
    
    cmp al,'-'       ;-
    je minus2        ;yes sign
    cmp al,'+'       ;print
    
    JE plus2
    
             ;yes, get another char
    jmp repeat3     ;start processing
    
    minus2:
    mov cx,1         ;negative=true
    
    plus2:
    
    int 21h          ;read a char
    
    repeat3: 
    
    cmp al,48
    jl error
    
    cmp al,57
    jg error


    AND AX,00fh       ;convert to digit
    push ax           ;save on stack
    
    mov ax,10          ;get 10
    mul bx              ;ax=total * 10
    pop bx              ;get digit back
    add bx,ax           ;total = total x 10 +digit
    
    
    mov ah,1
    int 21h
    
    cmp al,0dh        ;carriage return
    jne repeat3      ;no keep going
    
    cmp bx,32767
    ja error3
    jo error3
    
    cmp bx,65535
    ja error3
    jo error3
    
    mov ax,bx         ;store in ax
    
    or cx,cx          ;neg num
    
    je sub_
    
    neg ax            ;yes, negate
    
    jmp sub_

    pop dx            ;restore registers
    pop cx
    pop bx
    ret                    ;and return



indec2 endp 

input_mul:  

    lea dx,t1
    mov ah,9
    int 21h

indec3 proc
    
    push bx
    push cx
    push dx
    
    
    begin3:
    
    
    xor bx,bx      ;holds total
    
    xor cx,cx       ;sign
                    
    
    mov ah,1        ;char in al
    int 21h


    cmp al,'-'       ;-
    je minus3       ;yes sign
    cmp al,'+'       ;print
    
    JE plus3
    
                    ;yes, get another char
    jmp repeat4     ;start processing
    
    minus3:
    mov cx,1         ;negative=true
    
    plus3:
    
    int 21h          ;read a char
    
    repeat4: 
    
    cmp al,48
    jl error
    
    cmp al,57
    jg error


    AND AX,00fh       ;convert to digit
    push ax           ;save on stack
    
    mov ax,10          ;get 10
    mul bx              ;ax=total * 10
    pop bx              ;get digit back
    add bx,ax           ;total = total x 10 +digit
    
    
    mov ah,1
    int 21h
    
    cmp al,0dh        ;carriage return
    jne repeat4     ;no keep going
    
    cmp bx,32767
    ja error3
    jo error3
    
    cmp bx,65535
    ja error3
    jo error3
    
    mov ax,bx         ;store in ax
    
    or cx,cx          ;neg num
    
    je mul_
    
    neg ax            ;yes, negate
    
    jmp mul_
    
    pop dx            ;restore registers
    pop cx
    pop bx
    ret                    ;and return
    
    

indec3 endp  

input_div: 

    lea dx,t1
    mov ah,9
    int 21h


indec4 proc
    
    push bx
    push cx
    push dx
    
    
    begin4:
    
    
    xor bx,bx      ;holds total
    
    xor cx,cx       ;sign
                    
    
    mov ah,1        ;char in al
    int 21h
    
    
    cmp al,'-'       ;-
    je minus4       ;yes sign
    cmp al,'+'       ;print
    
    JE plus4
    
             ;yes, get another char
    jmp repeat5     ;start processing
    
    minus4:
    mov cx,1         ;negative=true
    
    plus4:
    
    int 21h          ;read a char

repeat5: 

    cmp al,48
    jl error
    
    cmp al,57
    jg error
    
    
    AND AX,00fh       ;convert to digit
    push ax           ;save on stack
    
    mov ax,10          ;get 10
    mul bx              ;ax=total * 10
    pop bx              ;get digit back
    add bx,ax           ;total = total x 10 +digit
    
    
    mov ah,1
    int 21h
    
    cmp al,0dh        ;carriage return
    jne repeat5     ;no keep going
    
    cmp bx,32767
    ja error3
    jo error3
    
    cmp bx,65535
    ja error3
    jo error3
    
    mov ax,bx         ;store in ax
    
    or cx,cx          ;neg num
    
    je div_
    
    neg ax            ;yes, negate
    
    jmp div_
    
    pop dx            ;restore registers
    pop cx
    pop bx
    ret                    ;and return



indec4 endp 

input_mod: 

    lea dx,t1
    mov ah,9
    int 21h


indec5 proc
    
    push bx
    push cx
    push dx
    
    
begin5:


    xor bx,bx      ;holds total
    
    xor cx,cx       ;sign
                    
    
    mov ah,1        ;char in al
    int 21h


    cmp al,'-'       ;-
    je minus5       ;yes sign
    cmp al,'+'       ;print
    
    JE plus5
    
             ;yes, get another char
    jmp repeat6     ;start processing
    
    minus5:
    mov cx,1         ;negative=true
    
    plus5:
    
    int 21h          ;read a char
    
    repeat6: 
    
    cmp al,48
    jl error
    
    cmp al,57
    jg error


    AND AX,00fh       ;convert to digit
    push ax           ;save on stack
    
    mov ax,10          ;get 10
    mul bx              ;ax=total * 10
    pop bx              ;get digit back
    add bx,ax           ;total = total x 10 +digit
    
    
    mov ah,1
    int 21h
    
    cmp al,0dh        ;carriage return
    jne repeat6     ;no keep going
    
    
    cmp bx,32767
    ja error3
    jo error3
    
    cmp bx,65535
    ja error3
    jo error3
    
    mov ax,bx         ;store in ax
    
    or cx,cx          ;neg num
    
    je mod_
    
    neg ax            ;yes, negate
    
    jmp mod_
    
    pop dx            ;restore registers
    pop cx
    pop bx
    ret                    ;and return
    


indec5 endp 

error:
    
    lea dx,err
    mov ah,9
    int 21h
    
    jmp common_input 
    
error2:
    
    lea dx,err2
    mov ah,9
    int 21h
    
    jmp ask1
    

error3:

    lea dx,err3
    mov ah,9
    int 21h  
    
    jmp common_input

next:


;first value stored in a
mov A,ax  

jmp ask



ask: 

    lea dx,s                   ;printing message
    mov ah,9
    int 21h
    lea dx,s0
    int 21h
    lea dx,s2
    int 21h
    lea dx,s3
    int 21h
    lea dx,s4
    int 21h
    lea dx,s5
    int 21h
    
    mov ah,1
    int 21h 
    mov bl,al 
    
    cmp bl,'+'                 ;comparing with operator
    je input_add 
    
    cmp bl,'-'
    je input_sub 
    
    cmp bl,'*'
    je input_mul 
    
    cmp bl,'/'
    je input_div
    
    cmp bl,'%'
    je input_mod
    
    cmp bl,'^'
    je sqr_   
    
    jmp error
    
    
ask1: 

    
    lea dx,t              ;if again want to calculate
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h 
    mov bl,al 
    
    cmp bl,'y'
    je common_input 
    
    cmp bl,'Y'
    je common_input 
    
    cmp bl,'n'
    je end_ 
    
    cmp bl,'N'
    je end_ 
    
    jmp error2


add_: 


    ;second value stored in b
    mov B,ax 
    
    lea dx,r
    mov ah,9
    int 21h
    
    xor ax,ax
    
    mov ax,B
    add A,ax                   ;adding two numbers
    
    
    mov ax,A
    
    cmp ax,32767
    ja error3
    jo error3
    
    cmp ax,65535
    ja error3
    jo error3
    
    push ax
    
    
    jmp output

sub_: 


    ;second value stored in b
    mov B,ax 
    
    lea dx,r
    mov ah,9
    int 21h
    
    
    xor ax,ax
    
    mov ax,B
    sub A,ax                    ;subtracting 
    
    
    mov ax,A
    
    cmp ax,32767
    ja error3
    
    cmp ax,65535
    ja error3
    
    push ax
    
    jmp output

mul_: 


    ;second value stored in b
    mov B,ax 
    
    mov C,dx
    
    lea dx,r
    mov ah,9
    int 21h
    
    xor ax,ax             
    xor dx,dx
    
    mov dx,C
    
    mov ax,B
    
    mul A                         ;multiplying
    
    cmp ax,32767
    ja error3
    jo error3
    
    cmp ax,65535
    ja error3
    jo error3
    
    push ax
    push dx
    
    jmp output 

div_: 


                         ;second value stored in b
    
    mov B,ax 
    
    mov C,dx
    
    lea dx,r
    mov ah,9
    int 21h
    
    xor ax,ax                            ;dividing
    xor dx,dx
    
    mov dx,C
    
    mov ax,A
    
    div  B
    
    cmp ax,32767
    ja error3
    jo error3
    
    cmp ax,65535
    ja error3
    jo error3
    
    push ax
    
    
    jmp output

mod_: 


                     ;second value stored in b
    
    mov B,ax 
    
    mov C,dx
    
    lea dx,r
    mov ah,9
    int 21h
    
    xor ax,ax
    xor dx,dx
    
    mov dx,C
    
    mov ax,A 
     
    div  B                         ;dividing
    
    cmp ax,32767
    ja error3
    jo error3
    
    cmp ax,65535
    ja error3
    jo error3
    
    push ax 
    push dx
    
    
    jmp output2    

sqr_:

    lea dx,r
    mov ah,9
    int 21h
    
    
    xor ax,ax
    
    mov ax,A
    
    mul A
    
    
    cmp ax,32767
    ja error3
    jo error3
    
    cmp ax,65535
    ja error3
    jo error3
    
    push ax
    
    jmp output 

output:

outdec proc
    
    
    push ax            ;save registers
    push bx
    push cx
    push dx
    
    
    or ax,ax            ;ax < 0?
    
    JGE end_if1        ;no, >0
    
    PUSH AX            ;save number
    MOV DL,'-'         ;get '-'
    mov ah,2           ;print char function 
    int 21h            ;print '-'
    pop ax             ; get ax back
    neg ax             ; ax= -ax
    
    end_if1:
    xor cx,cx         ;cx counts digits
    mov bx,10d        ;bx has divisor
    
    repeat1:
    
    xor dx,dx         ;prep high word
    div bx            ;ax = quotient, dx=remainder
    
    push dx           ;save remainder on stack
    inc cx            ;count = count +1
    
    or ax,ax          ;quotient = 0?
    jne repeat1      ;no, keep going
    
    mov ah,2          ;print char function
    
    print_loop:
    
    pop dx            ;digit in dl
    or dl,30h         ;convert to char
    int 21h           ;print digit
    cmp dx,65535
    jo error3
    cmp ax,65535
    jo error3
    loop print_loop  ;loop untill done
    
    pop dx
    pop cx            ;restore registers
    pop bx
    pop ax 
    
    jmp ask1
    
    ret
    outdec endp 

output2:

outdec2 proc
    
    
    push ax            ;save registers
    push bx
    push cx
    push dx
    
    mov ax,dx
    
    or ax,ax          ;ax < 0?
    
    JGE end_if2       ;no, >0
    
    PUSH AX            ;save number
    MOV DL,'-'         ;get '-'
    mov ah,2           ;print char function 
    int 21h            ;print '-'
    pop ax             ; get ax back
    neg ax             ; ax= -ax  
    cmp dx,65535
    jo error3
    
    end_if2:
    xor cx,cx         ;cx counts digits
    mov bx,10d        ;bx has divisor
    
    repeat_:
    
    xor dx,dx         ;prep high word
    div bx            ;ax = quotient, dx=remainder
    
    push dx           ;save remainder on stack
    inc cx            ;count = count +1
    
    or ax,ax          ;quotient = 0?
    jne repeat_      ;no, keep going
    
    mov ah,2          ;print char function
    
    print_loop1:
    
    pop dx            ;digit in dl
    or dl,30h         ;convert to char
    int 21h           ;print digit
    loop print_loop1  ;loop untill done
    
    pop dx
    pop cx            ;restore registers
    pop bx
    pop ax 
    
    jmp ask1
    
    ret
    outdec2 endp

end_:

    mov ah,4ch
    int 21h