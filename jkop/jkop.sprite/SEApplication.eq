
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

public class SEApplication : SceneApplication
{
	property Size window_size = null;
	property bool enable_splash_scene = true;

	public virtual void customize_splash_scene(SESplashScene scene) {
	}

	public virtual FrameController create_splash_scene(FrameController next_scene) {
		var v = new SESplashScene();
		v.set_next_scene(next_scene);
		customize_splash_scene(v);
		return(v);
	}

	public FrameController customize_first_scene(FrameController scene) {
		if(enable_splash_scene) {
			return(create_splash_scene(scene));
		}
		return(scene);
	}

	public CreateFrameOptions get_frame_options() {
		parse_args();
		var v = new CreateFrameOptions();
		v.set_resizable(false);
		var ws = window_size;
		var wt = SystemEnvironment.get_env_var("EQ_SPRITEENGINE_FULLSCREEN");
		if("yes".equals(wt)) {
			ws = null;
		}
		if(ws == null) {
			v.set_type(CreateFrameOptions.TYPE_FULLSCREEN);
		}
		else {
			v.set_type(CreateFrameOptions.TYPE_NORMAL);
		}
		return(v);
	}

	public Size get_preferred_size() {
		parse_args();
		var v = window_size;
		if(v == null) {
			v = Size.instance(1024, 768);
		}
		return(v);
	}

	bool _args_parsed = false;
	void parse_args() {
		if(_args_parsed) {
			return;
		}
		_args_parsed = true;
		foreach(String arg in Application.get_instance_args()) {
			if("-fullscreen".equals(arg) || "-fs".equals(arg)) {
				window_size = null;
			}
			else if(arg.has_prefix("-window=")) {
				var wss = arg.substring(8);
				var it = wss.split('x', 2);
				var widths = String.as_string(it.next());
				var heights = String.as_string(it.next());
				if(widths != null && heights != null) {
					window_size = Size.instance(widths.to_integer(), heights.to_integer());
				}
			}
		}
	}
}
