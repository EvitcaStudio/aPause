#ENABLE LOCALCLIENTCODE
#BEGIN SERVERCODE
#BEGIN CLIENTCODE
#BEGIN JAVASCRIPT

(function() {
	let engineWaitId = setInterval(function() {
		if (VS.Client) {
			clearInterval(engineWaitId);
			buildPause();
		}
	})

	let buildPause = function() {
		let aPause = {};
		aPause.paused = false;
		aPause.version = '0.1.0';
		
		VS.Client.___EVITCA_aPause = true;
		VS.Client.aPause = aPause;
		VS.World.global.aPause = aPause;

		if (!VS.Client.onWindowBlurSet) {
			VS.Client._onWindowBlur = VS.Client.onWindowBlur;
			VS.Client.onWindowBlurSet = true;
			VS.Client.onWindowBlur = function() {
				aPause.pause();
				if (this._onWindowBlur) {
					this._onWindowBlur.apply(this, arguments);
				}
			}
		}

		if (!VS.Client.onWindowFocusSet) {
			VS.Client._onWindowFocus = VS.Client.onWindowFocus;
			VS.Client.onWindowFocusSet = true;
			VS.Client.onWindowFocus = function() {
				aPause.unPause();
				if (this._onWindowFocus) {
					this._onWindowFocus.apply(this, arguments);
				}
			}
		}

		aPause.pause = function() {
			this.onPaused();
			this.paused = true;
		}

		aPause.unPause = function() {
			this.onUnPaused();
			this.paused = false;
		}

		aPause.onPaused = function() {
			for (var di of VS.World.getDiobs()) {
				if (typeof(di.onPaused) === 'function') {
					di.onPaused();
				}
			}
			if (typeof(VS.Client.onPaused) === 'function') {
				VS.Client.onPaused();
			}
		}

		aPause.onUnPaused = function() {
			for (var di of VS.World.getDiobs()) {
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

// The game is automatically considered paused when the player loses focus of the game window
// The game is automatically considered unpaused when the player gains focus of the game window

// Calls Client.onPaused when the game is paused - great for showing a pause menu
// Calls Client.onUnPaused when the game is unpaused - great for hiding a pause menu

// Calls diob.onPaused on every diob except tile diobs, when the game is paused -Great for stopping a diob that is moving
// Calls diob.onUnPaused on every diob except tile diobs, when the game is unpaused. -Great for resuming movement of a diob that was moving before it was paused

// Code inside of a ticker or an upate loop can effectively be paused if you use if (aPause.paused) return at the top of the code. This should be used in controlled infinite loops rather than timed loops for best results.
#END JAVASCRIPT
#END SERVERCODE
#END CLIENTCODE
