org 100h        ; Set the start address of the program
num1 db 27h     ; First 8-bit number (hexadecimal)
num2 db 6h     ; Second 8-bit number (hexadecimal)
start:
mov al, num1    ; Load the first number into the register AL
add al, num2    ; Add the second number to AL, result is now in AL
mov bl, al      ; Save the result in BL for further use
; Convert the upper nibble of AL to a character
mov ah, al      ; Copy AL to AH
and ah, 0F0h    ; Mask the lower nibble
shr ah, 4       ; Shift right by 4 to get the upper nibble
add ah, 30h     ; Convert to ASCII digit (0-9)
cmp ah, 39h     ; Check if it's greater than '9'
jle print_first_digit ; If it's a digit, jump to print
add ah, 7       ; Convert to ASCII letter (A-F) if necessary
print_first_digit:
mov dl, ah      ; Move the first digit to DL
mov ah, 02h     ; BIOS interrupt to display character
int 21h         ; Display the first digit
; Convert the lower nibble of AL to a character
mov ah, bl      ; Copy the result back to AH from BL
and ah, 0Fh     ; Mask the upper nibble
add ah, 30h     ; Convert to ASCII digit (0-9)
cmp ah, 39h     ; Check if it's greater than '9'
jle print_second_digit ; If it's a digit, jump to print
add ah, 7       ; Convert to ASCII letter (A-F) if necessary
print_second_digit:
mov dl, ah      ; Move the second digit to DL
mov ah, 02h     ; BIOS interrupt to display character
int 21h         ; Display the second digit
; End the program
mov ah, 4Ch     ; Terminate the program
int 21h
ret