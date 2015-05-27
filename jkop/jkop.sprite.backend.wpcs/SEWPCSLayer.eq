
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

public class SEWPCSLayer : SEWPCSElement, SELayer, SEElementContainer
{
	property bool force_clipped;

	public void cleanup() {
		embed "cs" {{{
			BackendCanvas.Children.Clear();
		}}}
	}

	public SESprite add_sprite() {
		var v = new SEWPCSSprite();
		embed "cs" {{{
			BackendCanvas.Children.Add(v.BackendCanvas);
		}}}
		v.set_rsc(get_rsc());
		return(v);
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var v = add_sprite();
		v.set_image(image);
		return(v);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var v = add_sprite();
		if(v != null) {
			v.set_text(text, fontid);
		}
		return(v);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var v = add_sprite();
		if(v != null) {
			v.set_color(color, width, height);
		}
		return(v);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false) {
		var v = new SEWPCSLayer().set_force_clipped(force_clipped);
		embed "cs" {{{
			BackendCanvas.Children.Add(v.BackendCanvas);
		}}}
		v.move(x,y);
		v.resize(width, height);
		return(v);
	}

	public void resize(double width, double height) {
		resize_backend(width, height);
		if(force_clipped) {
			embed {{{
				BackendCanvas.Clip = new System.Windows.Media.RectangleGeometry() { Rect = new System.Windows.Rect(0, 0, width, height) };
			}}}
		}
	}
}
