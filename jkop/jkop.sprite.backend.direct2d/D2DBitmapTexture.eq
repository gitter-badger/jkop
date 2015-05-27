
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

class D2DBitmapTexture
{
	embed {{{
		#include <d2d1.h>
	}}}

	property ptr bitmap;
	property double width;
	property double height;

	~D2DBitmapTexture() {
		var b = get_bitmap();
		if(b!=null) {
			embed {{{
				((ID2D1Bitmap*)b)->Release();
			}}}
		}
		bitmap = null;
	}

	public ptr create_compatible_target(ptr t, double w, double h) {
		if(t == null) {
			return(null);
		}
		bool success;
		ptr target;
		embed {{{
			D2D1_SIZE_F szf;
			szf.width = w;
			szf.height = h;
			D2D1_SIZE_U szu;
			szu.width = w;
			szu.height = h;
			D2D1_PIXEL_FORMAT pxf = D2D1::PixelFormat(DXGI_FORMAT_UNKNOWN, 1);
			HRESULT r = ((ID2D1RenderTarget*)t)->CreateCompatibleRenderTarget(szf, szu, pxf, 
				D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE, (ID2D1BitmapRenderTarget**)&target);
				success = SUCCEEDED(r);
			}}}
		if(success) {
			return(target);
		}
		Log.error("Failed to create bitmap render target for SE Sprite");
		return(null);
	}

	public D2DBitmapTexture initialize(ptr t, Image aimg) {
		var img = aimg as Direct2DBitmap;
		if(img == null) {
			return(null);
		}
		var width = img.get_width(), height = img.get_height();
		ptr compat_t = create_compatible_target(t, width, height), b;
		ptr d2dbmp = img.get_d2dbitmap(t);
		if(d2dbmp == null) {
			return(null);
		}
		embed {{{
			((ID2D1BitmapRenderTarget*)compat_t)->BeginDraw();
			((ID2D1RenderTarget*)compat_t)->Clear(D2D1::ColorF(D2D1::ColorF(0, 0.0f)));
			((ID2D1RenderTarget*)compat_t)->DrawBitmap(
				(ID2D1Bitmap*)d2dbmp,
				D2D1::RectF(0, 0, width, height),
				(float)1.0);
			((ID2D1BitmapRenderTarget*)compat_t)->EndDraw();
			((ID2D1BitmapRenderTarget*)compat_t)->GetBitmap((ID2D1Bitmap**)&b);
			((ID2D1BitmapRenderTarget*)compat_t)->Release();
		}}}
		bitmap = b;
		this.width = width;
		this.height = height;
		return(this);
	}
}
