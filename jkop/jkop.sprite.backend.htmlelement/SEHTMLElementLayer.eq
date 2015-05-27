
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

public class SEHTMLElementLayer : SEHTMLElementElement, SEElementContainer, SELayer
{
	property bool force_clipping = false;
		
	public void resize(double width, double height) {
		var el = get_element();
		if(el == null) {
			return;
		}
		var iw = (int)width;
		var ih = (int)height;
		embed {{{
			el.style.width = iw;
			el.style.height = ih;
		}}}
		set_width(iw);
		set_height(ih);
	}

	public void initialize() {
		ptr el;
		var pp = get_parent();
		var mydoc = get_document();
		var force_clipping = this.force_clipping;
		embed {{{
			el = mydoc.createElement("div");
			el.style.position = "absolute";
			if(force_clipping) {
				el.style.overflow = "hidden";
			}
			pp.appendChild(el);
		}}}
		set_element(el);
	}

	public void cleanup() {
		remove_from_container();
		set_element(null);
	}

	public SESprite add_sprite() {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_rsc());
		v.set_document(get_document());
		v.set_parent(get_element());
		return(v);
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_rsc());
		v.set_document(get_document());
		v.set_parent(get_element());
		v.set_image(image);
		return(v);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_rsc());
		v.set_document(get_document());
		v.set_parent(get_element());
		v.set_text(text, fontid);
		return(v);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_rsc());
		v.set_document(get_document());
		v.set_parent(get_element());
		v.set_color(color, width, height);
		return(v);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false) {
		var v = new SEHTMLElementLayer();
		v.set_force_clipping(force_clipped);
		v.set_rsc(get_rsc());
		v.set_parent(get_element());
		v.initialize();
		v.resize(width, height);
		v.move(x, y);
		return(v);
	}
}
