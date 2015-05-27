
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

public class SEBackend : SEElementContainer
{
	property SEResourceCache resource_cache;
	property SEScene sescene;
	property Frame frame;

	public virtual SEResourceCache create_resource_cache() {
		return(SEResourceCache.for_frame(frame));
	}

	public void update_resource_cache() {
		if(resource_cache != null) {
			resource_cache.cleanup();
			resource_cache = null;
		}
		resource_cache = create_resource_cache();
		resource_cache.set_frame(get_frame());
	}

	public void on_scene_changed() {
		update_resource_cache();
	}

	public virtual void start(SEScene scene) {
		this.sescene = scene;
	}

	public virtual void stop() {
		this.sescene = null;
	}

	public virtual void cleanup() {
		if(resource_cache != null) {
			resource_cache.cleanup();
			resource_cache = null;
		}
		frame = null;
		sescene = null;
	}

	public virtual bool is_high_performance() {
		return(false);
	}

	public SESprite add_sprite() {
		return(null);
	}

	public SESprite add_sprite_for_image(SEImage image) {
		return(null);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		return(null);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		return(null);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false) {
		return(null);
	}
}
