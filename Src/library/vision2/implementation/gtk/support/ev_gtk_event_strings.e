indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_EVENT_STRINGS



feature -- Implementation

	key_press_event_string: STRING is
		once
			Result := "key_press_event"
		end

	key_release_event_string: STRING is
			-- key-release-event string constant
		once
			Result := "key_release_event"
		end

	focus_in_event_string: STRING is
			-- focus_in_event_string constant.
		once
			Result := "focus_in_event"
		end

	focus_out_event_string: STRING is
			-- focus_out_event_string constant.
		once
			Result := "focus_out_event"
		end

	enter_notify_event_string: STRING is
			-- enter_notify_event_string constant.
		once
			Result := "enter_notify_event"
		end

	leave_notify_event_string: STRING is
			-- leave_notify_event_string constant.
		once
			Result := "leave_notify_event"
		end

	motion_notify_event_string: STRING is
			-- motion_notify_event_string constant.
		once
			Result := "motion_notify_event"
		end

	size_allocate_event_string: STRING is
			-- size_allocate_event_string constant.
		once
			Result := "size_allocate"
		end		

	button_press_event_string: STRING is
			-- button_press_event_string constant.
		once
			Result := "button_press_event"
		end				

	button_release_event_string: STRING is
			-- button_release_event_string constant.
		once
			Result := "button_release_event"
		end

	clicked_event_string: STRING is
			-- button_release_event_string constant.
		once
			Result := "clicked"
		end

end
