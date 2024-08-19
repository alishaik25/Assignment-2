org 100h            ; Set the start address of the program

num1 dw 2413h       ; First 16-bit number (hexadecimal)
num2 dw 6587h       ; Second 16-bit number (hexadecimal)

start:
    mov ax, num1    ; Load the first number into AX
    add ax, num2    ; Add the second number to AX, result is now in AX

    ; Save the result in BX for later use
    mov bx, ax      

    ; Convert the upper byte of AX to ASCII and print it
    mov ah, al      ; Copy AL to AH
    and ah, 0F0h    ; Mask the lower nibble
    shr ah, 4       ; Shift right by 4 to get the upper nibble
    add ah, 30h     ; Convert to ASCII digit (0-9)
    cmp ah, 39h     ; Check if it's greater than '9'
    jle print_digit ; If it's a digit, jump to print

    add ah, 7       ; Convert to ASCII letter (A-F) if necessary

print_digit:
    mov dl, ah      ; Move the digit to DL
    mov ah, 02h     ; DOS interrupt to display character
    int 21h         ; Display the digit

    ; Convert the lower nibble of AL to a character and print it
    mov ah, bl      ; Copy the lower byte from BX to AH
    and ah, 0Fh     ; Mask the upper nibble
    add ah, 30h     ; Convert to ASCII digit (0-9)
    cmp ah, 39h     ; Check if it's greater than '9'
    jle print_second_digit ; If it's a digit, jump to print

    add ah, 7       ; Convert to ASCII letter (A-F) if necessary

print_second_digit:
    mov dl, ah      ; Move the digit to DL
    mov ah, 02h     ; DOS interrupt to display character
    int 21h         ; Display the digit

    ; Convert and print the second byte (upper 8 bits of the result)
    mov al, bh      ; Load the high byte from BX into AL
    mov ah, al      ; Copy AL to AH
    and ah, 0F0h    ; Mask the lower nibble
    shr ah, 4       ; Shift right by 4 to get the upper nibble
    add ah, 30h     ; Convert to ASCII digit (0-9)
    cmp ah, 39h     ; Check if it's greater than '9'
    jle print_third_digit ; If it's a digit, jump to print

    add ah, 7       ; Convert to ASCII letter (A-F) if necessary

print_third_digit:
    mov dl, ah      ; Move the digit to DL
    mov ah, 02h     ; DOS interrupt to display character
    int 21h         ; Display the digit

    ; Convert and print the lower nibble of the high byte
    mov ah, al      ; Copy the lower byte from BX to AH
    and ah, 0Fh     ; Mask the upper nibble
    add ah, 30h     ; Convert to ASCII digit (0-9)
    cmp ah, 39h     ; Check if it's greater than '9'
    jle print_fourth_digit ; If it's a digit, jump to print

    add ah, 7       ; Convert to ASCII letter (A-F) if necessary

print_fourth_digit:
    mov dl, ah      ; Move the digit to DL
    mov ah, 02h     ; DOS interrupt to display character
    int 21h         ; Display the digit

    ; End the program
    mov ah, 4Ch     ; Terminate the program
    int 21h