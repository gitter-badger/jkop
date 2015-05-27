
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

public class SESurfaceSprite : SESurfaceElement, SESprite, Renderable
{
	public static SESurfaceSprite create(SurfaceContainer container, SESurfaceLayer parent, SEResourceCache rsc) {
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
		var surf = container.add_surface(opts);
		if(surf == null) {
			return(null);
		}
		var v = new SESurfaceSprite();
		v.set_rsc(rsc);
		v.set_surface(surf);
		v.set_surface_container(container);
		return(v);
	}

	Image image;
	String resource;
	String text;
	String fontid;
	Color color;
	double color_width;
	double color_height;

	public void set_color(Color color, double width, double height) {
		this.color = color;
		this.color_width = width;
		this.color_height = height;
		update_sprite_surface();
	}

	public void set_image(SEImage img) {
		if(img != null) {
			image = img.get_texture() as Image;
			if(image == null) {
				image = img.get_image();
			}
			resource = img.get_resource();
		}
		else {
			image = null;
			resource = null;
		}
		update_sprite_surface();
	}

	public void set_text(String text, String fontid) {
		this.text = text;
		if(fontid != null) {
			this.fontid = fontid;
		}
		update_sprite_surface();
	}

	public void update_sprite_surface() {
		var rsc = get_rsc();
		if(rsc == null) {
			return;
		}
		var img = this.image;
		if(String.is_empty(resource) == false) {
			img = rsc.get_texture(resource) as Image;
		}
		else if(String.is_empty(text) == false) {
			img = rsc.create_image_for_text(text, fontid);
		}
		var surface = get_surface();
		if(surface != null && surface is Renderable) {
			if(img == null) {
				if(color != null) {
					surface.resize(color_width, color_height);
					((Renderable)surface).render(LinkedList.create().add(
						new FillColorOperation().set_color(color).set_shape(RectangleShape.create(0,0,color_width,color_height))
					));
				}
				else {
					((Renderable)surface).render(null);
					surface.resize(0, 0);
				}
			}
			else {
				if(img.get_width() != get_width() || img.get_height() != get_height()) {
					surface.resize(img.get_width(), img.get_height());
				}
				((Renderable)surface).render(LinkedList.create().add(new DrawObjectOperation().set_object(img)));
			}
		}
	}

	public void render(Collection ops) {
		var surface = get_surface();
		if(surface != null && surface is Renderable) {
			((Renderable)surface).render(ops);
		}
	}
}
