#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo Enter your username:
read USER_NAME_GAME

INTEGER_CHECK() {
  #Check that the user_guess is an integer and continue to ask 
  #for input until it is an integer
  while [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
  do
    echo "That is not an integer, guess again:"
    read USER_GUESS
  done
}

GUESSING_GAME() {
  #initialize the random number and guess count
  RAND_NUM=$(( RANDOM % 1000 + 1 ))
  GUESS_COUNT=0
  

  #get user guess
  echo -e "Guess the secret number between 1 and 1000:"
  read USER_GUESS

  #Check that user guess is an integer, if not ask again
  INTEGER_CHECK
  #Set guess count to 1 due to first guess
  GUESS_COUNT=1
  
  #while loop for checking against rand_numb, as user continues to guess
  while [[ $USER_GUESS != $RAND_NUM ]]
  do
    #if guess is greater than random number
    if [[ $USER_GUESS -gt $RAND_NUM ]]
      
    then
      echo -e "It's lower than that, guess again:"
      read USER_GUESS
      INTEGER_CHECK
      (( GUESS_COUNT++ ))
      #echo The guess count is: $GUESS_COUNT
    else
      echo -e "It's higher than that, guess again:"
      read USER_GUESS
      INTEGER_CHECK
      (( GUESS_COUNT++ ))
      #echo The guess count is: $GUESS_COUNT
    fi
  #echo The guess is wrong
  done
  
  #Get prev # of games from table for the user
  PREV_GAMES=$($PSQL "SELECT games_played FROM user_info WHERE username = '$USER_NAME_GAME'")
  #Get prev best from table for user
  PREV_BEST=$($PSQL "SELECT best_game_guess FROM user_info WHERE username = '$USER_NAME_GAME'")
  
  #Update the game count for user
  UPDATE_GAME_COUNT=$($PSQL "UPDATE user_info SET games_played = ($PREV_GAMES + 1) WHERE username = '$USER_NAME_GAME'")
  
  #Check if the current guess_count is less than prev_best
  if [[ -z $PREV_BEST ]]
  #if current guess is blank
  then
    UPDATE_BEST=$($PSQL "UPDATE user_info SET best_game_guess = $GUESS_COUNT WHERE username = '$USER_NAME_GAME'")
  #if current guess is not blank
  else
    if [[ $GUESS_COUNT -lt $PREV_BEST ]] #guess count is less than prev_best update
    then
      UPDATE_BEST=$($PSQL "UPDATE user_info SET best_game_guess = $GUESS_COUNT WHERE username = '$USER_NAME_GAME'")
    fi
  fi

  #Echo succesful statement with correct info
  echo -e "You guessed it in $GUESS_COUNT tries. The secret number was $RAND_NUM. Nice job!"
  
}



#Check if username exists
USER_NAME_RESULT=$($PSQL "SELECT username FROM user_info WHERE username = '$USER_NAME_GAME'")
if [[ -z $USER_NAME_RESULT ]]
#if they don't exist add to table and populate values
then
  echo -e "Welcome, $USER_NAME_GAME! It looks like this is your first time here."
  INSERT_RESULT=$($PSQL "INSERT INTO user_info(username, games_played) VALUES('$USER_NAME_GAME', 0)")
  GUESSING_GAME
else #if they exist echo response Welcome back ...
  #get games_played
  PREV_GAMES=$($PSQL "SELECT games_played FROM user_info WHERE username = '$USER_NAME_GAME'")
  #get best_result
  PREV_BEST=$($PSQL "SELECT best_game_guess FROM user_info WHERE username = '$USER_NAME_GAME'")
  #echo correct response
  echo -e "Welcome back, $USER_NAME_RESULT! You have played $PREV_GAMES games, and your best game took $PREV_BEST guesses."
  GUESSING_GAME
fi



