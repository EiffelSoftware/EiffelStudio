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
			make,
			x_position,
			y_position,
			screen_x,
			screen_y
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

	screen_x, x_position: INTEGER is
			-- Horizontal position of `Current' on screen.
		local
			a_x: INTEGER
		do
				--| The following piece of code works fine with kwn (RH7.1 KDE2.1)
				--| It should be test with other window managers
			C.gdk_window_get_root_origin (
				C.gtk_widget_struct_window (c_object),
				$a_x,
				NULL
			)
			Result := a_x
		end

	screen_y, y_position: INTEGER is
			-- Vertical position of `Current' on screen.
		local
			a_y: INTEGER
		do
				--| The following piece of code works fine with kwn (RH7.1 KDE2.1)
				--| It should be test with other window managers
			C.gdk_window_get_root_origin (
				C.gtk_widget_struct_window (c_object),
				NULL,
				$a_y
			)
			Result := a_y
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

			C.gdk_window_set_icon (C.gtk_widget_struct_window (c_object), NULL, pixmap_imp.drawable, pixmap_imp.mask)
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

