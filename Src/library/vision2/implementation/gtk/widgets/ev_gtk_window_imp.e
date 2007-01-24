indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GTK_WINDOW_IMP

inherit
	EV_GTK_WIDGET_IMP
		redefine
			show,
			screen_x,
			screen_y,
			x_position,
			y_position,
			width,
			height
		end

	EV_GTK_KEY_CONVERSION

feature {NONE} -- Implementation

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of `Current', always Void as windows cannot be parented
		do
			-- Return Void
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		local
			win_imp: EV_WINDOW_IMP
			l_window: POINTER
		do
			if not is_destroyed then
				if a_window /= Void then
					win_imp ?= a_window.implementation
					l_window := win_imp.c_object
					internal_blocking_window := win_imp
				else
					internal_blocking_window := Void
				end
				{EV_GTK_EXTERNALS}.gtk_window_set_transient_for (c_object, l_window)
			else
				internal_blocking_window := Void
			end
		end

	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		do
			if internal_blocking_window /= Void and then not internal_blocking_window.is_destroyed then
				Result := internal_blocking_window.interface
			end
		end

	window_position_enum: INTEGER is
			-- GtkWindow positioning enum.
		do
			if blocking_window /= Void then
				Result := {EV_GTK_EXTERNALS}.Gtk_win_pos_center_on_parent_enum
			else
					-- We let the Window Manager decide where the window should be positioned.
				Result := {EV_GTK_EXTERNALS}.gtk_win_pos_none_enum
			end
		end

	internal_blocking_window: EV_WINDOW_IMP
			-- Window that `Current' is relative to.
			-- Implementation

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width'.
		do
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height'.
		do
			set_size (width, a_height)
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_resize (c_object, a_width, a_height)
			{EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, a_width, a_height)
		end

	width: INTEGER
			-- Width of `Current'.
		local
			l_result: INTEGER_32
		do
			if configure_event_pending then
				{EV_GTK_EXTERNALS}.gtk_window_get_default_size (c_object, $l_result, default_pointer)
			end
			Result := l_result.max (Precursor)
		end

	height: INTEGER
			-- Height of `Current'.
		local
			l_result: INTEGER_32
		do
			if configure_event_pending then
				{EV_GTK_EXTERNALS}.gtk_window_get_default_size (c_object, default_pointer, $l_result)
			end
			Result := l_result.max (Precursor)
		end

	set_x_position (a_x: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
		do
			set_position (a_x, y_position)
		end

	set_y_position (a_y: INTEGER) is
			-- Set vertical offset to parent to `a_y'.
		do
			set_position (x_position, a_y)
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_move (c_object, a_x, a_y)
			configure_event_pending := True
		end

	configure_event_pending: BOOLEAN
		-- Has `Current' experienced a configure event?

	x_position, screen_x: INTEGER is
			-- Horizontal position of the window on screen,
		local
			temp_y: INTEGER
		do
			{EV_GTK_EXTERNALS}.gtk_window_get_position (c_object, $Result, $temp_y)
		end

	y_position, screen_y: INTEGER is
			-- Vertical position of the window on screen,
		local
			temp_x: INTEGER
		do
			{EV_GTK_EXTERNALS}.gtk_window_get_position (c_object, $temp_x, $Result)
		end

	default_wm_decorations: INTEGER is
			-- Default WM decorations of `Current'.
		do
			Result := 0 -- No decorations
		end

	show is
			-- Request that `Current' be displayed when its parent is.
		do
			if not is_show_requested then
				{EV_GTK_EXTERNALS}.gtk_window_set_position (c_object, window_position_enum)
				{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			end
		end

	hide is
			-- Hide `Current'.
		do
			if is_show_requested then
				if
					is_modal and then
					internal_blocking_window /= Void and then
					not internal_blocking_window.is_destroyed and then
					internal_blocking_window.is_show_requested
				then
					internal_blocking_window.decrease_modal_window_count
				end
				is_modal := False
				set_blocking_window (Void)
				{EV_GTK_EXTERNALS}.gtk_widget_hide (c_object)
			end
		end

	is_modal: BOOLEAN
		-- Is `Current' modal?

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal with respect to `a_window'.
		local
			l_window_imp: EV_WINDOW_IMP
		do
			l_window_imp ?= a_window.implementation
			is_modal := True
			l_window_imp.increase_modal_window_count
			show_relative_to_window (a_window)
			block
			is_modal := False
				-- No need to call `set_blocking_window' to Void since this is done when
				-- current is hidden.

			if not l_window_imp.is_destroyed then
				if l_window_imp.is_show_requested then
						-- Get window manager to always show parent window.
						-- This is a hack in case parent window was minimized and restored
						-- by the modal dialog, when closed the window managed would restore the
						-- focus to the previously focused window which may or may not be `l_window_imp',
						-- this leads to odd behavior when closing the modal dialog so we always raise the window.
					{EV_GTK_EXTERNALS}.gdk_window_raise ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (l_window_imp.c_object))
				end
			end
		end

feature -- Basic operations

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_window'.
		do
			set_blocking_window (a_window)
			show
				-- This extra call is needed otherwise the Window will not be transient.
			set_blocking_window (a_window)
		end

	block is
			-- Wait until window is closed by the user.
		local
			l_app_imp: like app_implementation
		do
			from
				l_app_imp := app_implementation
			until
				blocking_condition
			loop
				l_app_imp.process_event_queue (True)
			end
		end

	blocking_condition: BOOLEAN is
			-- Condition when blocking ceases if enabled.
		do
			Result := is_destroyed or else not is_show_requested or else app_implementation.is_destroyed
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP}

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN) is
			-- `a_key' has either been pressed or released
		deferred
		end

	process_key_event (a_key_event: POINTER)
			-- Translation routine used for key events
		local
			keyval: NATURAL_32
			a_key_string: STRING_32
			a_key: EV_KEY
			a_key_press: BOOLEAN
			a_cs: EV_GTK_C_STRING
			l_app_imp: like app_implementation
			l_accel_list: EV_ACCELERATOR_LIST
			l_window_imp: EV_WINDOW_IMP
			a_focus_widget: EV_WIDGET_IMP
			l_block_events: BOOLEAN
			l_tab_controlable: EV_TAB_CONTROLABLE_I
			l_char: CHARACTER_32
			l_any: ANY
			l_accel: EV_ACCELERATOR
			l_accel_imp: EV_ACCELERATOR_IMP
			i: INTEGER
			l_exit: BOOLEAN
		do
			l_app_imp := app_implementation
				-- Perform translation on key values from gdk.
			keyval := {EV_GTK_EXTERNALS}.gdk_event_key_struct_keyval (a_key_event)
			if keyval > 0 and then valid_gtk_code (keyval) then
				create a_key.make_with_code (key_code_from_gtk (keyval))
			end
			if {EV_GTK_EXTERNALS}.gdk_event_key_struct_type (a_key_event) = {EV_GTK_EXTERNALS}.gdk_key_press_enum then
				l_window_imp ?= Current
					-- Call accelerators if present.
				if a_key /= Void and then l_window_imp /= Void then
					l_accel_list := l_window_imp.accelerators_internal
					if l_accel_list /= Void then
						from
							i := 1
							l_exit := False
						until
							i > l_accel_list.count or else l_exit
						loop
							l_accel := l_accel_list @ i
							if l_accel /= Void then
								l_accel_imp ?= l_accel.implementation
								if
									l_accel_imp.modifier_mask & l_app_imp.keyboard_modifier_mask = l_accel_imp.modifier_mask and then
									l_accel_imp.key.code = a_key.code
								then
									l_app_imp.do_once_on_idle (agent (l_accel.actions).call (Void))
									l_exit := True
								end
							end
							i := i + 1
						end
					end
				end
				a_key_press := True
				create a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gdk_event_key_struct_string (a_key_event))
				a_key_string := a_cs.string
				if a_key_string /= Void and then a_key_string.valid_index (1) then
					l_char := a_key_string @ 1
					if l_char.is_character_8 then
						if not l_char.to_character_8.is_printable and then l_char.code <= 127 then
							a_key_string := Void
								-- Non displayable characters
						end
					end
				end
				if a_key /= Void and then a_key.out.count /= 1 and then not a_key.is_numpad then
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_space then
						a_key_string := once " "
					when {EV_KEY_CONSTANTS}.key_enter then
						a_key_string := once "%N"
					when {EV_KEY_CONSTANTS}.key_tab then
						a_key_string := once "%T"
					else
						a_key_string := Void
					end
				end
			end

			a_focus_widget ?= l_app_imp.eif_object_from_gtk_object ({EV_GTK_EXTERNALS}.gtk_window_struct_focus_widget (c_object))
			l_any := Current
			if a_focus_widget = Void then
					-- If the focus widget is not available then set it to the current window.
				a_focus_widget ?= l_any
			end
			if a_focus_widget /= Void and then a_focus_widget.is_sensitive and then a_focus_widget.has_focus then
				if a_key /= Void then
					if a_focus_widget.default_key_processing_handler /= Void then
						l_block_events := not a_focus_widget.default_key_processing_handler.item ([a_key])
					end
					if not l_block_events then
						l_tab_controlable ?= a_focus_widget
						if l_tab_controlable /= Void and then not l_tab_controlable.is_tabable_from then
							l_block_events := a_key.is_arrow or else a_key.code = {EV_KEY_CONSTANTS}.key_tab
						end
					end
					if not l_block_events then
						{EV_GTK_EXTERNALS}.gtk_main_do_event (a_key_event)
					end
				end
				if l_app_imp.pick_and_drop_source /= Void and then a_key_press and then a_key /= Void and then (a_key.code = {EV_KEY_CONSTANTS}.key_escape or a_key.code = {EV_KEY_CONSTANTS}.key_alt) then
					l_app_imp.pick_and_drop_source.end_transport (0, 0, 0, 0, 0, 0, 0, 0)
				else
					if a_key_press then
						if a_key /= Void and then l_app_imp.key_press_actions_internal /= Void then
							l_app_imp.key_press_actions_internal.call ([a_focus_widget.interface, a_key])
						end
						if a_key_string /= Void and then l_app_imp.key_press_string_actions_internal /= Void then
							l_app_imp.key_press_string_actions_internal.call ([a_focus_widget.interface, a_key_string])
						end
					else
						if a_key /= Void and then l_app_imp.key_release_actions_internal /= Void then
							l_app_imp.key_release_actions_internal.call ([a_focus_widget.interface, a_key])
						end
					end
					if a_focus_widget /= l_any then
						on_key_event (a_key, a_key_string, a_key_press)
					end
					a_focus_widget.on_key_event (a_key, a_key_string, a_key_press)
				end
			else
					-- Execute the gdk event as normal.
				{EV_GTK_EXTERNALS}.gtk_main_do_event (a_key_event)
			end
		end

	call_close_request_actions is
			-- Call the close request actions.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	forbid_resize is
			-- Forbid the resize of the window.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 0, 0)
		end

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




end -- class EV_GTK_WINDOW_IMP
