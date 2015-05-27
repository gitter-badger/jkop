
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

public class SEResourceCache
{
	public static SEResourceCache for_frame(Frame frame) {
		return(new SEResourceCache().set_frame(frame));
	}

	Frame frame;
	property int dpi = 96;
	HashTable images;
	HashTable fonts;
	HashTable sheets;

	~SEResourceCache() {
		cleanup();
	}

	public virtual void release_texture(Object o) {
		if(o == null) {
			return;
		}
		if(o is Image) {
			((Image)o).release();
		}
	}

	public virtual void cleanup() {
		Log.debug("SEResourceCache: Cleaning up cached resources ..");
		if(images != null) {
			foreach(var img in images.iterate_values()) {
				release_texture(img);
			}
			images = null;
		}
		fonts = null;
		if(sheets != null) {
			foreach(Collection sheet in sheets.iterate_values()) {
				foreach(var o in sheet) {
					release_texture(o);
				}
			}
			sheets = null;
		}
	}

	public Frame get_frame() {
		return(frame);
	}

	public SEResourceCache set_frame(Frame frame) {
		this.frame = frame;
		if(frame != null) {
			set_dpi(frame.get_dpi());
		}
		else {
			set_dpi(96);
		}
		return(this);
	}

	public virtual void on_font_prepared(String id) {
	}

	public bool prepare_font(String id, String details, double height) {
		if(String.is_empty(id)) {
			return(false);
		}
		var font = Font.instance(details);
		if(font == null) {
			return(false);
		}
		if(height > 0) {
			var sz = "%dpx".printf().add((int)Math.rint(height)).to_string();
			font.set_size(sz);
		}
		if(fonts == null) {
			fonts = HashTable.create();
		}
		Log.debug("SEResourceCache: Prepared font `%s': `%s' / %f".printf().add(id).add(details).add(height));
		fonts.set(id, font);
		on_font_prepared(id);
		return(true);
	}

	public Font get_font(String id) {
		Font v;
		if(fonts != null) {
			v = fonts.get(id) as Font;
		}
		if(v == null) {
			v = Font.instance("4mm");
		}
		return(v);
	}

	public virtual Object image_to_texture(Image img) {
		return(img);
	}

	public Image create_image_for_text(String text, String fontid) {
		var img = TextImage.for_properties(TextProperties.for_string(text).set_font(get_font(fontid)), get_frame(), get_dpi());
		return(img);
	}

	public Object create_texture_for_text(String text, String fontid) {
		return(image_to_texture(create_image_for_text(text, fontid)));
	}

	public Array get_image_sheet(String id) {
		if(sheets == null) {
			return(null);
		}
		return(sheets.get(id) as Array);
	}

	public bool prepare_image_sheet(String id, String resid, int cols, int rows, int max, double width, double height = -1.0) {
		if(id == null) {
			return(false);
		}
		if(sheets != null) {
			var v = sheets.get(id) as Array;
			if(v != null) {
				return(true);
			}
		}
		var ars = resid;
		if(ars == null) {
			ars = id;
		}
		Image img;
		IFDEF("target_html") {
			img = IconCache.get(ars);
		}
		ELSE {
			img = Image.for_resource(ars);
		}
		if(img == null) {
			Log.error("Failed to read image resource: `%s'".printf().add(ars));
			return(false);
		}
		var imgs = new ImageSheet().set_sheet(img).set_cols(cols).set_rows(rows).set_max_images(max).to_images((int)width, (int)height);
		if(imgs == null) {
			return(false);
		}
		if(sheets == null) {
			sheets = HashTable.create();
		}
		var nimgs = Array.create(imgs.count());
		int n;
		for(n=0; n<imgs.count(); n++) {
			nimgs.set(n, image_to_texture(imgs.get(n) as Image));
		}
		sheets.set(id, nimgs);
		return(true);
	}

	public bool prepare_image(String id, String resid, double width, double height = -1.0) {
		if(images == null) {
			images = HashTable.create();
		}
		var oo = images.get(id);
		if(oo != null) {
			return(true);
		}
		var ars = resid;
		if(ars == null) {
			ars = id;
		}
		Image img;
		IFDEF("target_html") {
			img = IconCache.get(ars);
		}
		ELSE {
			img = Image.for_resource(ars);
		}
		if(img == null) {
			Log.error("Failed to read image resource: `%s'".printf().add(ars));
			return(false);
		}
		if(width > 0.0 || height > 0.0) {
			var nw = width, nh = height;
			if(nw == 0) {
				nw = img.get_width();
			}
			if(nh == 0) {
				nh = img.get_height();
			}
			if((nw > 0 && ((int)nw) != img.get_width()) || (nh > 0 && ((int)nh) != img.get_height())) {
				img = img.resize((int)nw, (int)nh);
			}
			if(img == null) {
				Log.error("Failed to scale image `%s' as %f x %f".printf().add(ars).add(nw).add(nh));
				return(false);
			}
		}
		var txt = image_to_texture(img);
		if(txt == null) {
			Log.error("Preparing image `%s': Failed to convert image to texture".printf().add(id));
			return(false);
		}
		images.set(id, txt);
		Log.debug("SEResourceCache: Prepared image `%s' (%dx%dpx)".printf().add(id).add(img.get_width()).add(img.get_height()));
		return(true);
	}

	public Object get_texture(String id) {
		if(images != null) {
			var v = images.get(id);
			if(v != null) {
				return(v);
			}
		}
		return(null);
	}
}
