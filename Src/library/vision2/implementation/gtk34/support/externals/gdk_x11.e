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
					values.function = GXcopy;               /* Operation src Or dst */
					values.subwindow_mode = IncludeInferiors; /* GCSubwindowMode */
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
						/* define the style of lines that will be drawn using this GC. */
					XSetLineAttributes(display, gc, line_width, line_style, cap_style, join_style);
						/* define the fill style for the GC. to be 'solid filling'. */
					XSetFillStyle(display, gc, FillSolid);
					int mem = 771;
					XSetDashes (display, gc, 0, (char *)&mem, 2);				
				  	return gc;
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

feature -- X style

	x_style_line_double_dash: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"LineDoubleDash"
		end

	x_style_line_on_off_dash: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"LineOnOffDash"
		end

	x_style_line_solid: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"LineSolid"
		end

	x_style_cap_butt: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"CapButt"
		end

	x_style_join_bevel: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"JoinBevel"
		end

feature -- X functions

	x_function_GXclear: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXclear"
		end

	x_function_GXand: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXand"
		end

	x_function_GXandReverse: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXandReverse"
		end

	x_function_GXcopy: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXcopy"
		end

	x_function_GXandInverted: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXandInverted"
		end

	x_function_GXnoop: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXnoop"
		end

	x_function_GXxor: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXxor"
		end

	x_function_GXor: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXor"
		end

	x_function_GXnor: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXnor"
		end

	x_function_GXequiv: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXequiv"
		end

	x_function_GXinvert: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXinvert"
		end

	x_function_GXorReverse: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXorReverse"
		end

	x_function_GXcopyInverted: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXcopyInverted"
		end

	x_function_GXorInverted: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXorInverted"
		end

	x_function_GXnand: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXnand"
		end

	x_function_GXset: INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GXset"
		end

feature -- Drawing operation

	draw_line (window: POINTER; gc: POINTER; x1, y1, x2, y2: INTEGER)
	 	external
	 		"C inline use <ev_gtk.h>"
	 	alias
	 		"[
		 		#ifdef GDK_WINDOWING_X11 
		 			Window win = gdk_x11_window_get_xid ((GdkWindow *) $window);
		 			
		 			/*
		 			 * TODO check Gdkgc-x11 _gdk_x11_gc_flush implementation 
		 			 * that's used before
		 			 * for example gdk_x11_draw_segments the usage of
		 			 * GDK_GC_GET_XGC (gc),
		 			 * https://github.com/coapp-packages/gtk/blob/master/gdk/x11/gdkdrawable-x11.c
		 			 */
		 			
		 			Display* display = GDK_SCREEN_XDISPLAY(gdk_window_get_screen ((GdkWindow *)$window));
		 			
		 			XClearWindow(display, win);
						 				
	 				XDrawLine(display, win, $gc, $x1, $y1, $x2, $y2);
	 				XFlush(display);
	 				
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
