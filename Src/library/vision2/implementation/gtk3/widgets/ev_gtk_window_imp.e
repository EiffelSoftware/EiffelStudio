note
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

	parent_imp: detachable EV_CONTAINER_IMP
			-- Parent of `Current', always Void as windows cannot be parented
		do
			-- Return Void
		end

	set_blocking_window (a_window: detachable EV_WINDOW)
			-- Set as transient for `a_window'.
		local
			l_internal_blocking_window: detachable EV_WINDOW_IMP
		do
			if not is_destroyed then
				if a_window /= Void then
					l_internal_blocking_window ?= a_window.implementation
					check l_internal_blocking_window /= Void then end
					internal_blocking_window := l_internal_blocking_window
					l_internal_blocking_window.add_transient_child (Current)
				else
					l_internal_blocking_window := internal_blocking_window
					if l_internal_blocking_window /= Void then
						l_internal_blocking_window.remove_transient_child (Current)
						internal_blocking_window := Void
					end
				end
			else
				internal_blocking_window := Void
			end
		end

	blocking_window: detachable EV_WINDOW
			-- Window this dialog is a transient for.
		do
			if attached internal_blocking_window as l_internal_blocking_window and then not l_internal_blocking_window.is_destroyed then
				Result := l_internal_blocking_window.interface
			end
		end

	window_position_enum: INTEGER
			-- GtkWindow positioning enum.
		do
			if blocking_window /= Void then
				Result := {GTK2}.Gtk_win_pos_center_on_parent_enum
			else
				Result := default_window_position
			end
		end

	default_window_position: INTEGER
			-- Default Window Manager Position for `Current'.
		do
			Result := {GTK}.gtk_win_pos_none_enum
		end

	internal_blocking_window: detachable EV_WINDOW_IMP
			-- Window that `Current' is relative to.
			-- Implementation

	set_width (a_width: INTEGER)
			-- Set the horizontal size to `a_width'.
		do
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER)
			-- Set the vertical size to `a_height'.
		do
			set_size (width, a_height)
		end


	set_size (a_width, a_height: INTEGER)
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		local
			l_width, l_height: INTEGER
		do
				-- Set constraints so that resize does not break existing minimum sizing.
			l_width := a_width.max (minimum_width)
			l_height := a_height.max (minimum_height)
			{GTK}.gtk_window_set_default_size (c_object, l_width, l_height)
			{GTK2}.gtk_window_resize (c_object, l_width, l_height)

				-- Set configure_event_pending to True so that dimensions are updated immediately.
			configure_event_pending := True

				-- If user cannot resize window then we recall `forbid_resize' which will update the dimensions.
			if is_displayed and then not user_can_resize then
				forbid_resize
			end
		end

	width: INTEGER
			-- Width of `Current'.
		do
			if configure_event_pending or not is_displayed then
				{GTK}.gtk_window_get_default_size (c_object, $Result, default_pointer)
				Result := Result.max (minimum_width)
			else
				Result := Precursor
			end
		end

	height: INTEGER
			-- Height of `Current'.
		do
			if configure_event_pending or not is_displayed then
				{GTK}.gtk_window_get_default_size (c_object, default_pointer, $Result)
				Result := Result.max (minimum_height)
			else
				Result := Precursor
			end
		end

	set_x_position (a_x: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
		do
			set_position (a_x, y_position)
		end

	set_y_position (a_y: INTEGER)
			-- Set vertical offset to parent to `a_y'.
		do
			set_position (x_position, a_y)
		end

	set_position (a_x, a_y: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			{GTK2}.gtk_window_move (c_object, a_x - app_implementation.screen_virtual_x, a_y - app_implementation.screen_virtual_y)
		end

	configure_event_pending: BOOLEAN
		-- Has `Current' experienced a configure event?

	client_width: INTEGER
			-- Width of the client area.
		local
			h: INTEGER
		do
			{GTK2}.gtk_window_get_size (c_object, $Result, $h)
		end

	client_height: INTEGER
			-- Height of the client area.
		local
			w: INTEGER
		do
			{GTK2}.gtk_window_get_size (c_object, $w, $Result)
		end

	x_position, screen_x: INTEGER
			-- Horizontal position of the window on screen,
		local
			temp_y: INTEGER
		do
			{GTK2}.gtk_window_get_position (c_object, $Result, $temp_y)
			Result := Result + app_implementation.screen_virtual_x
		end

	y_position, screen_y: INTEGER
			-- Vertical position of the window on screen,
		local
			temp_x: INTEGER
		do
			{GTK2}.gtk_window_get_position (c_object, $temp_x, $Result)
			Result := Result + app_implementation.screen_virtual_y
		end

	default_wm_decorations: INTEGER
			-- Default WM decorations of `Current'.
		do
			Result := 0 -- No decorations
		end

	show
			-- Request that `Current' be displayed when its parent is.
		do
			if not is_show_requested then
				{GTK}.gtk_window_set_position (c_object, window_position_enum)
				{GTK}.gtk_widget_show (c_object)
			end
		end

	hide
			-- Hide `Current'.
		local
			l_x_pos, l_y_pos, l_width, l_height: INTEGER_32
		do
			if is_show_requested then
				if
					is_modal and then
					attached internal_blocking_window as l_internal_blocking_window and then
					not l_internal_blocking_window.is_destroyed and then
					l_internal_blocking_window.is_show_requested
				then
					l_internal_blocking_window.decrease_modal_window_count
				end

				l_x_pos := x_position
				l_y_pos := y_position
				l_width := width
				l_height := height

				is_modal := False
				set_blocking_window (Void)
					-- Set the default size so that the
				{GTK}.gtk_widget_hide (c_object)
					-- Force an immediate hide so that the event loop is not relied upon to unmap `Current'.
				{GDK}.gdk_window_hide ({GTK}.gtk_widget_get_window (c_object))

					-- Reset the size and position to emulate Win32 behavior.
				{GTK}.gtk_window_set_default_size (c_object, l_width, l_height)
				{GTK2}.gtk_window_move (c_object, l_x_pos, l_y_pos)
			end
		end

	close
			-- Hide `Current'.
		do
			hide
				-- Force an immediate close so that the event loop is not relied upon to unmap `Current'.
			{GTK}.gtk_window_close (c_object)
		end

	is_modal: BOOLEAN
			-- Is `Current' modal?

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal with respect to `a_window'.
		local
			l_window_imp: detachable EV_WINDOW_IMP
		do
			l_window_imp ?= a_window.implementation
			check l_window_imp /= Void then end
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
					{GDK}.gdk_window_raise ({GTK}.gtk_widget_get_window (l_window_imp.c_object))
				end
			end
		end

feature -- Basic operations

	show_relative_to_window (a_window: EV_WINDOW)
			-- Show `Current' with respect to `a_window'.
		do
			set_blocking_window (a_window)
			show
				-- This extra call is needed otherwise the Window will not be transient.
			set_blocking_window (a_window)
		end

	block
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

	blocking_condition: BOOLEAN
			-- Condition when blocking ceases if enabled.
		do
			Result := is_destroyed or else not is_show_requested or else app_implementation.is_destroyed
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP}

	user_can_resize: BOOLEAN
			-- Can `Current' be resized by the user?
		deferred
		end

	on_key_event (a_key: detachable EV_KEY; a_key_string: detachable STRING_32; a_key_press: BOOLEAN)
			-- `a_key' has either been pressed or released
		deferred
		end

	process_key_event (a_key_event: POINTER)
			-- Translation routine used for key events
		local
			keyval: NATURAL_32
			l_key_string: detachable STRING_32
			a_key: detachable EV_KEY
			a_key_press: BOOLEAN
			l_app_imp: like app_implementation
			l_accel_list: detachable EV_ACCELERATOR_LIST
			l_accel_called: BOOLEAN
			l_window_imp: detachable EV_WINDOW_IMP
			a_focus_widget: detachable EV_WIDGET_IMP
			l_standard_dialog: detachable EV_STANDARD_DIALOG_IMP
			l_tab_controlable: detachable EV_TAB_CONTROLABLE_I
			l_disable_default_processing: BOOLEAN
			l_char: CHARACTER_32
			l_any: ANY
			l_accel: detachable EV_ACCELERATOR
			l_accel_imp: detachable EV_ACCELERATOR_IMP
			l_key_event_handled, l_is_tab_navigation: BOOLEAN
		do
			l_app_imp := app_implementation

				-- Perform translation on key values from gdk.
			keyval := {GDK}.gdk_event_key_struct_keyval (a_key_event)
			if keyval > 0 then
				if not valid_gtk_code (keyval) then
						-- We perform mapping for F11 and F12 keys on Solaris with Type 4 keyboards.
					if keyval = 0x1005FF10 then
							-- If Sun_F36 has been pressed then map it to F11 key
						keyval := {EV_GTK_KEY_CONVERSION}.key_f11_keysym
					elseif keyval = 0x1005FF11 then
							-- If Sun_F37 has been pressed then map it to F12 key
						keyval := {EV_GTK_KEY_CONVERSION}.key_f12_keysym
					else
						keyval := 0
					end
				end
				if keyval > 0 then
					create a_key.make_with_code (key_code_from_gtk (keyval))
				end
			end
			if {GDK}.gdk_event_key_struct_type (a_key_event) = {GDK}.gdk_key_press_enum then
				a_key_press := True
				l_window_imp ?= Current

					-- Call accelerators if present.
				if a_key /= Void and then l_window_imp /= Void then
					l_accel_list := l_window_imp.accelerators_internal
					if l_accel_list /= Void and then not l_accel_list.is_empty then
						l_accel := l_accel_list @ 1
						if l_accel /= Void then
							l_accel_imp ?= l_accel.implementation
							check l_accel_imp /= Void then end
								-- We retrieve an accelerator implementation object to generate an accelerator id for hash table lookup.
							l_accel := l_window_imp.accel_list.item (l_accel_imp.hash_code_function (a_key.code, l_app_imp.ctrl_pressed, l_app_imp.alt_pressed, l_app_imp.shift_pressed))
							if l_accel /= Void then
								l_accel_called := True
								l_app_imp.do_once_on_idle (agent (l_accel.actions).call (Void))
							end
						end
					end
				end

				l_key_string := l_app_imp.character_string_buffer
				l_key_string.wipe_out
					-- Propagate key event to input context, this will update the character buffer with any inputted Unicode characters.
				l_key_event_handled := {GTK2}.gtk_im_context_filter_keypress (l_app_imp.default_input_context, a_key_event)

				if not l_accel_called then
						-- We only fire key_string actions if no accelerators were called.					
					if l_key_string /= Void and then l_key_string.valid_index (1) then
						l_char := l_key_string @ 1
						if l_char.is_character_8 and then not l_char.to_character_8.is_printable and then l_char.code <= 127 then
							l_key_string := Void
								-- Non displayable characters
						end
					else
							-- There is no valid key string so we unset the local, ie: A Function Key has been pressed.
						l_key_string := Void
					end
					if a_key /= Void and then a_key.text.count /= 1 and then not a_key.is_numpad then
						inspect a_key.code
						when {EV_KEY_CONSTANTS}.key_space then
							l_key_string := once {STRING_32} " "
						when {EV_KEY_CONSTANTS}.key_enter then
							l_key_string := once {STRING_32} "%N"
						when {EV_KEY_CONSTANTS}.key_tab then
							l_key_string := once {STRING_32} "%T"
						else
							l_key_string := Void
						end
					end
				end
			end

			a_focus_widget ?= l_app_imp.eif_object_from_gtk_object ({GTK}.gtk_window_get_focus (c_object))
			l_any := Current
			if a_focus_widget = Void then
					-- If the focus widget is not available then set it to the current window.
				a_focus_widget ?= l_any
				if a_focus_widget = Void then
					l_standard_dialog ?= l_any
				end
			end
			if a_focus_widget /= Void and then a_focus_widget.is_sensitive and then a_focus_widget.has_focus then
				if a_key /= Void then
					l_disable_default_processing := a_focus_widget.disable_default_processing_on_key (a_key)
					if not l_disable_default_processing then
						l_is_tab_navigation := a_key.code = {EV_KEY_CONSTANTS}.key_tab
						if l_is_tab_navigation then
							if l_app_imp.shift_pressed then
								l_app_imp.set_tab_navigation_state ({EV_APPLICATION_I}.tab_state_from_next)
							else
								l_app_imp.set_tab_navigation_state ({EV_APPLICATION_I}.tab_state_from_previous)
							end
						end
						l_tab_controlable ?= a_focus_widget
						if l_tab_controlable /= Void and then not l_tab_controlable.is_tabable_from then
							l_disable_default_processing := a_key.is_arrow or else l_is_tab_navigation
						end
					end
				end

				if not l_disable_default_processing then
					{GTK}.gtk_main_do_event (a_key_event)
				end

				if attached l_app_imp.pick_and_drop_source as l_pick_and_drop_source and then a_key_press and then a_key /= Void and then (a_key.code = {EV_KEY_CONSTANTS}.key_escape or a_key.code = {EV_KEY_CONSTANTS}.key_alt) then
					l_pick_and_drop_source.end_transport (0, 0, 0, 0, 0, 0, 0, 0)
				else
					if a_key_press then
						if a_key /= Void and then l_app_imp.key_press_actions_internal /= Void then
							l_app_imp.key_press_actions.call ([a_focus_widget.attached_interface, a_key])
						end
						if l_key_string /= Void and then l_app_imp.key_press_string_actions_internal /= Void then
							l_app_imp.key_press_string_actions.call ([a_focus_widget.attached_interface, l_key_string])
						end
					else
						if a_key /= Void and then l_app_imp.key_release_actions_internal /= Void then
							l_app_imp.key_release_actions.call ([a_focus_widget.attached_interface, a_key])
						end
					end
					if not l_disable_default_processing then
							-- If `a_focus_widget' is disabling default processing then
							-- we don't call top level window events.
						on_key_event (a_key, l_key_string, a_key_press)
					end
					if
						a_focus_widget /= l_any and then
						not a_focus_widget.is_destroyed
					then
							-- If the focus widget is `Current' then do not call 'on_key_event' twice.
						a_focus_widget.on_key_event (a_key, l_key_string, a_key_press)
					end
				end
			else
				if l_standard_dialog /= Void and then a_key_press then
						-- Standard dialogs are not widgets and have to be handled separately.
					l_standard_dialog.on_key_event (a_key, l_key_string, a_key_press)
				end
					-- Execute the gdk event as normal.
				{GTK}.gtk_main_do_event (a_key_event)
			end
			if l_is_tab_navigation then
					-- Reset any potential tab navigation state.
				l_app_imp.set_tab_navigation_state ({EV_APPLICATION_I}.tab_state_none)
			end
		end

	call_close_request_actions
			-- Call the close request actions.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER_32)
			-- GdkEventConfigure event occurred.
		do
			configure_event_pending := False
		end

	forbid_resize
			-- Forbid the resize of the window.
		local
			l_geometry: POINTER
			l_width, l_height: INTEGER
		do
			l_geometry := {GDK}.c_gdk_geometry_struct_allocate
			l_width := width
			l_height := height
			{GDK}.set_gdk_geometry_struct_max_width (l_geometry, l_width)
			{GDK}.set_gdk_geometry_struct_max_height (l_geometry, l_height)
			{GDK}.set_gdk_geometry_struct_min_width (l_geometry, l_width)
			{GDK}.set_gdk_geometry_struct_min_height (l_geometry, l_height)
			{GTK}.gtk_window_set_geometry_hints (c_object, default_pointer, l_geometry, {GDK}.Gdk_hint_max_size_enum | {GDK}.gdk_hint_min_size_enum)
			l_geometry.memory_free
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_WINDOW_IMP
