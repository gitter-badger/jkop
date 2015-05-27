
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

public class SEDefaultEngine : SEEngine
{
	public static void activate() {
		SEEngine.set(new SEDefaultEngine());
	}

	public SEBackend create_backend(Frame frame, bool debug) {
		IFDEF("target_osx") {
			return(SESpriteKitBackend.instance(frame, debug));
		}
		IFDEF("target_ios") {
			return(SESpriteKitBackend.instance(frame, debug));
		}
		IFDEF("target_html") {
			return(SEHTMLElementBackend.instance(frame, debug));
		}
		IFDEF("target_wpcs") {
			return(SEWPCSBackend.instance(frame, debug));
		}
		IFDEF("target_win32") {
			return(SEDirect2DBackend.instance(frame));
		}
		IFDEF("target_linux") {
			return(SESurfaceBackend.instance(frame));
		}
		IFDEF("target_android") {
			if(true) {
				return(SESurfaceBackend.instance(frame));
			}
		}
		IFDEF("target_j2me") {
			if(true) {
				return(SESurfaceBackend.instance(frame));
			}
		}
		IFDEF("target_bbjava") {
			if(true) {
				return(SESurfaceBackend.instance(frame));
			}
		}
		IFDEF("target_j2se") {
			if(true) {
				return(SESurfaceBackend.instance(frame));
			}
		}
		Log.error("Running on unsupported platform: Failed to create any backend");
		return(null);
	}
}
