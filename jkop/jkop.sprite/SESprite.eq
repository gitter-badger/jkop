
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

public interface SESprite : SEElement
{
	public static SESprite remove(SESprite sprite) {
		return(SEElement.remove(sprite) as SESprite);
	}

	public void set_image(SEImage image);
	public void set_text(String text, String fontid = null);
	public void set_color(Color color, double width, double height);

	IFDEF("enable_foreign_api") {
		public void setImage(strptr image);
		public void setText(strptr text, strptr fontid);
		public void setColor(strptr color, double width, double height);
	}
}
