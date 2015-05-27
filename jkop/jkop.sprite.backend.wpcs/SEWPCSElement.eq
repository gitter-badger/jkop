
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

public class SEWPCSElement : SEElement
{
	public SEWPCSElement() {
		embed "cs" {{{
			canvas = new System.Windows.Controls.Canvas() { Background = null };
		}}}
	}

	embed "cs" {{{
		System.Windows.Media.ScaleTransform scale = null;
		System.Windows.Media.RotateTransform rotate = null;
		System.Windows.Controls.Canvas canvas;
			
		public System.Windows.Controls.Canvas BackendCanvas
		{
			get {
				return(canvas);
			}
		}
	}}}

	property SEResourceCache rsc;
	int x;
	int y;

	public double get_x() {
		return(x);
	}

	public double get_y() {
		return(y);
	}

	public double get_width() {
		double v;
		embed "cs" {{{
			v = canvas.ActualWidth;
		}}}
		return(v);
	}

	public double get_height() {
		double v;
		embed "cs" {{{
			v = canvas.ActualHeight;
		}}}
		return(v);
	}

	public void move(double x, double y) {
		if(this.x == x && this.y == y) {
			return;
		}
		this.x = x;
		this.y = y;
		embed "cs" {{{
			System.Windows.Controls.Canvas.SetLeft(canvas, x);
			System.Windows.Controls.Canvas.SetTop(canvas, y);
		}}}
	}
		
	public void resize_backend(double w, double h) {
		embed "cs" {{{
			if(w > 0 && h > 0) {
				canvas.Width = w;
				canvas.Height = h;
			}
		}}}
	}

	public void set_scale(double s) {
		embed "cs" {{{
			if(canvas.RenderTransform is System.Windows.Media.TransformGroup == false) {
				canvas.RenderTransform = new System.Windows.Media.TransformGroup();
			}
			if(scale == null) {
				scale = new System.Windows.Media.ScaleTransform() { ScaleX = s, ScaleY = s, CenterX = canvas.ActualWidth/2, CenterY = canvas.ActualHeight/2  };
				((System.Windows.Media.TransformGroup)canvas.RenderTransform).Children.Add(scale);
			}
			else {
				scale.ScaleX = s;
				scale.ScaleY = s;
			}
		}}}
	}

	double _alpha = 1.0;

	public void set_alpha(double a) {
		embed "cs" {{{
			if(a != _alpha) {
				canvas.Opacity = a;
			}
		}}}
		_alpha = a;
	}

	double _rotation = 0.0;

	public void set_rotation(double ra) {
		if(_rotation == ra) {
			return;
		}
		_rotation = ra;
		double aa = ra  * 180 / eq.api.MathConstant.M_PI;
		embed "cs" {{{
			if(canvas.RenderTransform is System.Windows.Media.TransformGroup == false) {
				canvas.RenderTransform = new System.Windows.Media.TransformGroup();
			}
			if(rotate == null) {
				rotate = new System.Windows.Media.RotateTransform() { Angle = aa, CenterX = canvas.ActualWidth/2, CenterY = canvas.ActualHeight/2 };
				((System.Windows.Media.TransformGroup)canvas.RenderTransform).Children.Add(rotate);
			}
			else {
				rotate.Angle = aa;
				rotate.CenterX = canvas.ActualWidth/2;
				rotate.CenterY = canvas.ActualHeight/2;
			}
		}}}
	}

	public double get_scale() {
		embed "cs" {{{
			if(scale != null) {
				return(scale.ScaleX);
			}
		}}}
		return(1.0);
	}

	public double get_alpha() {
		return(_alpha);
	}
		
	public double get_rotation() {
		return(_rotation);
	}

	public void remove_from_container() {
		embed "cs" {{{
			var p = canvas.Parent as System.Windows.Controls.Canvas;
			if(p != null) {
				p.Children.Remove(BackendCanvas);
			}
		}}}
	}
}
