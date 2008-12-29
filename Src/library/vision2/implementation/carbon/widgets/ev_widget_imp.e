note
	description:
		"Eiffel Vision widget. Carbon implementation.%N%
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
		redefine
			interface,
			initialize,
			call_button_event_actions,
			destroy,
			minimum_width,
			minimum_height,
			on_key_event,
			show
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

	CONTROLS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	HIGEOMETRY_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
		do
			Precursor {EV_PICK_AND_DROPABLE_IMP}
			internal_minimum_width := 0
			internal_minimum_height := 0
			set_is_initialized (True)

			expandable := True -- default
		end

	initialize_file_drop (a_widget: POINTER)
		do
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
			hide_control_external (c_object)
--			is_show_requested := false
		end

	show
		do
			show_control_external (c_object)
--			is_show_requested := true
		end


	is_show_requested: BOOLEAN --is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'
		do
			Result :=hiview_is_visible_external ( c_object ).to_boolean
		end


feature -- Element change

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			set_minimum_size (a_minimum_width, internal_minimum_height)
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			set_minimum_size ( internal_minimum_width, a_minimum_height)
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		local
			c: EV_CONTAINER_IMP
			old_height, old_width: INTEGER
		do
			old_height := minimum_height
			old_width := minimum_width
			internal_set_minimum_size (a_minimum_width, a_minimum_height)
			if parent /= void then
				c ?= parent.implementation
				check
					has_implementation: c /= void
				end
				c.child_has_resized (current, minimum_height - old_height, minimum_width - old_width)
			end

		end

feature -- Measurement

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
	do
		if internal_minimum_width > 0 then
			Result := internal_minimum_width
		else
			Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
		end
	end

	minimum_height: INTEGER
			-- Minimum width that the widget may occupy.
	do
		if internal_minimum_height > 0 then
			Result := internal_minimum_height
		else
			Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
		end
	end

feature {EV_ANY_I} -- Implementation

	reset_minimum_size
			-- Reset all values to defaults.
			-- Called by EV_FIXED and EV_VIEWPORT implementations.
		do
		end

	refresh_now
			-- Flush any pending redraws due for `Current'.
		do
		end

feature {EV_FIXED_IMP, EV_VIEWPORT_IMP} -- Implementation

	store_minimum_size
			-- Called when size is explicitly set, ie: from fixed or viewport
		do
		end

	internal_minimum_width: INTEGER
			-- Minimum width for the widget.

	internal_minimum_height: INTEGER
			-- Minimum height for the widget.

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
		end

feature {EV_ANY_IMP, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	destroy
			do
				app_implementation.dispose_id (event_id)
			end

	parent_imp: EV_CONTAINER_IMP
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)

feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	top_level_window_imp: EV_WINDOW_IMP
			-- Window implementation that `Current' is contained within (if any)
		do
		end

	top_level_window: EV_WINDOW
			-- Window the current is contained within (if any)
		do
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_widget_mapped
			-- `Current' has been mapped on to the screen.
		do
		end

feature {NONE} -- Implementation

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Abstracted implementation for minimum size setting.
		do
			if a_minimum_width /= -1 then
				internal_minimum_width := a_minimum_width
			end
			if a_minimum_height /= -1 then
				internal_minimum_height := a_minimum_height
			end
		end

	propagate_foreground_color_internal (a_color: EV_COLOR; a_c_object: POINTER)
			-- Propagate `a_color' to the foreground color of `a_c_object's children.
		do
		end

	propagate_background_color_internal (a_color: EV_COLOR; a_c_object: POINTER)
			-- Propagate `a_color' to the background color of `a_c_object's children.
		do
		end

	last_width, last_height: INTEGER
			-- Dimenions during last "size-allocate".

	in_resize_event: BOOLEAN
			-- Is `interface.resize_actions' being executed?

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	interface: EV_WIDGET;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_WIDGET_IMP

