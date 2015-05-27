
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

public class SEHTMLElementElement : SEElement
{
	double x;
	double y;
	double width;
	double height;
	double rotation;
	double alpha = 1.0;
	double scale_x = 1.0;
	double scale_y = 1.0;
	property ptr element;
	ptr parent;
	property SEResourceCache rsc;
	property ptr document;

	public void set_x(double x) {
		this.x = x;
	}

	public void set_y(double y) {
		this.y = y;
	}

	public void set_width(double width) {
		this.width = width;
	}

	public void set_height(double height) {
		this.height = height;
	}

	public void set_parent(ptr pp) {
		parent = pp;
	}

	public ptr get_parent() {
		return(parent);
	}

	public void move(double x, double y) {
		if(element != null) {
			var ee = element;
			var ix = (int)x;
			var iy = (int)y;
			embed {{{
				ee.style.left = ix;
				ee.style.top = iy;
			}}}
		}
		this.x = x;
		this.y = y;
	}

	void update_transform() {
		var ee = element;
		if(ee != null) {
			var ang = rotation * 180.0 / MathConstant.M_PI;
			var str = "rotate(%ddeg) scale(%f,%f)".printf().add(ang).add(scale_x).add(scale_y).to_string();
			var sp = str.to_strptr();
			embed {{{
				ee.style.transform = sp;
				ee.style.webkitTransform = sp;
				ee.style.msTransform = sp;
				ee.style.oTransform = sp;
				ee.style.mozTransform = sp;
			}}}
		}
	}

	public void set_rotation(double a) {
		rotation = a;
		update_transform();
	}

	public void set_scale(double sx, double sy) {
		scale_x = sx;
		scale_y = sy;
		update_transform();
	}

	public void set_alpha(double alpha) {
		var ee = element;
		if(ee != null) {
			embed {{{
				ee.style.opacity = alpha;
			}}}
		}
		this.alpha = alpha;
	}

	public double get_x() {
		return(x);
	}

	public double get_y() {
		return(y);
	}

	public double get_scale_x() {
		return(scale_x);
	}

	public double get_scale_y() {
		return(scale_y);
	}

	public double get_width() {
		return(width);
	}

	public double get_height() {
		return(height);
	}

	public double get_rotation() {
		return(rotation);
	}

	public double get_alpha() {
		return(alpha);
	}

	public void remove_from_container() {
		if(element == null) {
			return;
		}
		var ee = element;
		embed {{{
			if(ee.parentNode != null) {
				ee.parentNode.removeChild(ee);
			}
		}}}
		element = null;
	}
}
