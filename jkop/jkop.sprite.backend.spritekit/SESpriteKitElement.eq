
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

public class SESpriteKitElement : SEElement
{
	embed {{{
		#import <SpriteKit/SpriteKit.h>
	}}}

	property SEResourceCache rsc;
	property ptr parent;
	property ptr node;
	double x;
	double y;
	double angle;
	double scale_x = 1.0;
	double scale_y = 1.0;
	double alpha = 1.0;

	public ~SESpriteKitElement() {
		remove_node();
	}

	public void remove_node() {
		if(node == null) {
			return;
		}
		var ndp = node;
		embed {{{
			SKNode* nd = (__bridge_transfer SKNode*)ndp;
			[nd removeFromParent];
		}}}
		node = null;
	}
		
	public void move(double x, double y) {
		this.x = x;
		this.y = y;
		update_position();
	}

	public void update_position() {
		var ndp = get_node();
		if(ndp == null) {
			return;
		}
		var skc = get_parent();
		var x = get_x();
		var y = get_y();
		var sx = get_scale_x();
		var sy = get_scale_y();
		var w = get_width();
		var h = get_height();
		embed {{{
			SKNode* sknd = (__bridge SKNode*)ndp;
			CGSize sz, ndsz;
			sz = [(__bridge SKNode*)skc frame].size;
			if(sx != 1.0 || sy != 1.0) {
				sknd.xScale = sx;
				sknd.yScale = sy;
			}
			ndsz = [sknd frame].size;
			if(ndsz.width < 1 || ndsz.height < 1) {
				sknd.position = CGPointMake(x, sz.height - y);
			}
			else {
				sknd.position = CGPointMake(x + w / 2, sz.height - y - h / 2);
			}
		}}}
	}

	public double get_width() {
		return(0);
	}

	public double get_height() {
		return(0);
	}

	public void set_rotation(double angle) {
		this.angle = angle;
		if(node == null) {
			return;
		}
		var ndp = node;
		embed {{{
			SKNode* sknd = (__bridge SKNode*)ndp;
			sknd.zRotation = -angle;
		}}}
	}

	public void set_scale(double sx, double sy) {
		this.scale_x = sx;
		this.scale_y = sy;
		update_position();
	}

	public double get_scale_x() {
		return(scale_x);
	}

	public double get_scale_y() {
		return(scale_y);
	}

	public void set_alpha(double alpha) {
		this.alpha = alpha;
		if(node == null) {
			return;
		}
		var ndp = node;
		embed {{{
			SKNode* sknd = (__bridge SKNode*)ndp;
			sknd.alpha = alpha;
		}}}
	}

	public double get_x() {
		return(x);
	}

	public double get_y() {
		return(y);
	}

	public double get_rotation() {
		return(angle);
	}

	public double get_alpha() {
		return(alpha);
	}

	public void remove_from_container() {
		remove_node();
	}
}
