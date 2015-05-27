
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

class D2DLayer : D2DElement, D2DElementList, SELayer, SEElementContainer, Iterateable
{
	property bool clipped;
	Collection list;
	double width;
	double height;

	public D2DLayer() {
		list = LinkedList.create();
	}

	public double get_width() {
		return(width);
	}

	public double get_height() {
		return(height);
	}

	public void set_alpha(double alpha) {
		base.set_alpha(alpha);
	}

	public void resize(double width, double height) {
		this.width = width;
		this.height = height;
		update_children_layout();
	}

	public void move(double x, double y) {
		base.move(x, y);
		update_children_layout();
	}

	void update_children_layout() {
		if(this.width < 1 || this.height < 1) {
			return;
		}
		foreach(D2DElement e in list) {
			e.update_matrix();
		}
	}

	public void cleanup() {
		list.clear();
		list = null;
	}

	public SESprite add_sprite() {
		var sprite = new D2DSprite();
		sprite.set_mycontainer(this);
		add_element(sprite);
		sprite.set_rsc(get_rsc());
		return(sprite);
	}

	public void add_element(SEElement e) {
		list.append(e);
	}

	public void remove_element(SEElement e) {
		list.remove(e);
	}

	public Iterator iterate() {
		return(list.iterate());
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var v = add_sprite();
		v.set_image(image);
		return(v);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var v = add_sprite();
		v.set_text(text, fontid);
		return(v);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var v = add_sprite();
		v.set_color(color, width, height);
		return(v);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false) {
		var v = new D2DLayer();
		v.set_mycontainer(this);
		add_element(v);
		v.set_rsc(get_rsc());
		v.move(x, y);
		v.resize(width, height);
		v.set_clipped(force_clipped);
		return(v);
	}
}
