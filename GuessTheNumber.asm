# Guess the number game
# user will guess a number 
# game will say whether it is correct or not
# game will say if number is higher or lower
# user has 5 guesses 
.data
startMsg: .string "Welcome to guess the number. You have 5 guesses.\n The random number is somewhere from 0-20. \n"
WinMsg: .string "\nCongratulations. You win! \n"
LoseMsg: .string "Unfortunately, Your number was incorrect."
guess: .string"Enter your guess and then press the enter key: \n>"
greaterMsg: .string"\nYour guess was too high. \n"
LesserMsg: .string "\nYour guess was too low. \n"
zeroGuessMsg: .string "You ran out of guesses.\n You lose.\n"
guessesArray: .word 0,0,0,0,0
YouGuessedMsg: .string"Your guesses were: \n"
separator: .string " "
NumberWas: .string "\n The number was: "
GuessesLeft: .string "Guesses Left: "


.text
#outputs startMsg
la a0, startMsg #moves startMsg to a0
addi a7, zero, 4 # output string in a0
ecall

addi a1, zero, 20 # sets upper bound to 20 for syscall
addi a7,  zero, 42 # syscall 42 ( randint w/ upperbound) 
ecall

mv t1, a0 # stores our random number in register t1.
addi t3, zero , 5 # adds 5 to t3 - our number of guesses variable

#NEXT THREE LINES FOR TESTING PURPOSES - tells us the random num
#addi a7, zero, 1 # tells console we want to print an integer
#mv a0, t1 # moves our random number to a0
#ecall


li t4, 0 #index counter for inputting numbers in array 
li s5,0 # loop counter for outputArray

Main:
beqz t3 NoMoreGuesses # branch if number of guesses = 0 ( game end )
la a0, guess # loads guess message
addi a7, zero, 4 # print string in a0
ecall

addi a7, zero, 5 # readInt from user
ecall
mv t2, a0 # ReadInt stored in t2

#stores the digit in array (re-used this code from splitNumArray) 
slli t5,t4 ,2 # calculates byte offset in array ( *4)
la t6, guessesArray # load base address for array
add t5, t5, t6 # calculates exact address for digit
sw t2, 0(t5) # stores the digit
addi t4,t4,1 # increments the counter

addi t3,t3,-1 # decrements the variable counting user guesses

jal OutputGuesses

mv a0, t3 # moves t3 to a0
addi a7 ,zero,  1 #outputs the integer in a0
ecall

# t2 = user guess
# t1 = random number
bgt t2,t1 Greater # if guess> num 
bgt t1,t2 Lesser # if num> guess
beq t1,t2 Win # if guess is correct game is won.

Finish:
la a0, NumberWas # moves NumberWas message to a0
addi a7, zero, 4 # print string in a0
ecall

mv a0, t1 # moves t1 to a0
addi a7 ,zero,  1 #outputs the integer in a0
ecall

addi a7, zero, 10 # 10 in a7 ends the program
ecall

Win:
la a0, WinMsg # moves WinMsg to a0
addi a7, zero, 4 # print string in a0
ecall
b outputArray # unconditional branch to outputArray

Greater:
la a0, greaterMsg # moves greaterMsg to a0
addi a7, zero, 4 # prints string in a0
ecall
b Main # unconditional branch to Main

Lesser:
la a0, LesserMsg # moves LesserMsg to a0
addi a7, zero, 4 # print string in a0
ecall
b Main # unconditional branch to Main

NoMoreGuesses:
la a0, zeroGuessMsg # loads message to a0
addi a7,zero,4 # print string in a0
ecall
b outputArray # unconditional branch to outputArray


outputArray:
#outputs the 'Your guesses were:' message
la a0, YouGuessedMsg # moves YouGuessedMsg to a0
addi a7, zero, 4 # print string in a0
ecall
outputArray2:
bge s5, t4, Finish # branch if s5 = t4 (loop counter = index counter for array) only outputs however many guesses there are
slli t5, s5, 2 # calculates byte offset
add t5,t5, t6 # calculates the address in memory

lw a0, 0(t5) # loads the value in a0 so it can be outputted
li a7, 1 # outputs integer ( the guess )
ecall

la a0, separator # moves separator message to a0 to split the numbers up so they dont print next to each other
addi a7, zero, 4 # print string in a0
ecall

addi s5,s5,1 # increments the loop counter.
j outputArray2 # jumps to outputArray2 to form the loops

OutputGuesses:
la a0, GuessesLeft # moves guessesleft to a0
addi a7, zero, 4 # print string in a0
ecall
ret
