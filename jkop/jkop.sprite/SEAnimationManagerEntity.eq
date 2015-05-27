
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

public class SEAnimationManagerEntity : SEEntity
{
	property int duration = 750000;
	property SEAnimationListener listener;
	TimeVal start;
	bool endflag;
	Collection elements;

	public SEAnimationManagerEntity add_element(SEAnimationElement ae) {
		if(elements == null) {
			elements = LinkedList.create();
		}
		if(ae != null) {
			elements.add(ae);
		}
		return(this);
	}

	public virtual void on_animation_manager_tick(double f) {
		foreach(SEAnimationElement ae in elements) {
			if(ae.get_done()) {
				continue;
			}
			var ff = f * ae.get_factor();
			ae.on_animation_element_tick(ff);
			if(ff >= 1.0) {
				ae.set_done(true);
			}
		}
	}

	public virtual void on_first_tick() {
		foreach(SEAnimationElement ae in elements) {
			ae.on_first_tick();
		}
	}

	public void tick(TimeVal now, double delta) {
		if(start == null) {
			start = now;
			endflag = false;
			on_first_tick();
		}
		var diff = TimeVal.diff(now, start);
		var f = (double)diff / (double)duration;
		var ef = false;
		if(f > 1) {
			f = 1;
			ef = true;
		}
		on_animation_manager_tick(f);
		if(endflag) {
			remove_entity();
			if(listener != null) {
				listener.on_animation_ended();
			}
		}
		endflag = ef;
	}
}
