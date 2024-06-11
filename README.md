# Guess the Number Game

## Overview

This is a simple "Guess the Number" game developed in Assembly language for a university module on Computer Architecture during my first year at Manchester Metropolitan University (MMU).

## Features

- The game prompts the user to guess a random number between 0 and 20.
- The user has 5 attempts to guess the number.
- After each guess, the game provides feedback if the guess is too high or too low.
- The game tracks and displays all user guesses.

## Game Instructions

1. The game starts by displaying a welcome message and the rules.
2. Enter your guess when prompted.
3. The game will tell you if your guess is too high, too low, or correct.
4. You have 5 guesses to find the correct number.
5. If you guess correctly, you win. If you use all guesses without finding the correct number, you lose.

## Code Details

- Uses Assembly language system calls for random number generation and I/O operations.
- Stores user guesses in an array for display at the end of the game.
- Provides feedback on each guess and keeps track of remaining guesses.

## How to Run

1. Ensure you have an assembler and simulator for Assembly language installed. (I used RARS 1.6)
2. Clone this repository.
3. Assemble and run the code using your assembler/simulator.

