
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

class D2DTargetResourceCache : SEResourceCache
{
	property ptr d2dtarget;

	public static D2DTargetResourceCache for_d2dtarget(ptr target) {
		var v = new D2DTargetResourceCache();
		v.d2dtarget = target;
		return(v);
	}

	public Object image_to_texture(Image img) {
		return(new D2DBitmapTexture().initialize(d2dtarget, img));
	}
}
