indexing
	description: "Eiffel representation of a CodeDom attach event statement"
	date: "$$"
	revision: "$$"	

class
	ECD_ATTACH_EVENT_STATEMENT

inherit
	ECD_STATEMENT
	EVENT_TYPE

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
		end
		
feature -- Access
	
	attached_event: ECD_EVENT_REFERENCE_EXPRESSION 
			-- attached event

	listener: ECD_EXPRESSION
			-- event listener

	code: STRING is
			-- | Result := "`attached_event' (`listener')"
			-- Eiffel code of attach event statement
		do
			check
				attached_event_set: attached_event /= Void
				listener_set: listener /= Void
			end

			create Result.make (120)
			Result.append (indent_string)
			set_new_line (False)
			Result.append (attached_event.code)
			Result.append (event_call)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Opening_round_bracket)
			set_new_line (False)
			Result.append (listener.code)
			Result.append (Dictionary.Closing_round_bracket)
			Result.append (Dictionary.New_line)
		end

feature -- Status Report

	ready: BOOLEAN is 
			-- Is statement ready to be generated?
		do
			Result := attached_event /= Void and then attached_event.ready
		end

feature -- Statur Setting

	set_attached_event (an_event: like attached_event) is
			-- Set `attached_event' with `an_event'
		require
			non_void_event: an_event /= Void
		do
			attached_event := an_event
		ensure
			attached_event_set: attached_event = an_event
		end

	set_listener (a_listener: like listener) is
			-- Set `a_listener' with `listener'
		require
			non_void_listener: a_listener /= Void
		do
			listener := a_listener
		ensure
			listener_set: listener = a_listener
		end

feature {NONE} -- Implementation

	event_call: STRING is
			-- Event name corresponding to attach event of `attached_event'.
		local
			l_feature_arguments: LINKED_LIST [ECD_EXPRESSION]
			feature_arguments: NATIVE_ARRAY [TYPE]
		do
			create l_feature_arguments.make
			l_feature_arguments.extend (listener)
			attached_event.set_event_type (Adder)
			attached_event.set_routine_arguments (l_feature_arguments)

			create feature_arguments.make (1)
			feature_arguments.put (0, listener.type)
			Result := Feature_finder.eiffel_feature_name_from_static_args (attached_event.target_object.type, Adder + attached_event.event_name, feature_arguments)
		ensure
			non_void_generate_event_name: Result /= Void
		end

end -- class ECD_ATTACH_EVENT_STATEMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------