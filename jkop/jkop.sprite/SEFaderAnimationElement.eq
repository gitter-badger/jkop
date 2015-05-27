
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

public class SEFaderAnimationElement : SEAnimationElement
{
	public static SEFaderAnimationElement for_fadeout(SEElement s) {
		return(new SEFaderAnimationElement().add_fader_element(s).set_start_alpha(1.0).set_target_alpha(0.0).initialize());
	}

	public static SEFaderAnimationElement for_fadein(SEElement s) {
		return(new SEFaderAnimationElement().add_fader_element(s).set_start_alpha(0.0).set_target_alpha(1.0).initialize());
	}

	Collection elements;
	property double start_alpha;
	property double target_alpha;

	public SEFaderAnimationElement add_fader_element(SEElement s) {
		if(elements == null) {
			elements = LinkedList.create();
		}
		elements.add(s);
		return(this);
	}

	public SEFaderAnimationElement initialize() {
		foreach(SEElement element in elements) {
			element.set_alpha(start_alpha);
		}
		return(this);
	}

	public void on_animation_element_tick(double f) {
		var r = start_alpha + (target_alpha - start_alpha) * f;
		foreach(SEElement element in elements) {
			element.set_alpha(r);
		}
	}
}
