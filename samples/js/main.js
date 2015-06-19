
/*
 * This file is part of Jkop
 * Copyright (c) 2015 Eqela Pte Ltd (www.eqela.com)
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// Create a new instance of SEScene, which will act
// as the main container for the application.

var mainscene = new jkop.sprite.SEScene();

// The initialize method will be called automatically to initialize
// the scene. Within initialize, we then set the background and create
// and position the rocket in the scene.

mainscene.initialize = function(rsc) {
	var sz = this.getSceneWidth() * 0.025;
	this.setBackground("black");
	var rocket = createRocket(rsc, sz);
	this.addEntity(rocket);
	rocket.move(this.getSceneWidth() / 2 - rocket.getWidth() / 2,
		this.getSceneHeight() / 2 - rocket.getHeight() / 2);
	this.rocket = rocket;
};

// The update() method represents the "game loop". This is called
// repeatedly, and can be used to advance the game state and react
// to user actions.

mainscene.update = function(now, delta) {
	var rocket = this.rocket;
	if(this.isKeyPressed("up")) {
		rocket.accelerate(delta);
	}
	if(this.isKeyPressed("left")) {
		rocket.turnLeft(delta);
	}
	if(this.isKeyPressed("right")) {
		rocket.turnRight(delta);
	}
}

// Initialize the Jkop sprite engine upon page load being complete.

window.onload = function() {
	jkopInitializeSpriteEngineApp(mainscene, [ "rocket.png" ]);
};
