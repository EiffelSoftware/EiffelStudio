--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "External C functions for accessing gtk.%
		% Those are used by containers.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_CONTAINERS_EXTERNALS


feature  -- GTK C functions for general containers

	c_gtk_container_border_width (container: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature  -- GTK C functions for tables

	c_gtk_table_row_spacing (table: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_table_column_spacing (table: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature  -- GTK C functions for boxes

	c_gtk_box_homogeneous (box: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_box_spacing (box: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature  -- GTK C functions for notebooks

	c_gtk_notebook_tab_position (notebook: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature  -- GTK C functions for split area

	c_gtk_paned_child1 (paned: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_paned_child2 (paned: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_paned_child1_size (paned: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature  -- GTK C functions for frames

	c_gtk_frame_text (frame: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

end -- class EV_GTK_CONTAINERS_EXTERNALS

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.23  2000/02/14 11:40:29  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.2.1.2.6  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.22.2.1.2.5  2000/01/27 19:29:34  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.2.1.2.4  1999/12/04 18:59:14  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.22.2.1.2.3  1999/12/01 16:58:58  oconnor
--| removed old externals, now in EV_C_GTK
--|
--| Revision 1.22.2.1.2.2  1999/12/01 16:09:21  oconnor
--| rip manualy created externals
--|
--| Revision 1.22.2.1.2.1  1999/11/24 17:29:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.21.2.3  1999/11/17 01:50:26  oconnor
--| removed externals that are genereated by GOTE anyway
--|
--| Revision 1.21.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
