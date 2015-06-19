
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

function createRocket(rsc, sz)
{
	// Create a new "sprite entity" object

	var rocket = new jkop.sprite.SESpriteEntity();

	// Set the sprite entity to be represented by the "rocket" image

	rocket.set_initial_image(rsc.prepareImage("rocket", sz));

	// Initial speed: Stay still.

	rocket.speedx = 0.0;
	rocket.speedy = 0.0;

	// Called by the main program to rotate towards the left.

	rocket.turnLeft = function(n) {
		this.setRotation(this.getRotation() - Math.PI * n);
	}

	// Called by the main program to rotate towards the right.

	rocket.turnRight = function(n) {
		this.setRotation(this.getRotation() + Math.PI * n);
	}

	// Called by the main program to accelerate, taking into
	// account the current rotation / direction.

	rocket.accelerate = function(n) {
		var angle = this.getRotation() - Math.PI / 2;
		var x = Math.cos(angle) * 1000.0 * n;
		var y = Math.sin(angle) * 1000.0 * n;
		rocket.speedx += x;
		rocket.speedy += y;
	}

	// Automatically called by the sprite engine framework in order
	// to advance state and/or react to time passing.

	rocket.tick = function(now, delta) {
		var xspeed = this.speedx * delta;
		var yspeed = this.speedy * delta;
		var nx = this.getX() + xspeed;
		var ny = this.getY() + yspeed;
		var scene = this.getScene();
		var sw = scene.getSceneWidth();
		var sh = scene.getSceneHeight();
		if(nx < -sz) {
			nx = sw;
		}
		else if(nx >= sw + sz) {
			nx = 0;
		}
		if(ny < -sz) {
			ny = sh;
		}
		else if(ny >= sh + sz) {
			ny = 0;
		}
		this.move(nx, ny);
	}

	return(rocket);
}
