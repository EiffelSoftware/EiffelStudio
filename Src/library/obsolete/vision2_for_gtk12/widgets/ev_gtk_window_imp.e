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
			width,
			height,
			screen_x,
			screen_y
		end

feature {NONE} -- Agent functions.

	key_event_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE]
			-- Translation agent used for key events
		once
			Result := agent (App_implementation.gtk_marshal).key_event_translate
		end

	set_focus_event_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE]
			-- Translation agent used for set-focus events
		once
			Result := agent (App_implementation.gtk_marshal).set_focus_event_translate
		end

feature {NONE} -- Implementation

	parent_imp: EV_CONTAINER_IMP
			-- Parent of `Current', always Void as windows cannot be parented
		do
			-- Return Void
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		do
			if default_width /= -1 then
				Result := default_width
			else
				Result := Precursor
			end
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		do
			if default_height /= -1 then
				Result := default_height
			else
				Result := Precursor
			end
		end

	set_blocking_window (a_window: EV_WINDOW)
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

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.
		do
			if internal_blocking_window /= Void and then not internal_blocking_window.is_destroyed then
				Result := internal_blocking_window.interface
			end
		end

	internal_blocking_window: EV_WINDOW_IMP
			-- Window that `Current' is relative to.
			-- Implementation

	set_width (a_width: INTEGER)
			-- Set the horizontal size to `a_width'.
		do
			update_request_size
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER)
			-- Set the vertical size to `a_height'.
		do
			update_request_size
			set_size (width, a_height)
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			update_request_size
			default_width := a_width
			default_height := a_height
			{EV_GTK_EXTERNALS}.gdk_window_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), default_width.max (minimum_width), default_height.max (minimum_height))
			{EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, default_width.max (minimum_width), default_height.max (minimum_height))
		end

	default_width, default_height: INTEGER
			-- Default width and height for the window if set, -1 otherwise.
			-- (see. `gtk_window_set_default_size' for more information)

	x_position: INTEGER
			-- X coordinate of `Current'
		do
			Result := screen_x
		end

	y_position: INTEGER
			-- Y coordinate of `Current'
		do
			Result := screen_y
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
			user_x_position := a_x
			user_y_position := a_y
			{EV_GTK_EXTERNALS}.gtk_widget_set_uposition (c_object, a_x, a_y)
			positioned_by_user := True
		end

	user_x_position, user_y_position: INTEGER
			-- Used to store user x and y positions whilst Window is off screen.

	positioned_by_user: BOOLEAN
		-- Has `Current' been positioned by the user?

	screen_x: INTEGER
			-- Horizontal position of the window on screen,
		local
			a_x: INTEGER
			a_aux_info: POINTER
			i: INTEGER
		do
			if positioned_by_user then
				Result := user_x_position
			else
				if has_struct_flag (c_object, {EV_GTK_EXTERNALS}.gtk_mapped_enum) then
					if default_wm_decorations /= 0 then
						{EV_GTK_EXTERNALS}.gdk_window_get_root_origin ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), $a_x, null)
						Result := a_x
					else
						i := {EV_GTK_EXTERNALS}.gdk_window_get_origin ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), $a_x, null)
						Result := a_x
					end
				else
					a_aux_info := aux_info_struct
					if a_aux_info /= null then
						Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
					end
				end
			end
		end

	screen_y: INTEGER
			-- Vertical position of the window on screen,
		local
			a_y: INTEGER
			a_aux_info: POINTER
			i: INTEGER
		do
			if positioned_by_user then
				Result := user_y_position
			else
				if has_struct_flag (c_object, {EV_GTK_EXTERNALS}.gtk_mapped_enum) then
					if default_wm_decorations /= 0 then
						{EV_GTK_EXTERNALS}.gdk_window_get_root_origin ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), null, $a_y)
						Result := a_y
					else
						i := {EV_GTK_EXTERNALS}.gdk_window_get_origin ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), null, $a_y)
						Result := a_y
					end
				else
					a_aux_info := aux_info_struct
					if a_aux_info /= null then
						Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
					end
				end
			end
		end

	default_wm_decorations: INTEGER
			-- Default WM decorations of `Current'.
		do
			Result := 0 -- No decorations
		end

	hide
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

	show_modal_to_window (a_window: EV_WINDOW)
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
						-- this leads to odd behavior when closing the modal dialog so we always present the window.
					{EV_GTK_EXTERNALS}.gtk_window_present (l_window_imp.c_object)
				end
			end
		end

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
				l_app_imp.event_loop_iteration (True)
			end
		end

	blocking_condition: BOOLEAN
			-- Condition when blocking ceases if enabled.
		do
			Result := is_destroyed or else not is_show_requested or else app_implementation.is_destroyed
		end

feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions
			-- Call the close request actions.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	enable_modal
			-- Set `is_modal' to `True'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_modal (c_object, True)
		end

	disable_modal
			-- Set `is_modal' to `False'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_modal (c_object, False)
		end

	forbid_resize
			-- Forbid the resize of the window.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 0, 0)
		end

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




end -- class EV_GTK_WINDOW_IMP
