--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision window, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_I
		redefine
			interface
		end
		
	EV_WINDOW_IMP
		undefine
			set_default_colors,
			has_parent
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			--FIXME comment
		do
			-- Create the window
			base_make (an_interface)
			set_c_object (C.gtk_window_new (C.Gtk_window_toplevel_enum))

			-- set the events to be handled by the window
			-- FIXME probably obsolete?? c_gtk_widget_set_all_events (c_object)

			set_title("")
			-- set title also realizes the window.

			accel_group := C.gtk_accel_group_new
			C.gtk_window_add_accel_group (c_object, accel_group)
		end

feature {NONE} -- Accelerators

	accel_group: POINTER
			-- Pointer to GtkAccelGroup struct.

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			acc_imp.set_accel_group (accel_group)
			io.put_string ("Accelerator " + acc_imp.name +
				" added to window: " + title + ".%N")
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			acc_imp.set_accel_group (Default_pointer)
			io.put_string ("Accelerator " + acc_imp.name +
				" removed from window: " + title + ".%N")
		end

feature  -- Access

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		do
			if icon_name_holder /= Void then
				Result := icon_name_holder
			else
				Result := title
			end
		end

	icon_name_holder: STRING
			-- Name holder for applications icon name

--| FIXME
--| Christophe, PR-2186
--| This is the sole non crashing icon-related feature.
--| Althrough they are not critical at all for developping, they should be
--| implemented for releasing V2-based applications.

        icon_mask: EV_PIXMAP
                        -- Bitmap that could be used by window manager
                        -- to clip `icon_pixmap' bitmap to make the
                        -- icon nonrectangular 

        icon_pixmap: EV_PIXMAP
                        -- Bitmap that could be used by the window manager
                        -- as the application's icon

	
feature -- Status report

        is_iconic_state: BOOLEAN is
                        -- Does application start in iconic state?
		do
			check
                                not_yet_implemented: False
                        end
                end

 	is_minimized: BOOLEAN is
			-- Is the window minimized (iconic state)?
		do
			Result := True	
		end

	is_maximized: BOOLEAN is
			-- Is the window maximized (take the all screen).
		do
			check
				not_yet_implemented: False
            		end	
		end

feature -- Status setting

	set_iconic_state is
                        -- Set start state of the application to be iconic.
		do
			check
				not_yet_implemented: False
            		end	
        	end

	set_normal_state is
                        -- Set start state of the application to be normal.
		do
			check
				not_yet_implemented: False
            		end
        	end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		do
			check
				to_be_implemented: False
			end
		end

	raise is
			-- Raise a window. ie: put the window on the front
			-- of the screen.
		do
			C.gdk_window_raise (C.gtk_widget_struct_window(c_object))
		end

	lower is
			-- Lower a window. ie: put the window on the back
			-- of the screen.
		do
			C.gdk_window_lower (C.gtk_widget_struct_window(c_object))
		end

	minimize is
			-- Minimize the window.
		do
			check
				to_be_implemented: False
			end
		end

	maximize is
			-- Minimize the window.
		do
			check
				to_be_implemented: False
			end
		end

	restore is
			-- Restore the window when it is minimized or
			-- maximized. Do nothing otherwise.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Element change

        set_icon_name (new_name: STRING) is
                        -- Set `icon_name' to `new_name'.
		local
			gdkwin: POINTER
		do
--FIXME			c_gtk_window_set_icon_name(c_object, eiffel_to_c (new_name))
			icon_name_holder := new_name
                end

	set_icon_mask (mask: EV_PIXMAP) is
			-- Set `icon_mask' to `mask'.
		local
			mask_imp: EV_PIXMAP_IMP
			icon_pixmap_imp: EV_PIXMAP_IMP
		do
			icon_mask := mask
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
				--c_gtk_window_set_icon (c_object, icon_pixmap_imp.c_object, icon_pixmap_imp.create_window, mask_imp.c_object)
			end
                end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Set `icon_pixmap' to `pixmap'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			mask_imp: EV_PIXMAP_IMP
			icon_window: EV_WINDOW
			icon_window_imp: EV_WINDOW_IMP
		do
			icon_pixmap := pixmap
			pixmap_imp ?= pixmap.implementation
			check
				icon_implementation_exists: pixmap_imp /= Void
			end

			create icon_window
			
			icon_window.set_size (pixmap.width, pixmap.height)
			io.putstring (pixmap.height.out + "%N")
			icon_window.extend (pixmap)
		
			
			icon_window_imp ?= icon_window.implementation			
			C.gtk_widget_shape_combine_mask (icon_window_imp.c_object, pixmap_imp.mask, 0, 0)
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
				--	default_pointer, default_pointer)

			end
	end

	gdkpix, gdkmask : POINTER

feature {EV_ANY_I} -- Implementation

	interface: EV_TITLED_WINDOW

		-- FIXME move this into Eiffel
	c_gtk_window_set_icon (window, pixmap, pixwind, maskpix: POINTER) is
		external
			"C (GtkWidget *, GtkPixmap *, GtkWidget *, GtkPixmap *) | %"gtk_eiffel.h%""
		end

end -- class EV_TITLED_WINDOW_IMP

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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
