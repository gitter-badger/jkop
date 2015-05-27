
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

public class SEPeriodicTimer : SEEntity
{
	public static SEPeriodicTimer for_handler(SEPeriodicTimerHandler handler, int delay) {
		return(new SEPeriodicTimer().set_handler(handler).set_delay(delay));
	}

	property int delay;
	property SEPeriodicTimerHandler handler;
	TimeVal starttime;
	property bool remove_when_timer_expired = true;

	public virtual bool on_timer(TimeVal now) {
		if(handler != null) {
			return(handler.on_timer(now));
		}
		return(false);
	}

	public void tick(TimeVal now, double delta) {
		if(starttime == null) {
			starttime = now;
		}
		bool v = true;
		if(TimeVal.diff(now, starttime) >= delay) {
			starttime = now;
			v = on_timer(now);
		}
		if(v == false) {
			if(remove_when_timer_expired) {
				remove_entity();
			}
		}
	}
}
