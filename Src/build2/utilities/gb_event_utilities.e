indexing
	description: "Objects that provide useful utilities for event handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EVENT_UTILITIES
	
inherit
	
	INTERNAL
	
	GB_CONSTANTS

feature -- Basic operation.

	action_sequence_info_to_string (info: GB_ACTION_SEQUENCE_INFO): STRING is
			-- `Result' is string representation of `info'.
			-- Reverse operation of `string_to_action_sequence_info'
		require
			info_not_void: info /= Void
		do
			Result := info.name + " " + info.class_name + " " + info.feature_name
		ensure
			Result_not_void: Result /= Void
		end
		
	string_to_action_sequence_info (string: STRING): GB_ACTION_SEQUENCE_INFO is
			-- `Result' is representation of `string'.
			-- Reverse operation of `action_sequence_info_to_string'.
		require
			two_spaces: string.occurrences (' ') = 2
		local
			first_space, second_space: INTEGER
			a_name, a_class_name, a_feature_name, a_type: STRING
			action_sequences: GB_EV_ACTION_SEQUENCES
			matched_index: INTEGER
		do
			first_space := string.index_of (' ', 1)
			second_space := string.index_of (' ', first_space + 1)
			a_name := string.substring (1, first_space - 1)
			
				-- For backwards compatibility, any action sequences that have changed name
				-- must be handled here.
				-- "column_resize_actions" was renamed with CVS version 1.6 of this file so
				-- that Build no longer generated an obsolete action sequence. We change the
				-- name manually so old projects may be loaded.
			if a_name.is_equal ("column_resize_actions") then
				a_name := "column_resized_actions"
			end
			
			
			a_class_name := string.substring (first_space + 1, second_space - 1)
			a_feature_name := string.substring (second_space + 1, string.count)
				-- We must build the action sequenceas class corresponding to
				-- `class_name', so we can retrieve the type of the action
				-- sequence which is not kept in the string representation.
			action_sequences ?= new_instance_of (dynamic_type_from_string ("GB_" + a_class_name))
			check
				action_sequences_not_void: action_sequences /= Void
			end
			action_sequences.names.compare_objects
			
			matched_index := action_sequences.names.index_of (a_name, 1)
			check
				index_matched: matched_index /= 0
			end
			action_sequences.names.compare_references
			a_type := (action_sequences.types) @ matched_index
			
			create Result.make_with_details (a_name, a_class_name, a_type, a_feature_name)
		ensure
			Result_not_void: Result /= Void
		end
		
	modified_action_sequence_name (current_type: STRING; action_sequence_info: GB_ACTION_SEQUENCE_INFO): STRING is
			-- `Result' is action sequence name of `action_sequence_info' in class represented by
			-- `Current_type'. This is necessayr as in some places in the Vision2 interface, the
			-- events are renamed.
		do
			Result := action_sequence_info.name
			if current_type.is_equal (Ev_spin_button_string) then
				if action_sequence_info.class_name.is_equal ("EV_TEXT_COMPONENT_ACTION_SEQUENCES") then
					Result := "text_change_actions"
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


end -- class GB_EVENT_UTILITIES
