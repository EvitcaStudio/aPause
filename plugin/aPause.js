(() => {
/*
	The game is automatically considered paused when the player loses focus of the game window
	The game is automatically considered unpaused when the player gains focus of the game window
	
	Calls Client.onPaused when the game is paused - great for showing a pause menu
	Calls Client.onUnPaused when the game is unpaused - great for hiding a pause menu
	
	Calls diob.onPaused on every diob except tile diobs, when the game is paused -Great for stopping a diob that is moving
	Calls diob.onUnPaused on every diob except tile diobs, when the game is unpaused. -Great for resuming movement of a diob that was moving before it was paused
	
	Code inside of a ticker or an upate loop can effectively be paused if you use if (aPause.paused) return at the top of the code. This should be used in controlled infinite loops rather than timed loops for best results.
*/
	// Client library
	const engineWaitId = setInterval(() => {
		if (VS.Client) {
			clearInterval(engineWaitId);
			buildPause();
		}
	})

	const buildPause = () => {
		const aPause = {};
		aPause.paused = false;
		aPause.version = '0.1.0';
		
		VS.Client.___EVITCA_aPause = true;
		VS.Client.aPause = aPause;
		VS.global.aPause = aPause;
		window.aPause = aPause;

		VS.global.aListener.addEventListener(VS.Client, 'onWindowBlur', function() {
			aPause.pause();
		});
/* 
 * desc: This is in the event the client is to unpause the game when focus is gained back. This may not be intended behavior so its not included in the library.d
		VS.global.aListener.addEventListener(VS.Client, 'onWindowFocus', function() {
			aPause.unPause();
		});
 */
		aPause.pause = function() {
			this.onPaused();
			this.paused = true;
		}

		aPause.unPause = function() {
			this.onUnPaused();
			this.paused = false;
		}

		aPause.isPaused() = function() {
			return this.paused;
		}

		aPause.onPaused = function() {
			for (const di of VS.World.getDiobs()) {
				if (typeof(di.onPaused) === 'function') {
					di.onPaused();
				}
			}
			if (typeof(VS.Client.onPaused) === 'function') {
				VS.Client.onPaused();
			}
		}

		aPause.onUnPaused = function() {
			for (const di of VS.World.getDiobs()) {
				if (typeof(di.onUnPaused) === 'function') {
					di.onUnPaused();
				}
			}
			if (typeof(VS.Client.onUnPaused) === 'function') {
				VS.Client.onUnPaused();
			}
		}

	}
})();
