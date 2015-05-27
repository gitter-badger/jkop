
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

public class SimpleHighScore
{
	public static int get_current() {
		var dd = ApplicationData.for_this_application();
		if(dd == null) {
			Log.error("Cannot read high score: No application data directory");
			return(0);
		}
		var ff = dd.entry("highscore.txt");
		if(ff.is_file() == false) {
			Log.debug("High score file `%s' does not exist.".printf().add(ff));
			return(0);
		}
		var txt = ff.get_contents_string();
		if(String.is_empty(txt)) {
			Log.warning("High score file `%s' is empty.".printf().add(ff));
			return(0);
		}
		Log.debug("High score file contents: `%s'".printf().add(txt));
		return(Integer.as_integer(txt, 0));
	}

	public static void update(int score) {
		var dd = ApplicationData.for_this_application();
		if(dd == null) {
			Log.error("No application data file system found for this application");
			return;
		}
		if(dd.is_directory() == false) {
			if(dd.mkdir_recursive() == false) {
				Log.error("Failed to create directory: `%s'".printf().add(dd));
			}
		}
		var ff = dd.entry("highscore.txt");
		if(ff.set_contents_string(String.for_integer(score)) == false) {
			Log.error("Failed to write high score file: `%s'".printf().add(ff));
		}
		else {
			Log.debug("High score successfully written to: `%s'".printf().add(ff));
		}
	}
}
