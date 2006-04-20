indexing
	description: "Objects that represent EV_WIDGET_ACTION_SEQUENCES."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `remove_only_added' `action_sequence'.
		local
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
					widget.pointer_motion_actions.extend (motion_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.pointer_motion_actions)
				end
			elseif action_sequence.is_equal ("pointer_button_press_actions") then
				if adding then
					pointer_press_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_POINTER_BUTTON_ACTION_SEQUENCE"))
					widget.pointer_button_press_actions.extend (pointer_press_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.pointer_button_press_actions)
				end
			elseif action_sequence.is_equal ("pointer_double_press_actions") then
				if adding then
					pointer_press_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_POINTER_BUTTON_ACTION_SEQUENCE"))
					widget.pointer_double_press_actions.extend (pointer_press_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.pointer_double_press_actions)
				end
			elseif action_sequence.is_equal ("pointer_button_release_actions") then
				if adding then
					pointer_press_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_POINTER_BUTTON_ACTION_SEQUENCE"))
					widget.pointer_button_release_actions.extend (pointer_press_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.pointer_button_release_actions)
				end
			elseif action_sequence.is_equal ("pointer_enter_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.pointer_enter_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.pointer_enter_actions)
				end
			elseif action_sequence.is_equal ("pointer_leave_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.pointer_leave_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.pointer_leave_actions)
				end
			elseif action_sequence.is_equal ("key_press_actions") then
				if adding then
					key_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_KEY_ACTION_SEQUENCE"))
					widget.key_press_actions.extend (key_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.key_press_actions)
				end
			elseif action_sequence.is_equal ("key_press_string_actions") then
				if adding then
					key_string_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_KEY_STRING_ACTION_SEQUENCE"))
					widget.key_press_string_actions.extend (key_string_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.key_press_string_actions)
				end
			elseif action_sequence.is_equal ("key_release_actions") then
				if adding then
					key_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_KEY_ACTION_SEQUENCE"))
					widget.key_release_actions.extend (key_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.key_release_actions)
				end
			elseif action_sequence.is_equal ("focus_in_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.focus_in_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.focus_in_actions)
				end
			elseif action_sequence.is_equal ("focus_out_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					widget.focus_out_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.focus_out_actions)
				end
			elseif action_sequence.is_equal ("resize_actions") then
				if adding then
					geometry_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_GEOMETRY_ACTION_SEQUENCE"))
					widget.resize_actions.extend (geometry_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (widget.resize_actions)
				end
			end	
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_EV_WIDGET_ACTION_SEQUENCES

