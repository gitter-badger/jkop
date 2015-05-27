
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

public class SESpriteKitTexture
{
	embed {{{
		#import <SpriteKit/SpriteKit.h>
	}}}

	public static SESpriteKitTexture for_image(Image img) {
		return(new SESpriteKitTexture().set_image(img));
	}

	property ptr sktexture;

	public ~SESpriteKitTexture() {
		clear();
	}

	public void clear() {
		var skt = sktexture;
		if(skt == null) {
			return;
		}
		embed {{{
			(__bridge_transfer SKTexture*)skt;
		}}}
		sktexture = null;
	}

	public SESpriteKitTexture set_image(Image img) {
		if(sktexture != null) {
			clear();
		}
		var qi = img as QuartzBitmapImage;
		if(qi == null) {
			return(null);
		}
		IFDEF("target_osx") {
			var nsimg = qi.as_nsimage();
			if(nsimg == null) {
				return(null);
			}
			ptr skt;
			ptr ndp;
			embed {{{
				NSImage* nsimgx = (__bridge_transfer NSImage*)nsimg;
				SKTexture* texture = [SKTexture textureWithImage:nsimgx];
				skt = (__bridge_retained void*)texture;
			}}}
			sktexture = skt;
		}
		IFDEF("target_ios") {
			var uiimg = qi.as_uiimage();
			if(uiimg == null) {
				return(null);
			}
			ptr skt;
			ptr ndp;
			embed {{{
				UIImage* uiimgx = (__bridge_transfer UIImage*)uiimg;
				SKTexture* texture = [SKTexture textureWithImage:uiimgx];
				skt = (__bridge_retained void*)texture;
			}}}
			sktexture = skt;
		}
		return(this);
	}
}
