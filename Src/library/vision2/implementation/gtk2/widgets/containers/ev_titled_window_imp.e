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
			propagate_background_color,
			lock_update,
			unlock_update
		redefine
			interface
		end
		
	EV_WINDOW_IMP
		redefine
			interface,
			make,
			has_wm_decorations,
			is_displayed
		end
		
	EV_TITLED_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create the titled window.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_window_new (feature {EV_GTK_EXTERNALS}.gtk_window_toplevel_enum))
		end
		
feature {NONE} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			acc_imp.add_accel (accel_group)
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			acc_imp.remove_accel (accel_group)
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
--			Result := feature {EV_GTK_EXTERNALS}.c_gdk_window_is_iconified (
--				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object)
--			)
		end

	is_maximized: BOOLEAN is
			-- Is displayed at maximum size?
		do
			--Result := old_geometry /= Void
		end

	is_displayed: BOOLEAN is
			-- Is 'Current' displayed on screen?
		do
			Result := Precursor {EV_WINDOW_IMP} and not is_minimized
		end

feature -- Status setting

	raise is
			-- Request that window be displayed above all other windows.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_present (c_object)
		end

	lower is
			-- Request that window be displayed below all other windows.
		do
			feature {EV_GTK_EXTERNALS}.gdk_window_lower (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

	minimize is
			-- Display iconified/minimised.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_iconify (c_object)
		end

	maximize is
			-- Display at maximum size.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_maximize (c_object)
		end

	restore is
			-- Restore to original position when minimized or maximized.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_deiconify (c_object)			
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING) is
			-- Assign `an_icon_name' to `icon_name'.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (an_icon_name)
			feature {EV_GTK_EXTERNALS}.gdk_window_set_icon_name (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_cs.item)
			icon_name_holder := an_icon_name.twin
		end

	set_icon_pixmap (an_icon: EV_PIXMAP) is
			-- Assign `an_icon' to `icon'.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create icon_pixmap
			icon_pixmap.copy (an_icon)
			pixmap_imp ?= icon_pixmap.implementation
			check
				icon_implementation_exists: pixmap_imp /= Void
			end

			feature {EV_GTK_EXTERNALS}.gdk_window_set_icon (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL, pixmap_imp.drawable, pixmap_imp.mask)
		end
		
feature {NONE} -- Implementation

	has_wm_decorations: BOOLEAN is
			-- Does the current window object have WM decorations?
		do
			Result := True
		end

feature {EV_ANY_I} -- Implementation

	icon_name_holder: STRING
			-- Name holder for applications icon name

	interface: EV_TITLED_WINDOW

end -- class EV_TITLED_WINDOW_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

