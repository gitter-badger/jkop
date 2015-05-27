
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

class D2DSprite : D2DElement, SESprite
{
	embed {{{
		#include <d2d1.h>
	}}}

	property D2DBitmapTexture texture;
	String last_font;

	public double get_width() {
		if(texture != null) {
			return(texture.get_width());
		}
		return(0);
	}

	public double get_height() {
		if(texture != null) {
			return(texture.get_height());
		}
		return(0);
	}

	public void set_image(SEImage image) {
		var rsc = get_rsc();
		if(image != null) {
			texture = image.get_texture() as D2DBitmapTexture;
			if(texture == null && rsc != null) {
				var img = image.get_image();
				if(img != null) {
					texture = rsc.image_to_texture(img) as D2DBitmapTexture;
				}
				if(texture == null) {
					texture = rsc.get_texture(image.get_resource()) as D2DBitmapTexture;
				}
			}
		}
		if(texture != null) {
			update_matrix();
		}
	}

	public void set_text(String text, String fontid = null) {
		Image img;
		var rsc = get_rsc();
		if(rsc != null) {
			var fid = fontid;
			if(fid == null) {
				fid = last_font;
			}
			img = rsc.create_image_for_text(text, fid);
		}
		set_image(SEImage.for_image(img));
		if(fontid != null) {
			last_font = fontid;
		}
	}

	public void set_color(Color color, double width, double height) {
		if(color == null) {
			return;
		}
		var rsc = get_rsc() as D2DTargetResourceCache;
		ptr target;
		if(rsc != null) {
			target = rsc.get_d2dtarget();
		}
		if(target == null) {
			return;
		}
		texture = new D2DBitmapTexture();
		var t = texture.create_compatible_target(target, width, height);
		if(t == null) {
			return;
		}
		ptr b;
		double cr = color.get_r(), cg = color.get_g(), cb = color.get_b(), ca = color.get_a();
		embed {{{
			ID2D1SolidColorBrush* brush;
			((ID2D1RenderTarget*)t)->CreateSolidColorBrush(D2D1::ColorF(cr, cg, cb, ca), &brush);
			D2D1_RECT_F r = D2D1::RectF(0, 0, (float)width, (float)height);
			((ID2D1BitmapRenderTarget*)t)->BeginDraw();
			((ID2D1RenderTarget*)t)->Clear(D2D1::ColorF(D2D1::ColorF(0, 0.0f)));
			((ID2D1BitmapRenderTarget*)t)->FillRectangle(&r, brush);
			((ID2D1BitmapRenderTarget*)t)->EndDraw();
			((ID2D1BitmapRenderTarget*)t)->GetBitmap((ID2D1Bitmap**)&b);
			((ID2D1BitmapRenderTarget*)t)->Release();
		}}}
		texture.set_width(width);
		texture.set_height(height);
		texture.set_bitmap(b);
		update_matrix();
	}
}
