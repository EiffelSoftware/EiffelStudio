indexing
	description: "Objects that provide useful utilities for event handling."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EVENT_UTILITIES
	
inherit
	
	INTERNAL

feature -- Basic operation.

	action_sequence_info_to_string (info: GB_ACTION_SEQUENCE_INFO): STRING is
			-- `Result' is string representation of `info'.
			-- Reverse operation of `string_to_action_sequence_info'
		do
			Result := info.name + " " + info.class_name + " " + info.feature_name
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
		end

end -- class GB_EVENT_UTILITIES
