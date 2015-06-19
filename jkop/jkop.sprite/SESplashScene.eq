
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

public class SESplashScene : SEScene
{
	class LogoInfo
	{
		public static int TYPE_STRETCHED = 0;
		public static int TYPE_FILLED = 1;
		public static int TYPE_CENTERED = 2;
		property String name;
		property int type;
		property Color background;
		property double width_ratio;
	}

	property FrameController next_scene;
	Collection logos;
	int current_logo = -1;

	public SESplashScene() {
		if(IconCache.get("eqela_splash_logo", -1, -1, true) != null) {
			add_image_centered("eqela_splash_logo", Color.black(), 0.3);
		}
	}

	void add_logo_info(LogoInfo li) {
		if(li == null) {
			return;
		}
		if(logos == null) {
			logos = Array.create();
		}
		logos.append(li);
	}

	public SESplashScene clear() {
		logos = null;
		return(this);
	}

	public SESplashScene add_image_stretched(String name) {
		if(String.is_empty(name)) {
			return(this);
		}
		add_logo_info(new LogoInfo().set_type(LogoInfo.TYPE_STRETCHED).set_name(name));
		return(this);
	}

	public SESplashScene add_image_filled(String name) {
		if(String.is_empty(name)) {
			return(this);
		}
		add_logo_info(new LogoInfo().set_type(LogoInfo.TYPE_FILLED).set_name(name));
		return(this);
	}

	public SESplashScene add_image_centered(String name, Color background, double width_ratio = 0.3) {
		if(String.is_empty(name)) {
			return(this);
		}
		add_logo_info(new LogoInfo().set_type(LogoInfo.TYPE_CENTERED).set_name(name).set_background(background).set_width_ratio(width_ratio));
		return(this);
	}

	class LogoEntity : SEEntity, SEPeriodicTimerHandler, SEAnimationListener
	{
		SELayer layer;
		SESprite logo;
		SESprite bg;
		property LogoInfo logoinfo;
		
		public void initialize(SEResourceCache rsc) {
			base.initialize(rsc);
			if(logoinfo == null) {
				next();
			}
			var name = logoinfo.get_name();
			rsc.prepare_image(name, name, 0.3 * get_scene_width());
			layer = add_layer(0, 0, get_scene_width(), get_scene_height());
			var cc = logoinfo.get_background();
			if(cc != null) {
				bg = layer.add_sprite_for_color(cc, get_scene_width(), get_scene_height());
			}
			logo = layer.add_sprite_for_image(SEImage.for_resource(name));
			logo.move(get_scene_width() / 2 - logo.get_width() / 2,
				get_scene_height() / 2 - logo.get_height() / 2);
			var ame = new SEAnimationManagerEntity();
			ame.add_element(SEFaderAnimationElement.for_fadein(layer));
			add_entity(ame);
			add_entity(SEPeriodicTimer.for_handler(this, 2000000));
		}

		public void cleanup() {
			base.cleanup();
			logo = SESprite.remove(logo);
			bg = SESprite.remove(bg);
			layer = SELayer.remove(layer);
		}

		void next() {
			var ame = new SEAnimationManagerEntity().set_listener(this);
			ame.add_element(SEFaderAnimationElement.for_fadeout(layer));
			add_entity(ame);
		}

		public void on_animation_ended() {
			var ss = get_scene() as SESplashScene;
			if(ss != null) {
				ss.next_logo();
			}
			remove_entity();
		}

		public bool on_timer(TimeVal now) {
			next();
			return(false);
		}
	}

	public void next_logo() {
		current_logo ++;
		LogoInfo logoinfo;
		if(logos != null) {
			logoinfo = logos.get(current_logo) as LogoInfo;
		}
		if(logoinfo == null) {
			switch_scene(next_scene);
			return;
		}
		add_entity(new LogoEntity().set_logoinfo(logoinfo));
	}

	public void start() {
		base.start();
		current_logo = -1;
		next_logo();
	}
}
