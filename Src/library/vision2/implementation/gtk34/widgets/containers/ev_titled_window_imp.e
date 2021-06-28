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
			call_window_state_event,
			on_size_allocate
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create the titled window.
		do
			assign_interface (an_interface)
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP} -- Implementation

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER)
			-- <Precursor>
		do
			Precursor {EV_WINDOW_IMP} (a_x, a_x, a_width, a_height)
			if is_maximized_pending then
					-- Call pending maximize actions.
					-- This is done here as currently the window is maximized before a resize
					-- and the behavior on Windows is to resize first.
				is_maximized_pending := False
				if maximize_actions_internal /= Void then
					maximize_actions_internal.call (Void)
				end
			end
		end

	call_window_state_event (a_changed_mask, a_new_state: INTEGER)
			-- Handle either minimize, maximize or restore event for `Current'.
		local
			l_call_restore: BOOLEAN
		do
			if a_changed_mask & {GTK2}.gdk_window_state_iconified_enum = {GTK2}.gdk_window_state_iconified_enum then
				if a_new_state & {GTK2}.gdk_window_state_iconified_enum = {GTK2}.gdk_window_state_iconified_enum then
						-- Window has been minimized
					is_minimized := True
					is_maximized := False
					if minimize_actions_internal /= Void then
						minimize_actions_internal.call (Void)
					end
				elseif a_new_state & {GTK2}.gdk_window_state_maximized_enum = {GTK2}.gdk_window_state_maximized_enum then
						-- Window has been restored to a maximized state from a previous minimized state
						-- We need to call maximize actions to match Windows behavior instead of calling restore.
					is_maximized := True
					is_minimized := False
					if maximize_actions_internal /= Void then
						maximize_actions_internal.call (Void)
					end
				else
						-- We must be restoring from a minimized to a non maximized state.
					l_call_restore := True
				end
			elseif a_changed_mask & {GTK2}.gdk_window_state_maximized_enum = {GTK2}.gdk_window_state_maximized_enum then
				if a_new_state & {GTK2}.gdk_window_state_maximized_enum = {GTK2}.gdk_window_state_maximized_enum then
						-- The window has been maximized
					is_maximized := True
					is_minimized := False
						-- We defer the calling of maximize actions to `on_size_allocate' so that the dimensions are precalculated.
					is_maximized_pending := True
				else
						-- We must be restoring from a maximized state to a normal window state.
					l_call_restore := True
				end
			end
			if l_call_restore then
					-- Call restore actions after setting
				is_minimized := False
				is_maximized := False
				if restore_actions_internal /= Void then
					restore_actions_internal.call (Void)
				end
			end
			Precursor {EV_WINDOW_IMP} (a_changed_mask, a_new_state)
		end

	is_maximized_pending: BOOLEAN
		-- Is there currently a maximized event pending?

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
			{GTK}.gdk_window_raise ({GTK}.gtk_widget_get_window (c_object))
		end

	lower
			-- Request that window be displayed below all other windows.
		do
			{GTK}.gdk_window_lower ({GTK}.gtk_widget_get_window (c_object))
		end

	minimize
			-- Display iconified/minimised.
		do
			is_minimized := True
			is_maximized := False
			{GTK2}.gtk_window_iconify (c_object)
			show
		end

	maximize
			-- Display at maximum size.
		do
			is_maximized := True
			is_minimized := False
			{GTK2}.gtk_window_maximize (c_object)
			show
		end

	restore
			-- Restore to original position when minimized or maximized.
		do
			if is_maximized then
				is_maximized := False
				{GTK2}.gtk_window_unmaximize (c_object)
			elseif is_minimized then
				is_minimized := False
				{GTK2}.gtk_window_deiconify (c_object)
			end
		end

feature -- Element change

	set_icon_name (an_icon_name: READABLE_STRING_GENERAL)
			-- Assign `an_icon_name' to `icon_name'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := an_icon_name
			{GTK}.gdk_window_set_icon_name (
				{GTK}.gtk_widget_get_window (c_object), a_cs.item)
			icon_name_holder := an_icon_name.as_string_32.twin
		end

	set_icon_pixmap (an_icon: EV_PIXMAP)
			-- Assign `an_icon' to `icon'.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
			pixmap_imp ?= an_icon.twin.implementation
			check
				icon_implementation_exists: pixmap_imp /= Void then
			end
			icon_pixmap_internal := pixmap_imp.interface
			--| FIXME IEK Implement with gtk 3 feature.
			{GTK2}.gtk_window_set_icon (c_object, pixmap_imp.pixbuf)
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER
			-- Default WM decorations of `Current'.?
		do
			Result := {GTK}.gdk_decor_all_enum
		end

feature {EV_ANY_I} -- Implementation

	icon_name_holder: detachable STRING_32
			-- Name holder for applications icon name

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TITLED_WINDOW note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TITLED_WINDOW_IMP
