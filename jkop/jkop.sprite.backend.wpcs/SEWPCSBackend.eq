
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

public class SEWPCSBackend : SEBackend
{
	embed "cs" {{{
		System.Windows.Controls.Canvas gamecanvas;
		System.Windows.Controls.Canvas mycanvas;
	}}}

	public static SEWPCSBackend instance(Frame frame, bool debug) {
		embed "cs" {{{
			System.Windows.Application.Current.Host.Settings.EnableFrameRateCounter = debug;
		}}}
		var v = new SEWPCSBackend();
		v.set_frame(frame);
		v.initialize();
		return(v);
	}
	
	public void initialize() {
		update_resource_cache();
		var frame = get_frame();
		embed "cs" {{{
			var framecanvas = frame as System.Windows.Controls.Canvas;
			if(framecanvas != null) {
				mycanvas = framecanvas.Children[0] as System.Windows.Controls.Canvas;
				if(mycanvas!=null) {
					framecanvas.Children.Remove(mycanvas);
				}
				gamecanvas = new System.Windows.Controls.Canvas() { Width = ((com.eqela.libgui.Size)frame).get_width(), Height = ((com.eqela.libgui.Size)frame).get_height() };
				framecanvas.Children.Insert(0, gamecanvas);
			}
		}}}
	}

	SEGameLoop gameloop;

	public void start(SEScene scene) {
		if(gameloop != null) {
			gameloop.stop();
		}
		var prefs = scene.get_frame_preferences();
		if(prefs != null && prefs.get_fullscreen()) {
			embed {{{
				Microsoft.Phone.Shell.SystemTray.IsVisible = false;
			}}}
		}
		base.start(scene);
		gameloop = TimerGameLoop.for_scene(scene);
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
		var frame = get_frame();
		embed "cs" {{{
			if(mycanvas!=null) {
				var framecanvas = frame as System.Windows.Controls.Canvas;
				if(framecanvas != null) {
					if(gamecanvas!=null) {
						framecanvas.Children.Remove(gamecanvas);
					}
					framecanvas.Children.Insert(0, mycanvas);
				}
			}
		}}}
		base.cleanup();
	}

	public SESprite add_sprite() {
		var v = new SEWPCSSprite();
		embed "cs" {{{
			gamecanvas.Children.Add(v.BackendCanvas);
		}}}
		v.set_rsc(get_resource_cache());
		return(v);
	}

	public SESprite add_sprite_for_image(SEImage image) {
		var sprite = add_sprite();
		if(sprite != null ) {
			sprite.set_image(image);
		}
		return(sprite);
	}

	public SESprite add_sprite_for_text(String text, String fontid) {
		var sprite = add_sprite();
		if(sprite != null ) {
			sprite.set_text(text, fontid);
		}
		return(sprite);
	}

	public SESprite add_sprite_for_color(Color color, double width, double height) {
		var sprite = add_sprite();
		if(sprite != null ) {
			sprite.set_color(color, width, height);
		}
		return(sprite);
	}

	public SELayer add_layer(double x, double y, double width, double height, bool force_clipped = false) {
		var v = new SEWPCSLayer().set_force_clipped(force_clipped);
		v.set_rsc(get_resource_cache());
		embed "cs" {{{
			gamecanvas.Children.Add(v.BackendCanvas);
		}}}
		if(v != null) {
			v.move(x,y);
			v.resize(width, height);
		}
		return(v);
	}
}
