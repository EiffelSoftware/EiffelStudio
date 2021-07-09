note
	description: "[
			Externals for GDK X11 (Xorg) ...
			WARNING: Not supported on Wayland
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GDK_X11

feature -- XWindows

	frozen gdk_x11_display_error_trap_pop (display: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_x11_display_error_trap_pop ((GdkDisplay *)$display)"
		end

	frozen gdk_x11_display_error_trap_push (display: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_x11_display_error_trap_push ((GdkDisplay *)$display)"
		end

feature -- Gdk11

	gdk_x11_window_get_xid (window: POINTER): POINTER
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
	 			 #ifdef GDK_WINDOWING_X11 
		 			return (EIF_POINTER) gdk_x11_window_get_xid ((GdkWindow *)$window);
		 		 #endif
	 		]"
	 	end

	create_gc (window: POINTER): POINTER
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
	 		    #ifdef GDK_WINDOWING_X11 
						/* Declarations */ 			                                     
					GC gc;									/* handle of newly created GC.  */
	  				unsigned long valuemask = 0;			/* which values in 'values' to  */
		 			Window win =  gdk_x11_window_get_xid ((GdkWindow *)$window);
		 			Display* display = GDK_SCREEN_XDISPLAY(gdk_window_get_screen ((GdkWindow *)$window));
	  					/* Define properties/values for the GC.  */
	  				XGCValues values;						/* initial values for the GC.   */
	  				unsigned int line_width = 1;			/* line width for the GC.       */
	  				int line_style = LineSolid;				/* style for lines drawing and  */
	  				int cap_style = CapButt;				/* style of the line's edje and */
					int join_style = JoinBevel;				/* joined lines.		*/
					values.function = GXcopy;               /* src */
					values.subwindow_mode = ClipByChildren; /* GCSubwindowMode */
					values.line_width = line_width;
	 				values.fill_style = FillSolid;
			 		values.arc_mode = ArcPieSlice;
	  				values.graphics_exposures = False;
	  				valuemask = GCFunction | GCFillStyle | GCArcMode | GCSubwindowMode | GCGraphicsExposures;
	  					/* Create the GC object */
	  				gc = XCreateGC(display, win, valuemask, &values);
					if (gc < 0) {
						fprintf(stderr, "XCreateGC: \n");
					}
				  	return gc;
				 #endif
	 		]"
	 	end

	 set_line_attributes_to_solid_style (a_drawable: POINTER; gc: POINTER; a_line_width: INTEGER)
	 	do
	 		x_set_line_attributes (x_display (a_drawable), gc, a_line_width, x_style_line_solid, x_style_cap_butt, x_style_join_bevel)
	 	ensure
	 		instance_free: class
	 	end

	set_line_attributes_to_dashed_style (a_drawable: POINTER; gc: POINTER; a_line_width: INTEGER)
		local
			l_display: POINTER
			mem: INTEGER_16
	 	do
	 		l_display := x_display (a_drawable)

			mem := {INTEGER_16} 3 | ({INTEGER_16} 3 |<< {PLATFORM}.integer_8_bits)
	 		x_set_dashes (l_display, gc, 0, $mem, 2)
	 		x_set_line_attributes (l_display, gc, a_line_width, x_style_line_on_off_dash, x_style_cap_butt, x_style_join_bevel)
	 	ensure
	 		instance_free: class
	 	end

	 flush_drawable (a_drawable: POINTER)
	 	local
	 		d: like x_display
	 	do
	 		d := x_display (a_drawable)
	 		x_flush (d)
	 	ensure
	 		instance_free: class
	 	end

feature -- X primitives

	 x_display (a_drawable: POINTER): POINTER
		external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			return (EIF_POINTER) GDK_SCREEN_XDISPLAY(gdk_window_get_screen ((GdkWindow *)$a_drawable));
				#endif
			]"
		end

	 x_window (a_drawable: POINTER): POINTER
		external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			return (EIF_POINTER) gdk_x11_window_get_xid ((GdkWindow *) $a_drawable);
				#endif
			]"
		end

	 x_set_function (a_display: POINTER; gc: POINTER; a_fct: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 		XSetFunction((Display*) $a_display, (GC) $gc, (int) $a_fct);
		 		#endif
			]"
		end

	x_set_subwindow_mode (a_display: POINTER; gc: POINTER; a_mode: INTEGER)
			-- display	Specifies the connection to the X server.
			-- gc	Specifies the GC.
			-- subwindow_mode	Specifies the subwindow mode. You can pass ClipByChildren or IncludeInferiors.
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 		XSetSubwindowMode((Display *)$a_display, (GC)$gc, (int)$a_mode);
		 		#endif
			]"
		end

	x_set_line_attributes (a_display: POINTER; gc: POINTER; a_line_width, a_line_style, a_cap_style, a_join_style: INTEGER)
			-- a_display 		Specifies the connection to the X server.
			-- gc 				Specifies the GC.
			-- a_line_width 	Specifies the line-width you want to set for the specified GC.
			-- a_line_style 	Specifies the line-style you want to set for the specified GC.
			--					You can pass LineSolid, LineOnOffDash, or LineDoubleDash.
			-- a_cap_style 		Specifies the line-style and cap-style you want to set for the specified GC.
			--					You can pass CapNotLast, CapButt, CapRound, or CapProjecting.
			-- a_join_style 	Specifies the line join-style you want to set for the specified GC.
			--					You can pass JoinMiter, JoinRound, or JoinBevel. 			
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 		XSetLineAttributes((Display*) $a_display, (GC) $gc, 
		 			(unsigned int) $a_line_width,
      				(int) $a_line_style, (int) $a_cap_style, (int) $a_join_style);
		 		#endif
			]"
		end

	 x_set_dashes (a_display: POINTER; gc: POINTER; a_dash_offset: INTEGER; a_dash_list: POINTER; a_dash_list_count: INTEGER)
		external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			XSetDashes ((Display*) $a_display, (GC) $gc, (int) $a_dash_offset, (char*) $a_dash_list, (int) $a_dash_list_count);
				#endif
			]"
		end

	 x_set_fill_style (a_display: POINTER; gc: POINTER; a_fill_style: INTEGER)
			-- display		Specifies the connection to the X server.
			-- gc			Specifies the GC.
			-- fill_style	Specifies the fill-style you want to set for the specified GC. You can pass FillSolid, FillTiled, FillStippled, or FillOpaqueStippled.

	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 		XSetFillStyle((Display*)$a_display, (GC) $gc, (int)$a_fill_style);	
		 		#endif
			]"
		end

	 x_free_gc (a_display: POINTER; gc: POINTER)
		external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 		XFreeGC((Display*)$a_display, (GC)$gc);
				#endif
			]"
		end

	 x_flush (a_display: POINTER)
		external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			XFlush((Display*) $a_display);
				#endif
			]"
		end

feature -- X fill style

	x_fill_solid: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return FillSolid;
			#endif
			]"
		end

	x_fill_tiled: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return FillTiled;
			#endif
			]"
		end

	x_fill_stippled: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return FillStippled;
			#endif
			]"
		end

	x_fill_opaque_stippled: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return FillOpaqueStippled;
			#endif
			]"
		end

feature -- X style

	x_style_line_double_dash: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return LineDoubleDash;
			#endif
			]"

		end

	x_style_line_on_off_dash: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return LineOnOffDash;
			#endif
			]"
		end

	x_style_line_solid: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return LineSolid;
			#endif
			]"
		end

	x_style_cap_butt: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return CapButt;
			#endif
			]"
		end

	x_style_join_bevel: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return JoinBevel;
			#endif
			]"
		end

feature -- X subwindow modes

	x_subwindow_mode_clip_by_children: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11 
			return ClipByChildren;
			#endif
			]"
		end

	x_subwindow_mode_include_inferiors: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11 
			return IncludeInferiors;
			#endif
			]"
		end

feature -- X Background Foreground Color

	set_drawable_background (a_drawable: POINTER; gc: POINTER; red, green, blue: INTEGER)
		local
			d: like x_display
		do
			d := x_display (a_drawable)
			x_set_background (d, gc, red, green, blue)
		ensure
			instance_free: class
		end

	set_drawable_foreground (a_drawable: POINTER; gc: POINTER; red, green, blue: INTEGER)
		local
			d: like x_display
		do
			d := x_display (a_drawable)
			x_set_foreground (d, gc, red, green, blue)
		ensure
			instance_free: class
		end

	x_set_background (a_display: POINTER; gc: POINTER; red, green, blue: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 		XColor color;
		 		/* */
		 		Colormap cmap =  DefaultColormap((Display*) $a_display, DefaultScreen((Display*) $a_display) );
		 		color.red =   $red;
				color.green = $green;
				color.blue =  $blue;
				color.flags = DoRed | DoGreen | DoBlue;
				/* */
				XAllocColor((Display*) $a_display, cmap, &color);
				XSetBackground((Display*) $a_display, (GC) $gc, (unsigned long) color.pixel);
		 		#endif
			]"
		end

	x_set_foreground (a_display: POINTER; gc: POINTER; red, green, blue: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 		XColor color;
		 		Colormap cmap = DefaultColormap((Display*) $a_display, DefaultScreen((Display*) $a_display));
		 		color.red =   $red;
				color.green = $green;
				color.blue =  $blue;
				color.flags = DoRed | DoGreen | DoBlue;
				XAllocColor((Display*) $a_display, cmap, &color);
		 		XSetForeground((Display*) $a_display, (GC) $gc, (unsigned long) color.pixel);
		 		#endif
			]"
		end

feature -- X functions

	x_function_GXclear: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXclear;
			#endif
			]"
		end

	x_function_GXand: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXand;
			#endif
			]"
		end

	x_function_GXandReverse: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXandReverse;
			#endif
			]"
		end

	x_function_GXcopy: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXcopy;
			#endif
			]"
		end

	x_function_GXandInverted: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXandInverted;
			#endif
			]"
		end

	x_function_GXnoop: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXnoop;
			#endif
			]"
		end

	x_function_GXxor: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXxor;
			#endif
			]"
		end

	x_function_GXor: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXor;
			#endif
			]"
		end

	x_function_GXnor: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXnor;
			#endif
			]"
		end

	x_function_GXequiv: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXequiv;
			#endif
			]"
		end

	x_function_GXinvert: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXinvert;
			#endif
			]"
		end

	x_function_GXorReverse: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXorReverse;
			#endif
			]"
		end

	x_function_GXcopyInverted: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXcopyInverted;
			#endif
			]"
		end

	x_function_GXorInverted: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXorInverted;
			#endif
			]"
		end

	x_function_GXnand: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXnand;
			#endif
			]"
		end

	x_function_GXset: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			#ifdef GDK_WINDOWING_X11
			return GXset;
			#endif
			]"
		end

feature -- Drawing operation

	draw_line (a_x_window, a_display: POINTER; gc: POINTER; x1, y1, x2, y2: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			Window win = (Window) $a_x_window;
		 			/*
		 			 * TODO check Gdkgc-x11 _gdk_x11_gc_flush implementation 
		 			 * that's used before
		 			 * for example gdk_x11_draw_segments the usage of
		 			 * GDK_GC_GET_XGC (gc),
		 			 * https://github.com/coapp-packages/gtk/blob/master/gdk/x11/gdkdrawable-x11.c
		 			 */
						 				
	 				XDrawLine((Display*) $a_display, win, $gc, $x1, $y1, $x2, $y2);
	 				
				#endif
			]"
		end

	draw_point (a_drawable, a_display: POINTER; gc: POINTER; x, y: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			XDrawPoint ((Display*) $a_display, (Drawable) $a_drawable, $gc, $x, $y);
				#endif
			]"
		end

	draw_arc (a_x_window, a_display: POINTER; gc: POINTER; filled: BOOLEAN; x, y, width, height, angle1, angle2: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			Window win = (Window) $a_x_window;
					if ($width < 0 || $height < 0)
					{
						gint real_width;
						gint real_height;
					    real_width = gdk_window_get_width (win); 
					    real_height = gdk_window_get_height (win);

						if ($width < 0)
							$width = real_width;
						if ($height < 0)
							$height = real_height;
					}

					if ($filled)
					    XFillArc ((Display*) $a_display, win, $gc, $x, $y, $width, $height, $angle1, $angle2);
					else
					    XDrawArc ((Display*) $a_display, win, $gc, $x, $y, $width, $height, $angle1, $angle2);	
	
				#endif
			]"
		end


	draw_rectangle (a_x_window, a_display: POINTER; gc: POINTER; filled: BOOLEAN; x, y, width, height: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			Window win = (Window) $a_x_window;
					if ($width < 0 || $height < 0)
					{
						gint real_width;
						gint real_height;
					    real_width = gdk_window_get_width (win); 
					    real_height = gdk_window_get_height (win);

						if ($width < 0)
							$width = real_width;
						if ($height < 0)
							$height = real_height;
					}

					if ($filled)
					    XFillRectangle ((Display*) $a_display, win, $gc, $x, $y, $width, $height);
					else
					    XDrawRectangle ((Display*) $a_display, win, $gc, $x, $y, $width, $height);

				#endif
			]"
		end

	draw_lines (a_x_window, a_display: POINTER; gc: POINTER; points: POINTER; npoints: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
					Window win = (Window) $a_x_window;
					gint i;
					XPoint *tmp_points = g_new (XPoint, $npoints);

					for (i=0; i<$npoints; i++)
				    {
				      tmp_points[i].x = ((GdkPoint *)$points)[i].x;
				      tmp_points[i].y = ((GdkPoint *)$points)[i].y;
				    }
				    		 			
					XDrawLines ((Display*) $a_display, win, $gc, tmp_points, $npoints, CoordModeOrigin);
					g_free (tmp_points);
				#endif
			]"
		end

	draw_polygon (a_x_window, a_display: POINTER; gc: POINTER; filled: BOOLEAN; points: POINTER; npoints: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			Window win = (Window) $a_x_window;
					XPoint *tmp_points;
 					gint tmp_npoints, i;


					if (!($filled) &&
				      ( ((GdkPoint *)$points)[0].x != ((GdkPoint *)$points)[$npoints-1].x || ((GdkPoint *)$points)[0].y != ((GdkPoint *)$points)[$npoints-1].y))
				    {
				      tmp_npoints = $npoints + 1;
				      tmp_points = g_new (XPoint, tmp_npoints);
				      tmp_points[$npoints].x = ((GdkPoint *)$points)[0].x;
				      tmp_points[$npoints].y = ((GdkPoint *)$points)[0].y;
				    }
				  	else
				    {
				      tmp_npoints = $npoints;
				      tmp_points = g_new (XPoint, tmp_npoints);
				    }

				  	for (i=0; i<$npoints; i++)
				    {
				      tmp_points[i].x = ((GdkPoint *)$points)[i].x;
				      tmp_points[i].y = ((GdkPoint *)$points)[i].y;
				    }


				    if ($filled)
						XFillPolygon ((Display*) $a_display, win, $gc, tmp_points, tmp_npoints, Complex, CoordModeOrigin);					
					else	
						XDrawLines ((Display*) $a_display, win, $gc, tmp_points, tmp_npoints, CoordModeOrigin);
						
					g_free (tmp_points);
				#endif
			]"
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
