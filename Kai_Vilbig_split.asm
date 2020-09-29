	;; CMSC 313 Proj3: split.asm
	;; Kai Vilbig
	;; sw92057
	;; sw92057@umbc.edu

	;; This program will take in a 15 character long string entered by the user and
	;; split the string at the 9th character and puts the second part of the string
	;; at the front.
	;; example: 123456789012345 -> 901234512345678
	;; and: This is a word. -> a word.This is

	
	section .data
enter_string_msg:	db	"Enter a 15 Character string to split:", 10
len_esm:	        equ	$-enter_string_msg ;gets length of enter_string_msg

unedited_text_msg:	db	"Here is your string unedited:", 10
len_utm:		equ	$-unedited_text_msg ;gets len of unedited_text_msg

edited_text_msg:	db	"Here is your string edited:", 10
len_etm:		equ	$edited_text_msg ;gets len of edited_text_msg

new_line:	db	10	;newline

	
	section .bss
string_buff:	resb	15	;reserve 15 bytes for user input

	
	section .text
	global main

main:
	mov rax, 1              ;write
	mov rdi, 1		;write
	mov rsi, new_line 	;write newline to screen for neatness
	mov rdx, 1
	syscall			;write new line
	
	mov rax, 1		;write the message string to the terminal
	mov rdi, 1		;write string
	mov rsi, enter_string_msg ;write msg to screen
	mov rdx, len_esm
	syscall			;write message to the screen

	mov rax, 0		;read
	mov rdi, 0		;read
	mov rsi, string_buff	;read data from stfd in (user input) and put into string_buff
	mov rdx, 15
	syscall			;read data from std in

	mov rax, 1		;write
	mov rdi, 1		;write
	mov rsi, unedited_text_msg ;write unedited_text_msg to screen
	mov rdx, len_utm
	syscall			;write msg to screen
	
	mov rax, 1		;write
	mov rdi, 1		;write
	mov rsi, string_buff	;write what is stored in string_buff to terminal screen
	mov rdx, 15
	syscall			;write string_buff to screen

	mov rax, 1              ;write
	mov rdi, 1		;write
	mov rsi, new_line 	;write newline to screen so that the edited string will be on
				;a new line
	mov rdx, 1
	syscall			;write new line
	
	mov r9, [string_buff + 8] ;storing the back half of string_buff in r9
	mov r8, [string_buff]     ;storing the front half of string_buff in r8
	mov [string_buff], r9	  ;putting what is in r9 (back half of string_buff) at the 
				  ;front of string_buff 
	mov [string_buff + 7], r8 ;putting what is in r8 (front half of origional string_buff)
	 			  ;at the back of string_buff

	mov rax, 1		;write
	mov rdi, 1		;write
	mov rsi, edited_text_msg ;write edited_text_msg to screen
	mov rdx, 28		 ;used the number 28 instead of len_etm because when i used
				 ;that it printed out the edited string_buff twice
	syscall			;write msg to screen
	
	mov rax, 1		  ;write
	mov rdi, 1		  ;write
	mov rsi, string_buff	  ;put address of string_buff in rsi
	mov rdx, 15
	syscall			;write the new edited string_buff to the screen

	mov rax, 1		;write
	mov rdi, 1		;write
	mov rsi, new_line 	;write newline to screen so that once program is done the
				;terminal text will be on a new line
	mov rdx, 1
	syscall			;write new line

	mov rax, 1              ;write
	mov rdi, 1		;write
	mov rsi, new_line 	;write newline to screen so that it looks nice
	mov rdx, 1
	syscall			;write new line
	
exit:
	mov rax, 60		;put exit syscall to rax
	xor rdi, rdi		;exit
	syscall			;exit
