
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
	
class D2DSpriteRenderer : Direct2DCustomRenderer
{
	embed {{{
		#include <d2d1.h>
		#define MATRIX(x,y) ((jkop_sprite_backend_direct2d_D2DMatrix3x2F*)x)->y
	}}}

	property SEScene scene;
	property ptr d2dtarget;
	property bool stop = false;
	property SEDirect2DBackend backend;

	public void do_render_sprite(D2DSprite e, ptr t, double layer_alpha) {
		var mat = e.get_matrix();
		var tex = e.get_texture();
		var alpha = e.get_alpha() * layer_alpha;
		if(tex == null) {
			return;
		};
		ptr bitmap = tex.get_bitmap();
		var w = tex.get_width(), h = tex.get_height();
		embed {{{
			if(mat) {
				D2D1::Matrix3x2F m = D2D1::Matrix3x2F(
					MATRIX(mat, m11), MATRIX(mat, m12),
					MATRIX(mat, m21), MATRIX(mat, m22),
					MATRIX(mat, m31), MATRIX(mat, m32)
				); 
				((ID2D1RenderTarget*)t)->SetTransform(m);
			}
			((ID2D1RenderTarget*)t)->DrawBitmap(
				(ID2D1Bitmap*)bitmap,
				D2D1::RectF(0, 0, w, h),
				(float)alpha
			);
		}}}
	}

	void do_render_list(D2DElementList list, ptr target, double layer_alpha = 1.0) {
		bool clipped = false;
		if(list is D2DLayer) {
			var layer = (D2DLayer)list;
			clipped = layer.get_clipped();
			if(clipped) {
				double x = layer.get_x(), y = layer.get_y();
				double width = layer.get_width(), height = layer.get_height();
				embed {{{
					((ID2D1RenderTarget*)target)->SetTransform(D2D1::Matrix3x2F::Identity());
					((ID2D1RenderTarget*)target)->PushAxisAlignedClip(
						D2D1::RectF(x, y, x+width, y+height),
						D2D1_ANTIALIAS_MODE_PER_PRIMITIVE
					);
				}}}
			}
		}
		foreach(Object e in list) {
			if(e is D2DElementList) {
				double alpha = layer_alpha;
				if(e is D2DElement) {
					alpha *= ((D2DElement)e).get_alpha();
				}
				do_render_list((D2DElementList)e, target, alpha);
			}
			else if(e is D2DSprite) {
				do_render_sprite((D2DSprite)e, target, layer_alpha);
			}
		}
		if(clipped) {
			embed {{{
				((ID2D1RenderTarget*)target)->PopAxisAlignedClip();
			}}}
		}
	}

	public void render() {
		var t = d2dtarget;
		var scene = get_scene();
		if(t != null && scene != null) {
			if(stop == false) {
				scene.tick();
			}
			embed {{{
				((ID2D1RenderTarget*)t)->Clear(D2D1::ColorF(D2D1::ColorF(0, 0.0f)));
			}}}
			var list = backend as D2DElementList;
			if(list != null) {
				do_render_list(list, t);
			}
		}
	}
}
