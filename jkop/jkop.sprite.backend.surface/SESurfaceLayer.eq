
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

public class SESurfaceLayer : SESurfaceElement, SELayer, SEElementContainer
{
	public static SESurfaceLayer create(SurfaceContainer container, SESurfaceLayer parent, SEResourceCache rsc) {
		if(container == null) {
			return(null);
		}
		SurfaceOptions opts;
		if(parent != null) {
			opts = SurfaceOptions.below(parent.get_helper_surface());
		}
		else {
			opts = SurfaceOptions.top();
		}
		opts.set_surface_type(SurfaceOptions.SURFACE_TYPE_CONTAINER);
		var surf = container.add_surface(opts);
		if(surf == null) {
			return(null);
		}
		var helper_surface = container.add_surface(SurfaceOptions.inside(surf));
		if(helper_surface == null) {
			container.remove_surface(surf);
			return(null);
		}
		var v = new SESurfaceLayer();
		v.set_rsc(rsc);
		v.set_surface(surf);
		v.set_helper_surface(helper_surface);
		v.set_surface_container(container);
		return(v);
	}

	property Surface helper_surface;

	public void cleanup() {
		// FIXME
	}

	public SESprite add_sprite() {
		return(SESurfaceSprite.create(get_surface_container(), this, get_rsc()));
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var sprite = SESurfaceSprite.create(get_surface_container(), this, get_rsc());
		if(sprite != null) {
			sprite.set_image(image);
		}
		return(sprite);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var sprite = SESurfaceSprite.create(get_surface_container(), this, get_rsc());
		if(sprite != null) {
			sprite.set_text(text, fontid);
		}
		return(sprite);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var sprite = SESurfaceSprite.create(get_surface_container(), this, get_rsc());
		if(sprite != null) {
			sprite.set_color(color, width, height);
		}
		return(sprite);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped) {
		// FIXME: Force the clipping (?)
		var layer = SESurfaceLayer.create(get_surface_container(), this, get_rsc());
		if(layer != null) {
			layer.move(x,y);
			layer.resize(width, height);
		}
		return(layer);
	}

	public void resize(double width, double height) {
		var surface = get_surface();
		if(surface != null) {
			surface.resize(width, height);
		}
	}

	public void remove_from_container() {
		var surface_container = get_surface_container();
		if(helper_surface != null && surface_container != null) {
			surface_container.remove_surface(helper_surface);
			helper_surface = null;
		}
		base.remove_from_container();
	}
}
