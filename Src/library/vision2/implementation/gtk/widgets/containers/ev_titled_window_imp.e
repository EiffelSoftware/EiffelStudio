indexing
	description:
		"Eiffel Vision titled window. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end
		
	EV_WINDOW_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create the titled window.
		do
			base_make (an_interface)
			set_c_object (C.gtk_window_new (C.Gtk_window_toplevel_enum))
			-- `set_title' causes the window to be realized.
			set_title("")
			accel_group := C.gtk_accel_group_new
			C.gtk_window_add_accel_group (c_object, accel_group)
		end
		
feature {NONE} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			acc_imp.set_accel_group (accel_group)
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			acc_imp.set_accel_group (NULL)
		end

feature -- Access

	icon_name: STRING is
			-- Alternative name, displayed when window is minimised.
		do
			if icon_name_holder /= Void then
				Result := icon_name_holder
			else
				Result := title
			end
		end 

	icon_pixmap: EV_PIXMAP
			-- Window icon.
	
	icon_mask: EV_PIXMAP
			-- Transparency mask for `icon_pixmap'.

feature -- Status report

	is_minimized: BOOLEAN is
			-- Is displayed iconified/minimised?
		do
			Result := C.c_gdk_window_is_iconified (
				C.gtk_widget_struct_window (c_object)
			)
		end

	is_maximized: BOOLEAN is
			-- Is displayed at maximum size?
		do
			Result := old_geometry /= Void
		end

feature -- Status setting

	raise is
			-- Request that window be displayed above all other windows.
		do
			C.gdk_window_raise (C.gtk_widget_struct_window (c_object))
		end

	lower is
			-- Request that window be displayed below all other windows.
		do
			C.gdk_window_lower (C.gtk_widget_struct_window (c_object))
		end

	minimize is
			-- Display iconified/minimised.
		do
			C.c_gdk_window_iconify (
				C.gtk_widget_struct_window (c_object)
			)
			(create {EV_ENVIRONMENT}).application.process_events
		end

	maximize is
			-- Display at maximum size.
		local
			r: EV_RECTANGLE
		do
			old_geometry := geometry
			create r.make (0, 0, C.gdk_screen_width, C.gdk_screen_height)
			set_geometry (r)
		end

	restore is
			-- Restore to original position when minimized or maximized.
		do
			if is_minimized then
				C.c_gdk_window_deiconify (
					C.gtk_widget_struct_window (c_object)
				)
			elseif is_maximized then
				set_geometry (old_geometry)
			end
			old_geometry := Void
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING) is
			-- Assign `an_icon_name' to `icon_name'.
		do
			C.gdk_window_set_icon_name (
				C.gtk_widget_struct_window (c_object),
					eiffel_to_c (an_icon_name))
			icon_name_holder := an_icon_name
		end

	set_icon_mask (an_icon_mask: EV_PIXMAP) is
			-- Assign `an_icon_mask' to `icon_mask'.
		local
			mask_imp: EV_PIXMAP_IMP
			icon_pixmap_imp: EV_PIXMAP_IMP
		do
			icon_mask := an_icon_mask
			mask_imp ?= icon_mask.implementation
			check
				mask_implementation_exists: mask_imp /= Void
			end

			if icon_pixmap /= Void then
				icon_pixmap_imp ?= icon_pixmap.implementation
				check
					icon_pixmap_implementation_exists: icon_pixmap_imp /= Void
				end
				--| FIXME  No more create_window
				--c_gtk_window_set_icon
				--(c_object, icon_pixmap_imp.c_object,
				--icon_pixmap_imp.create_window, mask_imp.c_object)
			end
                end

	set_icon_pixmap (an_icon: EV_PIXMAP) is
			-- Assign `an_icon' to `icon'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			mask_imp: EV_PIXMAP_IMP
			icon_window: EV_WINDOW
			icon_window_imp: EV_WINDOW_IMP
		do
			create icon_pixmap
			icon_pixmap.copy (an_icon)
			pixmap_imp ?= icon_pixmap.implementation
			check
				icon_implementation_exists: pixmap_imp /= Void
			end

			create icon_window
			icon_window.set_size (icon_pixmap.width, icon_pixmap.height)
			icon_window.extend (icon_pixmap)

			icon_window_imp ?= icon_window.implementation			
			C.gtk_widget_shape_combine_mask (
				icon_window_imp.c_object,
				pixmap_imp.mask,
				0, 0
			)
			--icon_window.show
			if icon_mask /= Void then
				-- A mask has been set.
				mask_imp ?= icon_mask.implementation
				check
					mask_exists: mask_imp /= Void
				end
			else
				-- Retrieve mask from pixmap.
				--C.gdk_window_set_icon (
				--	C.gtk_widget_struct_window (pixmap_imp.c_object),
				--	C.gtk_widget_struct_window (icon_window_imp.c_object),
				--	NULL, NULL)

			end
		end

feature {EV_ANY_I} -- Implementation

	geometry: EV_RECTANGLE is
			-- Extent of window.
		local
			x, y, w, h: INTEGER
		do
			C.gdk_window_get_geometry (
				C.gtk_widget_struct_window (c_object),
				$x, $y, $w, $h, NULL)
				--| `x' and `y' are not working, so:
			C.gdk_window_get_root_origin (
				C.gtk_widget_struct_window (c_object),
				$x, $y)
			create Result.make (x, y, w, h)
		end

	set_geometry (a_rect: EV_RECTANGLE) is
			-- Set `geometry' to `a_rect'.
		do
			C.gdk_window_move_resize (
				C.gtk_widget_struct_window (c_object),
				a_rect.x, a_rect.y,
				a_rect.width, a_rect.height)
		end

	old_geometry: EV_RECTANGLE
			-- Saved metrics when maximized.

	icon_name_holder: STRING
			-- Name holder for applications icon name

	interface: EV_TITLED_WINDOW

end -- class EV_TITLED_WINDOW_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.5  2001/06/22 00:49:01  king
--| Formatting
--|
--| Revision 1.4  2001/06/21 23:43:36  king
--| Removed useless policy setting
--|
--| Revision 1.3  2001/06/21 22:35:04  king
--| Correctly setting policy
--|
--| Revision 1.2  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.3  2001/02/23 17:21:56  king
--| Moved `accel_group' to EV_WINDOW_IMP.
--|
--| Revision 1.1.2.2  2000/10/27 16:54:42  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.1.2.1  2000/10/09 19:37:48  oconnor
--| Moved ev_window_imp.e to ev_titled_window_imp.e
--| Moved ev_untitled_window_imp.e to ev_window_imp.e
--|
--| Revision 1.31.2.10  2000/09/18 18:06:43  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.31.2.9  2000/07/24 21:36:08  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.31.2.8  2000/06/22 02:07:18  oconnor
--| Removed in line creations that may have caused 4.5 to choke.
--|
--| Revision 1.31.2.7  2000/06/12 16:22:57  oconnor
--| removed references to obsolete features
--|
--| Revision 1.31.2.6  2000/05/05 23:21:02  king
--| Removed onscreen printing of the magic 32
--|
--| Revision 1.31.2.5  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.45  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.44  2000/04/04 20:52:30  oconnor
--| formatting
--|
--| Revision 1.43  2000/03/22 23:54:00  brendel
--| Removed io.put_string.
--|
--| Revision 1.42  2000/03/08 20:29:02  brendel
--| Replaced `width' with `height'.
--|
--| Revision 1.41  2000/03/08 02:58:39  brendel
--| Improved implementation.
--|
--| Revision 1.40  2000/03/07 19:25:44  brendel
--| Corrected external call errors
--|
--| Revision 1.39  2000/03/07 18:40:31  brendel
--| Started implementing minimize/is_minimized.
--|
--| Revision 1.38  2000/03/07 02:51:43  brendel
--| Implemented maximize and restore.
--| For is_minimized, is_maximized and minimize we need to call X.
--|
--| Revision 1.37  2000/03/07 01:37:59  brendel
--| Reviewed.
--| is_minimized and is_maximized are now attributes.
--| To be implemented.
--|
--| Revision 1.36  2000/02/24 01:49:32  king
--| Properly indented code
--|
--| Revision 1.35  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.34  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.31.2.3.2.15  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.31.2.3.2.14  2000/01/27 19:29:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.31.2.3.2.13  2000/01/25 22:18:31  brendel
--| Renamed add_acelerator to connect_accelerator.
--| Renamed remove_accelerator to disconnect_accelerator.
--| Connection to list now takes place in interface.
--|
--| Revision 1.31.2.3.2.12  2000/01/25 16:57:26  brendel
--| Implemented handlers for add/remove of accelerators.
--|
--| Revision 1.31.2.3.2.11  2000/01/25 03:21:21  brendel
--| Started implementing accelerators.
--|
--| Revision 1.31.2.3.2.10  1999/12/22 20:20:12  king
--| Removed reference to now defunct create window in icon routines
--|
--| Revision 1.31.2.3.2.9  1999/12/18 02:19:57  king
--| Removed reference to create_window in set_icon_pixmap and set_icon_mask
--|
--| Revision 1.31.2.3.2.8  1999/12/09 18:14:01  oconnor
--| rename widget -> c_object
--|
--| Revision 1.31.2.3.2.7  1999/12/09 02:33:47  oconnor
--| king: added icon handling
--|
--| Revision 1.31.2.3.2.6  1999/12/08 17:42:31  oconnor
--| removed more inherited externals
--|
--| Revision 1.31.2.3.2.5  1999/12/04 18:59:19  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.31.2.3.2.4  1999/12/01 17:37:13  oconnor
--| migrating to new externals
--|
--| Revision 1.31.2.3.2.3  1999/12/01 01:02:33  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.31.2.3.2.2  1999/11/30 23:15:48  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.31.2.3.2.1  1999/11/24 17:29:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.29.2.5  1999/11/23 22:58:30  oconnor
--| added _enum suffix
--|
--| Revision 1.29.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.29.2.3  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
