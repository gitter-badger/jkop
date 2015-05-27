
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

public class SESurfaceElement : SEElement
{
	property SEResourceCache rsc;
	property Surface surface;
	property SurfaceContainer surface_container;
	double x;
	double y;
	double rotat;

	public double get_x() {
		return(x);
	}

	public double get_y() {
		return(y);
	}

	public double get_width() {
		if(surface == null) {
			return(0.0);
		}
		return(surface.get_width());
	}

	public double get_height() {
		if(surface == null) {
			return(0.0);
		}
		return(surface.get_height());
	}

	public void move(double x, double y) {
		if(surface != null) {
			surface.move(x,y);
			this.x = x;
			this.y = y;
		}
	}

	public void set_scale(double sx, double sy) {
		if(surface != null) {
			surface.set_scale(sx, sy);
		}
	}

	public void set_alpha(double f) {
		if(surface != null) {
			surface.set_alpha(f);
		}
	}

	public void set_rotation(double a) {
		if(surface != null) {
			surface.set_rotation_angle(a);
			rotat = a;
		}
	}

	public double get_scale_x() {
		if(surface == null) {
			return(0.0);
		}
		return(surface.get_scale_x());
	}

	public double get_scale_y() {
		if(surface == null) {
			return(0.0);
		}
		return(surface.get_scale_y());
	}

	public double get_alpha() {
		if(surface == null) {
			return(0.0);
		}
		return(surface.get_alpha());
	}

	public double get_rotation() {
		return(rotat);
	}

	public void remove_from_container() {
		if(surface == null || surface_container == null) {
			return;
		}
		surface_container.remove_surface(surface);
		surface = null;
		surface_container = null;
	}
}
