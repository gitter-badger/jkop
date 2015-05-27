
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

public class SEImage
{
	public static SEImage for_resource(String id) {
		return(new SEImage().set_resource(id));
	}

	public static SEImage for_image(Image image) {
		return(new SEImage().set_image(image));
	}

	public static SEImage for_texture(Object txt) {
		return(new SEImage().set_texture(txt));
	}

	property String resource;
	property Image image;
	property Object texture;

	public Object as_texture(SEResourceCache rsc) {
		var txt = get_texture();
		if(txt == null && rsc != null) {
			var img = get_image();
			if(img != null) {
				txt = rsc.image_to_texture(img);
			}
			if(txt == null) {
				txt = rsc.get_texture(get_resource());
			}
		}
		return(txt);
	}
}
