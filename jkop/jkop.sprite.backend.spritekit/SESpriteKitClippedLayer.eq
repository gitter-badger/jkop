
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

public class SESpriteKitClippedLayer : SESpriteKitLayer
{
	embed {{{
		#import <SpriteKit/SpriteKit.h>
	}}}

	public void create_layer_node(double width, double height) {
		ptr ndp;
		var parent = get_parent();
		embed {{{
			SKNode* pnode = (__bridge SKNode*)parent;
			SKCropNode* nd = [[SKCropNode alloc] init];
			SKSpriteNode* mask = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(width, height)];
			// The anchor point is x=0, y=1 and this works on both iOS and OSX, but I really don't know why! Apple engineers are crazy.
			mask.anchorPoint = CGPointMake(0,1);
			nd.maskNode = mask;
			ndp = (__bridge_retained void*)nd;
			[pnode addChild:nd];
		}}}
		set_node(ndp);
	}
}
