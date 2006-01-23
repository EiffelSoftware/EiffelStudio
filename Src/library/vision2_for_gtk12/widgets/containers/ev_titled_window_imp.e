indexing
	description:
		"Eiffel Vision titled window. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			set_c_object ({EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_EXTERNALS}.gtk_window_toplevel_enum))
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
			Result := {EV_GTK_EXTERNALS}.c_gdk_window_is_iconified (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object)
			)
		end

	is_maximized: BOOLEAN is
			-- Is displayed at maximum size?
		do
			Result := old_geometry /= Void
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
			{EV_GTK_EXTERNALS}.gdk_window_raise ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

	lower is
			-- Request that window be displayed below all other windows.
		do
			{EV_GTK_EXTERNALS}.gdk_window_lower ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

	minimize is
			-- Display iconified/minimised.
		do
			{EV_GTK_EXTERNALS}.c_gdk_window_iconify ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
			App_implementation.process_events
		end

	maximize is
			-- Display at maximum size.
		local
			r: EV_RECTANGLE
		do
			old_geometry := geometry
			create r.make (0, 0, {EV_GTK_EXTERNALS}.gdk_screen_width, {EV_GTK_EXTERNALS}.gdk_screen_height)
			set_geometry (r)
		end

	restore is
			-- Restore to original position when minimized or maximized.
		do
			if is_minimized then
				{EV_GTK_EXTERNALS}.c_gdk_window_deiconify (
					{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object)
				)
				App_implementation.process_events
			elseif is_maximized then
				set_geometry (old_geometry)
			end
			old_geometry := Void
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING) is
			-- Assign `an_icon_name' to `icon_name'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := an_icon_name
			{EV_GTK_EXTERNALS}.gdk_window_set_icon_name (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_cs.item)
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

			{EV_GTK_EXTERNALS}.gdk_window_set_icon ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL, pixmap_imp.drawable, pixmap_imp.mask)
		end
		
feature {NONE} -- Implementation

	has_wm_decorations: BOOLEAN is
			-- Does the current window object have WM decorations?
		do
			Result := True
		end

feature {EV_ANY_I} -- Implementation

	geometry: EV_RECTANGLE is
			-- Extent of window.
		local
			x, y, w, h: INTEGER
		do
			{EV_GTK_EXTERNALS}.gdk_window_get_geometry (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				$x, $y, $w, $h, NULL)
				--| `x' and `y' are not working, so:
			{EV_GTK_EXTERNALS}.gdk_window_get_root_origin (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				$x, $y)
			create Result.make (x, y, w, h)
		end

	set_geometry (a_rect: EV_RECTANGLE) is
			-- Set `geometry' to `a_rect'.
		do
			{EV_GTK_EXTERNALS}.gdk_window_move_resize (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				a_rect.x, a_rect.y,
				a_rect.width, a_rect.height)
			--| FIXME Window geometry doesn't take border or title bar in to account.
		end

	old_geometry: EV_RECTANGLE
			-- Saved metrics when maximized.

	icon_name_holder: STRING
			-- Name holder for applications icon name

	interface: EV_TITLED_WINDOW;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TITLED_WINDOW_IMP

