
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

public class SEHTMLElementBackend : SEBackend
{
	public static SEHTMLElementBackend instance(Frame fr, bool debug = false) {
		var v = new SEHTMLElementBackend();
		if(debug) {
			v.set_debug(debug);
		}
		v.set_frame(fr);
		return(v.initialize());
	}

	property bool debug;

	public SEResourceCache create_resource_cache() {
		return(new SEHTMLElementResourceCache());
	}

	public SEHTMLElementBackend initialize() {
		update_resource_cache();
		return(this);
	}

	public ptr get_document() {
		ptr v;
		var ff = get_frame() as HTML5Frame;
		if(ff != null) {
			v = ff.get_document();
		}
		if(v == null) {
			embed {{{
				v = document;
			}}}
		}
		return(v);
	}

	public ptr get_document_body() {
		var doc = get_document();
		ptr v;
		embed {{{
			v = doc.body;
		}}}
		return(v);
	}

	public void start(SEScene scene) {
		base.start(scene);
		var self = this;
		embed {{{
			var mainloop = function() {
				self.on_update();
			};
			var animframe = window.requestAnimationFrame ||
				window.webkitRequestAnimationFrame ||
				window.mozRequestAnimationFrame ||
				window.oRequestAnimationFrame ||
				window.msRequestAnimationFrame ||
				null;
			if(animframe != null) {
				var rr = function() {
					mainloop();
					animframe(rr);
				};
				animframe(rr);
			}
			else {
				setInterval(mainloop, 1000.0 / 60.0);
			}
		}}}
	}

	public void on_update() {
		var se = get_sescene();
		if(se != null) {
			se.tick();
		}
	}

	public void stop() {
		base.stop();
	}

	public void cleanup() {
		base.cleanup();
	}

	public SESprite add_sprite() {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_resource_cache());
		v.set_document(get_document());
		v.set_parent(get_document_body());
		return(v);
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_resource_cache());
		v.set_document(get_document());
		v.set_parent(get_document_body());
		v.set_image(image);
		return(v);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_resource_cache());
		v.set_document(get_document());
		v.set_parent(get_document_body());
		v.set_text(text, fontid);
		return(v);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var v = new SEHTMLElementSprite();
		v.set_rsc(get_resource_cache());
		v.set_document(get_document());
		v.set_parent(get_document_body());
		v.set_color(color, width, height);
		return(v);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false) {
		var v = new SEHTMLElementLayer();
		v.set_force_clipping(force_clipped);
		v.set_rsc(get_resource_cache());
		v.set_document(get_document());
		v.set_parent(get_document_body());
		v.initialize();
		v.resize(width, height);
		v.move(x, y);
		return(v);
	}
}
