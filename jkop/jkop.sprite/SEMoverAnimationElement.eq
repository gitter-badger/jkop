
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

public class SEMoverAnimationElement : SEAnimationElement
{
	public static SEMoverAnimationElement for_element(SEElement element, double sx, double sy, double ex, double ey, double factor = 1.0, bool fadeout = false, bool fadein = false) {
		var v = new SEMoverAnimationElement().set_element(element).set_start(sx, sy).set_end(ex, ey);
		v.set_factor(factor);
		v.set_fadeout(fadeout);
		v.set_fadein(fadein);
		return(v.initialize());
	}

	class MyPoint {
		property double x;
		property double y;
	}

	property SEElement element;
	property bool fadeout = false;
	property bool fadein = false;
	MyPoint start;
	MyPoint end;

	public SEMoverAnimationElement set_start(double x, double y) {
		start = new MyPoint().set_x(x).set_y(y);
		return(this);
	}

	public SEMoverAnimationElement set_end(double x, double y) {
		end = new MyPoint().set_x(x).set_y(y);
		return(this);
	}

	public SEMoverAnimationElement initialize() {
		if(element != null) {
			if(fadeout) {
				element.set_alpha(1.0);
			}
			if(fadein) {
				element.set_alpha(0.0);
			}
			if(start != null) {
				element.move(start.get_x(), start.get_y());
			}
		}
		return(this);
	}

	public void on_first_tick() {
		if(element == null) {
			return;
		}
		if(start == null) {
			start = new MyPoint().set_x(element.get_x()).set_y(element.get_y());
		}
		if(end == null) {
			end = new MyPoint().set_x(element.get_x()).set_y(element.get_y());
		}
	}
	
	public void on_animation_element_tick(double f) {
		var x = start.get_x() + (end.get_x() - start.get_x()) * f;
		var y = start.get_y() + (end.get_y() - start.get_y()) * f;
		if(fadeout) {
			element.set_alpha(1.0 - f);
		}
		if(fadein) {
			element.set_alpha(f);
		}
		element.move(x,y);
	}
}
