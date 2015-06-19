
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

public class SEEntity : SEElementContainer, SEMessageListener
{
	property SEScene scene;
	property LinkedListNode mynode;
	property SEElementContainer container;

	public void on_message(Object o) {
	}

	public virtual void initialize(SEResourceCache rsc) {
	}

	public virtual void cleanup() {
	}

	public virtual void tick(TimeVal now, double delta) {
	}

	public int px(String s, int dpi = -1) {
		if(scene == null) {
			return(0);
		}
		return(scene.px(s,dpi));
	}

	public Iterator iterate_pointers() {
		if(scene == null) {
			return(null);
		}
		return(scene.iterate_pointers());
	}

	public void remove_entity() {
		if(scene != null) {
			scene.remove_entity(this);
		}
	}

	public virtual void on_entity_removed() {
	}

	public SEEntity add_entity(SEEntity entity) {
		if(scene == null || entity == null) {
			return(null);
		}
		entity.set_container(container);
		return(scene.add_entity(entity));
	}

	public int get_scene_width() {
		if(scene == null) {
			return(0);
		}
		return(scene.get_scene_width());
	}

	public int get_scene_height() {
		if(scene == null) {
			return(0);
		}
		return(scene.get_scene_height());
	}

	public bool is_key_pressed(String name) {
		if(scene == null) {
			return(false);
		}
		return(scene.is_key_pressed(name));
	}

	public SESprite add_sprite() {
		if(container != null) {
			return(container.add_sprite());
		}
		if(scene == null) {
			return(null);
		}
		return(scene.add_sprite());
	}

	public SESprite add_sprite_for_image(SEImage image) {
		if(container != null) {
			return(container.add_sprite_for_image(image));
		}
		if(scene == null) {
			return(null);
		}
		return(scene.add_sprite_for_image(image));
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		if(container != null) {
			return(container.add_sprite_for_text(text, fontid));
		}
		if(scene == null) {
			return(null);
		}
		return(scene.add_sprite_for_text(text, fontid));
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		if(container != null) {
			return(container.add_sprite_for_color(color, width, height));
		}
		if(scene == null) {
			return(null);
		}
		return(scene.add_sprite_for_color(color, width, height));
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false) {
		if(container != null) {
			return(container.add_layer(x, y, width, height, force_clipped));
		}
		if(scene == null) {
			return(null);
		}
		return(scene.add_layer(x, y, width, height, force_clipped));
	}

	IFDEF("enable_foreign_api") {
		public SEScene getScene() {
			return(scene);
		}
		public SEElementContainer getContainer() {
			return(container);
		}
		public SESprite addSprite() {
			return(add_sprite());
		}
		public SESprite addSpriteForImage(SEImage image) {
			return(add_sprite_for_image(image));
		}
		public SESprite addSpriteForText(strptr text, strptr fontid) {
			return(add_sprite_for_text(String.for_strptr(text), String.for_strptr(fontid)));
		}
		public SESprite addSpriteForColor(strptr color, double width, double height) {
			return(add_sprite_for_color(
				Color.instance(String.for_strptr(color)), width, height));
		}
		public SELayer addLayer(double x, double y, double width, double height, bool force_clipped) {
			return(add_layer(x,y,width,height,force_clipped));
		}
	}
}
