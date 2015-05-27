
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

public class SESpriteUtil
{
	public static void set_text_and_center(SESprite sprite, String text, String fontid, double x, double y) {
		if(sprite == null) {
			return;
		}
		sprite.set_text(text, fontid);
		sprite.move(x - sprite.get_width() / 2, y - sprite.get_height() / 2);
	}

	public static void set_image_and_center(SESprite sprite, SEImage image, double x, double y) {
		if(sprite == null) {
			return;
		}
		sprite.set_image(image);
		sprite.move(x - sprite.get_width() / 2, y - sprite.get_height() / 2);
	}
}
