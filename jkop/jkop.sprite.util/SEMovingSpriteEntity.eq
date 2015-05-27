
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

public class SEMovingSpriteEntity : SESpriteEntity
{
	property double xspeed;
	property double yspeed;
	property int rotatespeed;

	public virtual void randomize_speed() {
		set_xspeed(get_scene_width() * (double)Math.random(0-100, 100) / 1500.0);
		set_yspeed(get_scene_width() * (double)Math.random(0-100, 100) / 1500.0);
		set_rotatespeed(Math.random(1, 3));
	}

	public virtual void on_outside_x() {
		remove_entity();
	}

	public virtual void on_outside_y() {
		remove_entity();
	}

	public void move_vector(double x, double y, double f) {
		move(get_x() + x * f, get_y() + y * f);
	}

	public void tick(TimeVal now, double delta) {
		base.tick(now, delta);
		var xspeed = get_xspeed();
		var yspeed = get_yspeed();
		move_vector(xspeed, yspeed, delta);
		set_rotation(get_rotation() + ((double)rotatespeed) * delta);
		if(get_x() < 0 - get_width() || get_x() > get_scene_width()) {
			on_outside_x();
			return;
		}
		if(get_y() < 0 || get_y() >= get_scene_height() - get_height()) {
			on_outside_y();
			return;
		}
	}
}
