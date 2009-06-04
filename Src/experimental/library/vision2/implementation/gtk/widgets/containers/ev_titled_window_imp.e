note
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
			old_make,
			default_wm_decorations,
			is_displayed,
			call_window_state_event
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create the titled window.
		do
			assign_interface (an_interface)
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP} -- Implementation

	call_window_state_event (a_changed_mask, a_new_state: INTEGER)
			-- Handle either minimize, maximize or restore event for `Current'.
		local
			l_call_restore: BOOLEAN
		do
			if a_changed_mask & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum then
				if a_new_state & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum then
					is_minimized := True
					is_maximized := False
					if minimize_actions_internal /= Void then
						minimize_actions_internal.call (Void)
					end
				else
					l_call_restore := True
				end
			elseif a_changed_mask & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum then
				if a_new_state & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum then
					is_maximized := True
					is_minimized := False
					if maximize_actions_internal /= Void then
						maximize_actions_internal.call (Void)
					end
				else
					l_call_restore := True
				end
			end
			if l_call_restore then
				is_minimized := False
				is_maximized := False
				if restore_actions_internal /= Void then
					restore_actions_internal.call (Void)
				end
			end
			Precursor {EV_WINDOW_IMP} (a_changed_mask, a_new_state)
		end

feature -- Access

	icon_name: STRING_32
			-- Alternative name, displayed when window is minimised.
		do
			if attached icon_name_holder as l_icon_name_holder then
				Result := l_icon_name_holder
			else
				Result := title
			end
		end

	icon_pixmap: EV_PIXMAP
			-- Window icon.
		do
			if attached icon_pixmap_internal as l_icon_pixmap_internal then
				Result := l_icon_pixmap_internal
			else
				Result := default_pixmaps.default_window_icon
			end
		end

	icon_pixmap_internal: detachable EV_PIXMAP

	icon_mask: detachable EV_PIXMAP
			-- Transparency mask for `icon_pixmap'.

feature -- Status report

	is_minimized: BOOLEAN
			-- Is displayed iconified/minimised?

	is_maximized: BOOLEAN
			-- Is displayed at maximum size?

	is_displayed: BOOLEAN
			-- Is 'Current' displayed on screen?
		do
			Result := Precursor {EV_WINDOW_IMP} and not is_minimized
		end

feature -- Status setting

	raise
			-- Request that window be displayed above all other windows.
		do
			if not is_show_requested then
				show
			elseif is_minimized then
				restore
			end
			{EV_GTK_EXTERNALS}.gdk_window_raise ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

	lower
			-- Request that window be displayed below all other windows.
		do
			{EV_GTK_EXTERNALS}.gdk_window_lower ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

	minimize
			-- Display iconified/minimised.
		do
			is_minimized := True
			is_maximized := False
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_iconify (c_object)
		end

	maximize
			-- Display at maximum size.
		do
			is_maximized := True
			is_minimized := False
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_maximize (c_object)
		end

	restore
			-- Restore to original position when minimized or maximized.
		do
			if is_maximized then
				is_maximized := False
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_unmaximize (c_object)
			elseif is_minimized then
				is_minimized := False
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_deiconify (c_object)
			end
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING_GENERAL)
			-- Assign `an_icon_name' to `icon_name'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := an_icon_name
			{EV_GTK_EXTERNALS}.gdk_window_set_icon_name (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_cs.item)
			icon_name_holder := an_icon_name.twin
		end

	set_icon_pixmap (an_icon: EV_PIXMAP)
			-- Assign `an_icon' to `icon'.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
			pixmap_imp ?= an_icon.twin.implementation
			check
				icon_implementation_exists: pixmap_imp /= Void
			end
			icon_pixmap_internal := pixmap_imp.interface
			{EV_GTK_EXTERNALS}.gdk_window_set_icon ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL, pixmap_imp.drawable, pixmap_imp.mask)
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER
			-- Default WM decorations of `Current'.?
		do
			Result := {EV_GTK_EXTERNALS}.gdk_decor_all_enum
		end

feature {EV_ANY_I} -- Implementation

	icon_name_holder: detachable STRING_32
			-- Name holder for applications icon name

	interface: detachable EV_TITLED_WINDOW note option: stable attribute end;

note
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





