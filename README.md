# TypeBattle

<<<<<<< HEAD
=======
IMPORTANT: This is a simplified version of the initial project. What was removed:
- Vapor backend, responsible to sort random quotes/poems (due to maintenance costs);
- User registration/authentication not required (avoid GDPR issues)
- Incorrect constraints that were not using safe area (notch!!!)
Original repo: https://github.com/jimmyhoang/TypeBattle

>>>>>>> ddab5d4ff148df894a33e71d66dd25395dcc3949
## Introduction
TypeBattle is a real time multiplayer typing game, where players compete against each other to see who the fastest typer is.  
The player who types out the complete poem or quote first is the winner.  Players can choose to compete with other players 
around the world, or only with players in their region.

## Implementation
Firebase is used for both authentication and for real-time games.  Users can choose to sign up via email or simply login with
their Facebook account.  Facebook is integrated into the app, so it's possible to heavily expand on this and include share 
methods in the future.  All data relating to the game is stored on Firebase, each game room created is stored on Firebase
and users are added to that session as they join.  Observers are set up so users can recieve live feedback as they play
the game. Quotes and poems are used as the game's text, these are fetched from a back-end server we created with the Vapor
framework.  Additional details about the server will be linked below.

## Screenshots
![](/screenshots/mainmenu.png)
![](/screenshots/lobby.png)
![](/screenshots/ingame.png)
![](/screenshots/gameover.png)

## Built With
* [SpriteKit](https://developer.apple.com/spritekit/) - Animations and UI
* [Firebase](https://firebase.google.com/) - Data storage and authentication
* [Facebook SDK](https://developers.facebook.com/docs/swift) - Authentication
* [Vapor Server](https://github.com/alexslee/TypeBattleServer) - Back-end for quotes/poems

## Developed By
* [Jimmy Hoang](https://github.com/jimmyhoang/)
* [Fernando Jinzenji](https://github.com/fernandojinzenji)
* [Alex Lee](https://github.com/alexslee)
* [Harry Li](https://github.com/hli30)
