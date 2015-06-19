
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

public class SEPointerInfo
{
	property int id = -1;
	property int x = -1;
	property int y = -1;
	property bool pressed = false;
	property int pressed_x = -1;
	property int pressed_y = -1;
	property PointerEvent last_event;

	public bool is_inside(double sx, double sy, double sw, double sh) {
		if(x >= sx && x < sx + sw && y >= sy && y < sy + sh) {
			return(true);
		}
		return(false);
	}

	IFDEF("enable_foreign_api") {
		public int getId() {
			return(id);
		}
		public SEPointerInfo setId(int i) {
			id = i;
			return(this);
		}
		public int getX() {
			return(x);
		}
		public SEPointerInfo setX(int v) {
			x = v;
			return(this);
		}
		public int getY() {
			return(y);
		}
		public SEPointerInfo setY(int v) {
			y = v;
			return(this);
		}
		public bool getPressed() {
			return(pressed);
		}
		public SEPointerInfo setPressed(bool v) {
			pressed = v;
			return(this);
		}
		public int getPressedX() {
			return(pressed_x);
		}
		public SEPointerInfo setPressedX(int v) {
			pressed_x = v;
			return(this);
		}
		public int getPressedY() {
			return(pressed_y);
		}
		public SEPointerInfo setPressedY(int v) {
			pressed_y = v;
			return(this);
		}
		public PointerEvent getLastEvent() {
			return(last_event);
		}
		public SEPointerInfo setLastEvent(PointerEvent ev) {
			last_event = ev;
			return(this);
		}
		public bool isInside(double sx, double sy, double sw, double sh) {
			return(is_inside(sx,sy,sw,sh));
		}
	}
}
