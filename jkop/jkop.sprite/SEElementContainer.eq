
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

public interface SEElementContainer
{
	public SESprite add_sprite();
	public SESprite add_sprite_for_image(SEImage image);
	public SESprite add_sprite_for_text(String text, String fontid);
	public SESprite add_sprite_for_color(Color color, double width, double height);
	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false);
}
