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
			default_wm_decorations,
			is_displayed,
			initialize
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES_IMP
		export {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES}
			minimize_actions_internal,
			maximize_actions_internal,
			restore_actions_internal
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the titled window.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_EXTERNALS}.gtk_window_toplevel_enum))
		end

	initialize is
			-- Setup accelerators for window
		local
			app_imp: like app_implementation
		do
			app_imp := app_implementation
			Precursor {EV_WINDOW_IMP}
			signal_connect (c_object, app_imp.window_state_event_string, agent (app_imp.gtk_marshal).window_state_intermediary (internal_id, ? , ?), Void, False)
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	call_window_state_event (a_window_state: INTEGER) is
			-- Call either minimize, maximize or restore actions for window
		do
			if a_window_state = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum then
				if not is_minimized then
					is_minimized := True
					is_maximized := False
					if minimize_actions_internal /= Void then
						minimize_actions_internal.call (Void)
					end
				end
			elseif a_window_state = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum then
				if not is_maximized then
					is_maximized := True
					is_minimized := False
					if maximize_actions_internal /= Void then
						maximize_actions_internal.call (Void)
					end
				end

			else
				is_maximized := False
				is_minimized := False
				if restore_actions_internal /= Void then
					restore_actions_internal.call (Void)
				end
			end
		end

	call_accelerators (a_v2_key_value, accel_mods: INTEGER) is
			-- Call the accelerator matching v2 key `a_v2_key_value' with a control mask of `accel_mods'
		local
			acc: EV_ACCELERATOR
			acc_imp: EV_ACCELERATOR_IMP
			i: INTEGER
		do
			from
				i := 1
			until
				i > accelerators_internal.count
			loop
				acc ?= accelerators_internal.i_th (i)
				if acc /= Void then
					acc_imp ?= acc.implementation
					if acc_imp.key.code = a_v2_key_value and then acc_imp.modifier_mask = accel_mods then
						if acc_imp.actions /= Void then
							acc_imp.actions.call (Void)
						end
					end
				end
				i := i + 1
			end
		end

feature -- Access

	icon_name: STRING_32 is
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

	is_minimized: BOOLEAN
			-- Is displayed iconified/minimised?

	is_maximized: BOOLEAN
			-- Is displayed at maximum size?

	is_displayed: BOOLEAN is
			-- Is 'Current' displayed on screen?
		do
			Result := Precursor {EV_WINDOW_IMP} and not is_minimized
		end

feature -- Status setting

	raise is
			-- Request that window be displayed above all other windows.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_present (c_object)
		end

	lower is
			-- Request that window be displayed below all other windows.
		do
			{EV_GTK_EXTERNALS}.gdk_window_lower ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

	minimize is
			-- Display iconified/minimised.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_iconify (c_object)
			call_window_state_event ({EV_GTK_EXTERNALS}.gdk_window_state_iconified_enum)
		end

	maximize is
			-- Display at maximum size.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_maximize (c_object)
			call_window_state_event ({EV_GTK_EXTERNALS}.gdk_window_state_maximized_enum)
		end

	restore is
			-- Restore to original position when minimized or maximized.
		do
			if is_maximized then
				is_maximized := False
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_unmaximize (c_object)
			else
				is_minimized := False
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_deiconify (c_object)
			end
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING_GENERAL) is
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
			pixmap_imp ?= an_icon.twin.implementation
			icon_pixmap := pixmap_imp.interface
			check
				icon_implementation_exists: pixmap_imp /= Void
			end
			{EV_GTK_EXTERNALS}.gdk_window_set_icon ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL, pixmap_imp.drawable, pixmap_imp.mask)
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER is
			-- Default WM decorations of `Current'.?
		do
			Result := {EV_GTK_EXTERNALS}.gdk_decor_all_enum
		end

feature {EV_ANY_I} -- Implementation

	icon_name_holder: STRING_32
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

