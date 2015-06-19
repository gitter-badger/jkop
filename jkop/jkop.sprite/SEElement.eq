
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

public interface SEElement
{
	public static SEElement remove(SEElement ee) {
		if(ee != null) {
			ee.remove_from_container();
		}
		return(null);
	}

	public void move(double x, double y);
	public void set_rotation(double angle);
	public void set_alpha(double alpha);
	public void set_scale(double scalex, double scaley);
	public double get_x();
	public double get_y();
	public double get_width();
	public double get_height();
	public double get_rotation();
	public double get_alpha();
	public double get_scale_x();
	public double get_scale_y();
	public void remove_from_container();

	IFDEF("enable_foreign_api") {
		public void setRotation(double angle);
		public void setAlpha(double alpha);
		public void setScale(double scalex, double scaley);
		public double getX();
		public double getY();
		public double getWidth();
		public double getHeight();
		public double getRotation();
		public double getAlpha();
		public double getScaleX();
		public double getScaleY();
		public void removeFromContainer();
	}
}
