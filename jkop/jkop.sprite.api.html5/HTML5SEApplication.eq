
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

class HTML5SEApplication : SEApplication
{
	embed {{{
		function jkopInitializeSpriteEngineApp(scene, images) {
			eq.api.Application.initialize(
				eq.api.StringStatic.for_strptr("jkop.sprite.api.html5.app"),
				eq.api.StringStatic.for_strptr("Jkop application"),
				eq.api.StringStatic.for_strptr(""),
				eq.api.StringStatic.for_strptr(""),
				eq.api.StringStatic.for_strptr(""),
				eq.api.StringStatic.for_strptr(""),
				eq.api.StringStatic.for_strptr("")
			);
			eq.gui.engine.GUIEngine.initialize();
			var fr = new eq.gui.sysdep.html5.HTML5Frame();
			eq.gui.sysdep.html5.GuiEngine.eq_gui_sysdep_html5_GuiEngine_icon_ids.set(
				eq.api.StringStatic.for_strptr("eqela_splash_logo"),
				eq.api.StringStatic.for_strptr("eqela_splash_logo.png")
			);
			fr.load_icon_js("eqela_splash_logo");
			if(images) {
				for(var n=0 ; n<images.length; n++) {
					var idx = images[n].lastIndexOf('.');
					if(idx < 0) {
						continue;
					}
					var id = images[n].substring(0, idx);
					eq.gui.sysdep.html5.GuiEngine.eq_gui_sysdep_html5_GuiEngine_icon_ids.set(
						eq.api.StringStatic.for_strptr(id),
						eq.api.StringStatic.for_strptr(images[n])
					);
					fr.load_icon_js(id);
				}
			}
			var mo = new jkop.sprite.api.html5.HTML5SEApplication();
			mo.set_main_scene(scene);
			fr.initialize(mo);
			return(mo);
		}
	}}}

	public HTML5SEApplication() {
		SEDefaultEngine.activate();
	}
}
