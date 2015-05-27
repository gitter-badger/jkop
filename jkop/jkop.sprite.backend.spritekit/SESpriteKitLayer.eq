
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

public class SESpriteKitLayer : SESpriteKitElement, SEElementContainer, SELayer
{
	embed {{{
		#import <SpriteKit/SpriteKit.h>
	}}}

	double width;
	double height;

	ptr get_container() {
		return(get_node());
	}

	public virtual void create_layer_node(double width, double height) {
		ptr ndp;
		var parent = get_parent();
		embed {{{
			SKNode* pnode = (__bridge SKNode*)parent;
			SKNode* nd = [SKNode node];
			ndp = (__bridge_retained void*)nd;
			[pnode addChild:nd];
		}}}
		set_node(ndp);
	}

	public void resize(double width, double height) {
		remove_node();
		if(width < 1 || height < 1) {
			return;
		}
		create_layer_node(width, height);
		this.width = width;
		this.height = height;
		update_position();
	}

	public void cleanup() {
		remove_node();
	}

	public double get_width() {
		return(width);
	}

	public double get_height() {
		return(height);
	}

	public SESprite add_sprite() {
		var v = new SESpriteKitSprite();
		v.set_rsc(get_rsc());
		v.set_parent(get_container());
		return(v);
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var v = new SESpriteKitSprite();
		v.set_rsc(get_rsc());
		v.set_parent(get_container());
		v.set_image(image);
		return(v);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var v = new SESpriteKitSprite();
		v.set_rsc(get_rsc());
		v.set_parent(get_container());
		v.set_text(text, fontid);
		return(v);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var v = new SESpriteKitSprite();
		v.set_rsc(get_rsc());
		v.set_parent(get_container());
		v.set_color(color, width, height);
		return(v);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped) {
		SESpriteKitLayer v;
		if(force_clipped) {
			v = new SESpriteKitClippedLayer();
		}
		else {
			v = new SESpriteKitLayer();
		}
		v.set_rsc(get_rsc());
		v.set_parent(get_container());
		v.resize(width, height);
		v.move(x, y);
		return(v);
	}
}
