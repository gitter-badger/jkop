
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

public class SESurfaceBackend : SEBackend
{
	public static SESurfaceBackend instance(Frame frame) {
		var v = new SESurfaceBackend();
		v.set_frame(frame);
		return(v.initialize());
	}

	SEGameLoop gameloop;

	public SESurfaceBackend initialize() {
		update_resource_cache();
		return(this);
	}

	public virtual SEGameLoop create_game_loop() {
		var sescene = get_sescene();
		if(sescene == null) {
			return(null);
		}
		return(SEGenericGameLoop.for_scene(sescene));
	}

	public void start(SEScene scene) {
		if(gameloop != null) {
			stop();
		}
		base.start(scene);
		gameloop = create_game_loop();
	}

	public void stop() {
		if(gameloop != null) {
			gameloop.stop();
			gameloop = null;
		}
		base.stop();
	}

	public void cleanup() {
		stop();
		base.cleanup();
		// FIXME
	}

	public SESprite add_sprite() {
		return(SESurfaceSprite.create(get_frame(), null, get_resource_cache()));
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var sprite = SESurfaceSprite.create(get_frame(), null, get_resource_cache());
		if(sprite != null ) {
			sprite.set_image(image);
		}
		return(sprite);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var sprite = SESurfaceSprite.create(get_frame(), null, get_resource_cache());
		if(sprite != null ) {
			sprite.set_text(text, fontid);
		}
		return(sprite);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var sprite = SESurfaceSprite.create(get_frame(), null, get_resource_cache());
		if(sprite != null ) {
			sprite.set_color(color, width, height);
		}
		return(sprite);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped) {
		// FIXME: Force the clipping (?)
		var layer = SESurfaceLayer.create(get_frame(), null, get_resource_cache());
		if(layer != null) {
			layer.move(x,y);
			layer.resize(width, height);
		}
		return(layer);
	}
}
