
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

public class SEGenericGameLoop : SEGameLoop, TimerHandler
{
	public static SEGenericGameLoop for_scene(SEScene scene, int target_fps = 60) {
		if(scene == null) {
			return(null);
		}
		var v = new SEGenericGameLoop().set_scene(scene).set_target_fps(target_fps);
		if(v.start() == false) {
			v = null;
		}
		return(v);
	}

	BackgroundTask timer;
	property SEScene scene;
	property int target_fps = 60;
	bool stop_flag = false;

	public bool start() {
		if(timer != null) {
			return(false);
		}
		if(GUI.engine == null) {
			return(false);
		}
		timer = Timer.start(GUI.engine.get_background_task_manager(), 1000000 / target_fps, this);
		if(timer == null) {
			return(false);
		}
		return(true);
	}

	public bool on_timer(Object arg) {
		if(stop_flag == false) {
			scene.tick();
		}
		if(stop_flag) {
			timer = null;
			return(false);
		}
		return(true);
	}

	public void stop() {
		stop_flag = true;
	}
}
