indexing
	description: "Objects that represent EV_WIDGET_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WIDGET_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("pointer_motion_actions")
			Result.extend ("pointer_button_press_actions")
			Result.extend ("pointer_double_press_actions")
			Result.extend ("pointer_button_release_actions")
			Result.extend ("pointer_enter_actions")
			Result.extend ("pointer_leave_actions")
			Result.extend ("key_press_actions")
			Result.extend ("key_press_string_actions")
			Result.extend ("key_release_actions")
			Result.extend ("focus_in_actions")
			Result.extend ("focus_out_actions")
			Result.extend ("resize_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_POINTER_MOTION_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_KEY_ACTION_SEQUENCE")
			Result.extend ("EV_KEY_STRING_ACTION_SEQUENCE")
			Result.extend ("EV_KEY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_GEOMETRY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when screen pointer moves.")
			Result.extend ("-- Actions to be performed when screen pointer button is pressed.")
			Result.extend ("-- Actions to be performed when screen pointer is double clicked.")
			Result.extend ("-- Actions to be performed when screen pointer button is released.")
			Result.extend ("-- Actions to be performed when screen pointer enters widget.")
			Result.extend ("-- Actions to be performed when screen pointer leaves widget.")
			Result.extend ("-- Actions to be performed when a keyboard key is pressed.")
			Result.extend ("-- Actions to be performed when a keyboard press generates a displayable character.")
			Result.extend ("-- Actions to be performed when a keyboard key is released.")
			Result.extend ("-- Actions to be performed when keyboard focus is gained.")
			Result.extend ("-- Actions to be performed when keyboard focus is lost.")
			Result.extend ("-- Actions to be performed when size changes.")
		end
		
	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; textable: EV_TEXTABLE) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `wipe_out' `action_sequence'.
		local
			gb_ev_action_sequence: GB_EV_ACTION_SEQUENCE
			notify_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			key_sequence: GB_EV_KEY_ACTION_SEQUENCE
			key_string_sequence: GB_EV_KEY_STRING_ACTION_SEQUENCE
			motion_sequence: GB_EV_POINTER_MOTION_ACTION_SEQUENCE
			geometry_sequence: GB_EV_GEOMETRY_ACTION_SEQUENCE
			pointer_press_sequence: GB_EV_POINTER_BUTTON_ACTION_SEQUENCE
		do
			if action_sequence.is_equal ("pointer_motion_actions") then
				if adding then
					motion_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_POINTER_MOTION_ACTION_SEQUENCE"))
					widget.pointer_motion_actions.extend (motion_sequence.display_agent (action_sequence, textable))
				else
					widget.pointer_motion_actions.wipe_out
				end
			elseif action_sequence.is_equal ("pointer_button_press_actions") then
				if adding then
					pointer_press_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_POINTER_BUTTON_ACTION_SEQUENCE"))
					widget.pointer_button_press_actions.extend (pointer_press_sequence.display_agent (action_sequence, textable))
				else
					widget.pointer_button_press_actions.wipe_out
				end
			elseif action_sequence.is_equal ("pointer_double_press_actions") then
				if adding then
					pointer_press_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_POINTER_BUTTON_ACTION_SEQUENCE"))
					widget.pointer_double_press_actions.extend (pointer_press_sequence.display_agent (action_sequence, textable))
				else
					widget.pointer_double_press_actions.wipe_out
				end
			elseif action_sequence.is_equal ("pointer_button_release_actions") then
				if adding then
					pointer_press_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_POINTER_BUTTON_ACTION_SEQUENCE"))
					widget.pointer_button_release_actions.extend (pointer_press_sequence.display_agent (action_sequence, textable))
				else
					widget.pointer_button_release_actions.wipe_out
				end
			elseif action_sequence.is_equal ("pointer_enter_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.pointer_enter_actions.extend (notify_sequence.display_agent (action_sequence, textable))
				else
					widget.pointer_enter_actions.wipe_out
				end
			elseif action_sequence.is_equal ("pointer_leave_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.pointer_leave_actions.extend (notify_sequence.display_agent (action_sequence, textable))
				else
					widget.pointer_leave_actions.wipe_out
				end
			elseif action_sequence.is_equal ("key_press_actions") then
				if adding then
					key_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_KEY_ACTION_SEQUENCE"))
					widget.key_press_actions.extend (key_sequence.display_agent (action_sequence, textable))
				else
					widget.key_press_actions.wipe_out
				end
			elseif action_sequence.is_equal ("key_press_string_actions") then
				if adding then
					key_string_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_KEY_STRING_ACTION_SEQUENCE"))
					widget.key_press_string_actions.extend (key_string_sequence.display_agent (action_sequence, textable))
				else
					widget.key_press_string_actions.wipe_out
				end
			elseif action_sequence.is_equal ("key_release_actions") then
				if adding then
					key_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_KEY_ACTION_SEQUENCE"))
					widget.key_release_actions.extend (key_sequence.display_agent (action_sequence, textable))
				else
					widget.key_release_actions.wipe_out
				end
			elseif action_sequence.is_equal ("focus_in_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.focus_in_actions.extend (notify_sequence.display_agent (action_sequence, textable))
				else
					widget.focus_in_actions.wipe_out
				end
			elseif action_sequence.is_equal ("focus_out_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.focus_out_actions.extend (notify_sequence.display_agent (action_sequence, textable))
				else
					widget.focus_out_actions.wipe_out
				end
			elseif action_sequence.is_equal ("resize_actions") then
				if adding then
					geometry_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_GEOMETRY_ACTION_SEQUENCE"))
					widget.resize_actions.extend (geometry_sequence.display_agent (action_sequence, textable))
				else
					widget.resize_actions.wipe_out
				end
			end	
		end
		
end -- class GB_EV_WIDGET_ACTION_SEQUENCES

