
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

public class SEButtonEntity : SESpriteEntity, SEPointerListener
{
	class SEImageButtonEntity : SEButtonEntity
	{
		property SEImage image_normal;
		property SEImage image_hover;
		property SEImage image_pressed;

		public void update() {
			if(get_pressed()) {
				var img = image_pressed;
				if(img == null) {
					img = image_hover;
				}
				if(img == null) {
					img = image_normal;
				}
				set_image(img);
			}
			else if(get_has_pointer()) {
				var img = image_hover;
				if(img == null) {
					img = image_normal;
				}
				set_image(img);
			}
			else {
				set_image(image_normal);
			}
		}
	}

	class SETextButtonEntity : SEButtonEntity
	{
		property String button_text;
		property String normal_font;
		property String hover_font;
		property String pressed_font;

		public void update() {
			if(get_pressed()) {
				var ff = pressed_font;
				if(String.is_empty(ff)) {
					ff = hover_font;
				}
				if(String.is_empty(ff)) {
					ff = normal_font;
				}
				set_text(button_text, ff);
			}
			else if(get_has_pointer()) {
				var ff = hover_font;
				if(String.is_empty(ff)) {
					ff = normal_font;
				}
				set_text(button_text, ff);
			}
			else {
				set_text(button_text, normal_font);
			}
		}
	}

	public static SEButtonEntity for_image(SEImage img) {
		return(SEButtonEntity.for_images(img, null, null));
	}

	public static SEButtonEntity for_images(SEImage normal, SEImage hover, SEImage pressed) {
		return(new SEImageButtonEntity().set_image_normal(normal).set_image_hover(hover)
			.set_image_pressed(pressed));
	}

	public static SEButtonEntity for_text(String text, String normal_font = null, String hover_font = null, String pressed_font = null) {
		return(new SETextButtonEntity().set_button_text(text).set_normal_font(normal_font).set_hover_font(hover_font)
			.set_pressed_font(pressed_font));
	}

	property SEMessageListener listener;
	property Object data;
	bool pressed = false;
	bool has_pointer = false;

	public bool get_pressed() {
		return(pressed);
	}

	public bool get_has_pointer() {
		return(has_pointer);
	}

	public void initialize(SEResourceCache rsc) {
		base.initialize(rsc);
		update();
	}

	public virtual void update() {
	}

	public virtual void on_pointer_enter(SEPointerInfo pi) {
		if(has_pointer) {
			return;
		}
		has_pointer = true;
		update();
	}

	public virtual void on_pointer_leave(SEPointerInfo pi) {
		if(has_pointer == false && pressed == false) {
			return;
		}
		has_pointer = false;
		pressed = false;
		update();
	}

	public void on_pointer_move(SEPointerInfo pi) {
		if(pi.is_inside(get_x(), get_y(), get_width(), get_height())) {
			if(has_pointer == false) {
				on_pointer_enter(pi);
			}
		}
		else {
			if(has_pointer) {
				on_pointer_leave(pi);
			}
		}
	}

	public void on_pointer_press(SEPointerInfo pi) {
		if(pressed) {
			return;
		}
		if(pi.is_inside(get_x(), get_y(), get_width(), get_height()) == false) {
			return;
		}
		pressed = true;
		update();
	}

	public void on_pointer_release(SEPointerInfo pi) {
		if(pressed == false) {
			return;
		}
		if(pi.is_inside(get_x(), get_y(), get_width(), get_height()) == false) {
			return;
		}
		on_pointer_click(pi);
		pressed = false;
		update();
	}

	public virtual void on_pointer_click(SEPointerInfo pi) {
		if(listener != null) {
			listener.on_message(data);
		}
	}
}
