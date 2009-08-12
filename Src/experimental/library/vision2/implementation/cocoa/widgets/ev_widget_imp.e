note
	description:
		"Eiffel Vision widget. Cocoa implementation.%N%
		%See ev_widget.e"
	author: "Daniel Furrer"
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
			top_level_window_imp,
			set_pointer_style
		redefine
			interface,
			make,
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

	NS_ENVIRONEMENT

	NS_STRING_CONSTANTS

feature {NONE} -- Initialization

	initialize
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
		require
			cocoa_view /= Void
		do
			is_show_requested := True
			set_expandable (True)
			set_is_initialized (True)

			-- FIXME: should only be called once cocoa_view is set up (/= void)! otherwise we get multiple callbacks per widget
--			default_center.remove_observers
			default_center.add_observer (agent on_size_change, view_frame_did_change_notification, cocoa_view)
		end

feature {EV_WINDOW_IMP, EV_INTERMEDIARY_ROUTINES, EV_ANY_I} -- Implementation

	on_size_change (a_notification: NS_NOTIFICATION)
			-- Notification sent to the Cocoa view
		local
			l_width, l_height: INTEGER
		do
			if attached cocoa_view then
				--io.put_string ("Calling on_size_change of " + current.generator + " " + object_id.out + " (" + attached_view.item.out + ") with:" + a_notification.object.item.out + "%N")
				if attached_view.item /= a_notification.object.item then
					io.put_string ("Incorrect callback to on_size_change: " + current.generator + " " + object_id.out + " (item " + attached_view.item.out + " but got " + a_notification.object.item.out + ")%N")
				end
				l_width := width
				l_height := height
				if l_width /= last_width or l_height /= last_height and l_width > 0 and l_height > 0 then
					if not in_resize_event and attached resize_actions_internal as l_actions then
						in_resize_event := True
						io.put_string ("Size change: " + current.generator + " " + object_id.out + "  " + width.out + "x" + height.out + "%N")
						l_actions.call ([screen_x, screen_y, width, height])
						in_resize_event := False
					end
					on_size (l_width, l_height)
					last_width := l_width
					last_height := l_height
				end
			end
		end

	on_size (a_width, a_height: INTEGER)
		do

		end

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- Used for key event actions sequences.
		local
			temp_key_string: detachable STRING_32
			app_imp: like app_implementation
		do
			app_imp := app_implementation
			if has_focus or else has_capture then
					-- We make sure that only the widget with either the focus or the keyboard capture receives key events
				if a_key_press then
						-- The event is a key press event.
					if attached app_imp.key_press_actions_internal as l_key_press_actions then
						l_key_press_actions.call ([attached_interface, a_key])
					end
					if a_key /= Void and then attached key_press_actions_internal as l_key_press_actions then
						l_key_press_actions.call ([a_key])
					end
					if attached key_press_string_actions_internal as l_key_press_actions then
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
							if attached app_imp.key_press_string_actions_internal as l_app_key_press_actions then
								l_app_key_press_actions.call ([attached_interface, temp_key_string])
							end
							l_key_press_actions.call ([temp_key_string])
						end
					end
				else
						-- The event is a key release event.
					if a_key /= Void then
						if attached app_imp.key_release_actions_internal as key_actions then
							key_actions.call ([attached_interface, a_key])
						end
						if attached key_release_actions_internal as key_actions then
							key_actions.call ([a_key])
						end
					end
				end
			end
		end

feature -- Access

	parent: detachable EV_CONTAINER
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		do
			if attached {EV_CONTAINER_IMP} parent_imp as pimp then
				Result := pimp.attached_interface
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
			attached_view.set_hidden (True)
		end

	show
		do
			is_show_requested := True
			attached_view.set_hidden (False)
			if attached parent_imp as p_imp then
				p_imp.notify_change (Nc_minsize, Current)
			end
		end

	is_show_requested: BOOLEAN
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

	set_parent_imp (a_container_imp: detachable EV_CONTAINER_IMP)
			-- Set `parent_imp' to `a_container_imp'.
		do
			parent_imp := a_container_imp
			if attached a_container_imp  as l_container_imp then
				set_top_level_window_imp (l_container_imp.top_level_window_imp)
			else
				set_top_level_window_imp (void)
			end
		end

feature {EV_ANY_IMP} -- Implementation

	destroy
		do
			if attached parent_imp as pimp then
				pimp.attached_interface.prune (attached_interface)
			end
			set_is_destroyed (True)
		end

	parent_imp: detachable EV_CONTAINER_IMP
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)

feature -- Widget relationships

	top_level_window: detachable EV_WINDOW
			-- Top level window that contains `Current'.
		do
			if attached top_level_window_imp as w then
				Result := w.attached_interface
			end
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		deferred
		end

feature {NONE} -- Minimum size

	last_width, last_height: INTEGER
			-- Dimenions during last resize message.
			-- Used for optimizing callbacks

	in_resize_event: BOOLEAN -- TODO: remove?
			-- Is `interface.resize_actions' being executed?

feature {EV_BOX_IMP, LAYOUT_INSPECTOR} -- expandable

	is_expandable: BOOLEAN

	set_expandable (a_flag: BOOLEAN)
		do
			is_expandable := a_flag
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WIDGET note option: stable attribute end;

end -- class EV_WIDGET_IMP
