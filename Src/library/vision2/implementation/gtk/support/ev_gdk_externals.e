--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "External C routines for accessing gdk";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class EV_GDK_EXTERNALS


--feature {NONE} -- GDK extenals for the fonts

--	gdk_font_load (name: POINTER): POINTER is
--		external
--			"C | <gdk/gdk.h>"
--		end

--	gdk_string_width (font, str: POINTER): INTEGER is
--		external
--			"C | <gdk/gdk.h>"
--		end

--	c_gdk_font_ascent (font: POINTER): INTEGER is
--		external
--			"C [macro %"gdk_eiffel.h%"]"
--		end

--	c_gdk_font_descent  (font: POINTER): INTEGER is
--		external
--			"C [macro %"gdk_eiffel.h%"]"
--		end

feature -- GTK macros for casting types
	
	-- Events
	
 	c_gdk_event_type (event: POINTER): INTEGER is
 		external 
 			"C [macro %"gdk_eiffel.h%"]"
 		end	

	gdk_root_parent: POINTER is
		external
			"C [macro <gdk/gdkx.h>]"
		alias
			"GDK_ROOT_PARENT()"
		end
	
	-- Button, Motion
	c_gdk_event_x  (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end
	
	c_gdk_event_y (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end

	c_gdk_event_absolute_x (p: POINTER): INTEGER is	
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end

	c_gdk_event_absolute_y (p: POINTER): INTEGER is	
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end

	c_gdk_event_state (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	-- Button
	c_gdk_event_button (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	-- Key
	c_gdk_event_keyval (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	

	c_gdk_event_length (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_string (p: POINTER): POINTER is
		external 
			"C [macro %"gdk_eiffel.h%"] (GdkEventKey *): EIF_POINTER"
		end		
	
	-- Expose
	c_gdk_event_rectangle_x (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_rectangle_y (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_rectangle_width (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_rectangle_height (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
end

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:29  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.8.2.2.6  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.6.8.2.2.5  2000/01/27 19:29:33  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.8.2.2.4  1999/12/15 00:26:03  oconnor
--| removed exprort restrictions
--|
--| Revision 1.6.8.2.2.3  1999/12/15 00:02:50  oconnor
--| added gdk_root_parent
--|
--| Revision 1.6.8.2.2.2  1999/12/04 18:59:13  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.6.8.2.2.1  1999/11/24 17:29:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.6.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
