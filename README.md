# aPause  
A plugin that pauses the game when the screen loses focus.

## Implementation (`Client-Side-Only`)

#### #INCLUDE SCRIPT aPause.js  

## How to reference  
### `Javascript`
#### aPause|VS.global.aPause|VS.Client.aPause  
  
### `VyScript`  
#### aPause|Client.aPause

## API   

###  aPause.pause()   
   - `desc`: Pause the game   

###  aPause.unPause()  
   - `desc`: Unpause the game     

###  aPause.isPaused()  
   - `desc`: Check if the game is currently paused or not    
   - `returns`: `true` if the game is paused, `false` if not     

###  Client.onPaused()  `event`  
   - `desc`: Event function called when the game is paused       

###  Client.onUnPaused()  `event`  
   - `desc`: Event function called when the game is unpaused    

###  diobInstance.onPaused()  `event`  
   - `desc`: Event function called when the game is paused       

###  diobInstance.onUnPaused()  `event`  
   - `desc`: Event function called when the game is unpaused     
