note
	description:
		"Eiffel Vision widget. Cocoa implementation.%N%
		%See ev_widget.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_IMP

inherit
	EV_WIDGET_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		undefine
			show,
			top_level_window_imp
		redefine
			interface,
			initialize,
			call_button_event_actions,
			destroy
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_COLORIZABLE_IMP
		redefine
			interface
		end

	EV_WIDGET_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES}
				focus_in_actions_internal,
				focus_out_actions_internal,
				pointer_motion_actions_internal,
				pointer_button_release_actions,
				pointer_leave_actions,
				pointer_leave_actions_internal,
				pointer_enter_actions_internal
		redefine
			interface
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

	EV_SIZEABLE_IMP
		redefine
			interface
		end

	EV_NS_VIEW
		redefine
			interface
		end

feature {NONE} -- Initialization

	initialize
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
		do
			is_show_requested := True
			set_expandable (True)
			set_is_initialized (True)
		end

feature {EV_WINDOW_IMP, EV_INTERMEDIARY_ROUTINES, EV_ANY_I} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- Used for key event actions sequences.
		local
			temp_key_string: STRING_32
			app_imp: like app_implementation
		do
			app_imp := app_implementation
			if has_focus or else has_capture then
					-- We make sure that only the widget with either the focus or the keyboard capture receives key events
				if a_key_press then
						-- The event is a key press event.
					if app_imp.key_press_actions_internal /= Void then
						app_imp.key_press_actions_internal.call ([interface, a_key])
					end
					if a_key /= Void and then key_press_actions_internal /= Void then
						key_press_actions_internal.call ([a_key])
					end
					if key_press_string_actions_internal /= Void then
						temp_key_string := a_key_string
						if a_key /= Void then
							if a_key.out.count /= 1 and not a_key.is_numpad then
									-- The key pressed is an action key, we only want
								inspect
									a_key.code
								when {EV_KEY_CONSTANTS}.Key_space then
									temp_key_string := once  " "
								when {EV_KEY_CONSTANTS}.Key_enter then
									temp_key_string := once "%N"
								when {EV_KEY_CONSTANTS}.Key_tab then
									temp_key_string := once "%T"
								else
										-- The action key pressed has no printable value
									temp_key_string := Void
								end
							end
						end
						if temp_key_string /= Void then
							if app_imp.key_press_string_actions_internal /= Void then
								app_imp.key_press_string_actions_internal.call ([interface, temp_key_string])
							end
							key_press_string_actions_internal.call ([temp_key_string])
						end
					end
				else
						-- The event is a key release event.
					if a_key /= Void then
						if app_imp.key_release_actions_internal /= Void then
							app_imp.key_release_actions.call ([interface, a_key])
						end
						if key_release_actions_internal /= Void then
							key_release_actions_internal.call ([a_key])
						end
					end
				end
			end
		end

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
		end

	on_pointer_enter_leave (a_pointer_enter: BOOLEAN)
			-- Called from pointer enter leave intermediary agents when the mouse pointer either enters or leaves `Current'.
		do
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		do
		end

feature {EV_APPLICATION_IMP} -- Implementation

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
			-- Handle motion event for `Current'.
		do
		end

feature -- Access

	parent: EV_CONTAINER
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		local
			a_par_imp: EV_CONTAINER_IMP
		do
			a_par_imp := parent_imp
			if a_par_imp /= Void then
				Result := a_par_imp.interface
			end
		end

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer relative to `Current'.
		do
			create Result.set (1, 1)
		end

feature -- Status setting

	hide
			-- Request that `Current' not be displayed even when its parent is.
		do
			is_show_requested := False
			if attached {NS_VIEW} cocoa_item as view then
				view.set_hidden (True)
			end
		end

	show
		local
			p_imp: like parent_imp
		do
			is_show_requested := True
			if attached {NS_VIEW} cocoa_item as view then
				view.set_hidden (False)
			end
			p_imp := parent_imp
			if p_imp /= Void then
				p_imp.notify_change (Nc_minsize, Current)
			end
		end


	is_show_requested: BOOLEAN --is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'

	is_displayed: BOOLEAN
			-- Precursor
		do
			Result := is_show_requested
		end

feature {EV_ANY_I} -- Implementation

	refresh_now
			-- Flush any pending redraws due for `Current'.
		do
		end

feature {EV_WINDOW_IMP} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN
			-- Used for drawing area to keep focus on all keys.
		do
		end

feature {EV_CONTAINER_IMP} -- Implementation

	set_parent_imp (a_container_imp: EV_CONTAINER_IMP)
			-- Set `parent_imp' to `a_container_imp'.
		do
			parent_imp := a_container_imp
			if a_container_imp /= void then
				set_top_level_window_imp (a_container_imp.top_level_window_imp)
			else
				set_top_level_window_imp (void)
			end
		end

feature {EV_ANY_IMP} -- Implementation

	destroy
		do
		end

	parent_imp: EV_CONTAINER_IMP
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)

feature -- Widget relationships

	top_level_window: EV_WINDOW
			-- Top level window that contains `Current'.
		do
			if top_level_window_imp /= Void then
				Result ?= top_level_window_imp.interface
			end
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		deferred
		end

feature {NONE} -- Minimum size

	last_width, last_height: INTEGER -- TODO: remove?
			-- Dimenions during last "size-allocate".

	in_resize_event: BOOLEAN -- TODO: remove?
			-- Is `interface.resize_actions' being executed?

feature {EV_BOX_IMP, LAYOUT_INSPECTOR} -- expandable

	is_expandable: BOOLEAN

	set_expandable (a_flag: BOOLEAN)
		do
			is_expandable := a_flag
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_WIDGET_IMP

