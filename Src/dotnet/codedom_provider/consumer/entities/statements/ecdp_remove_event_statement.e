indexing
	description: "Eiffel representation of a CodeDom remove event statement"
	date: "$$"
	revision: "$$"		
	
class
	ECDP_REMOVE_EVENT_STATEMENT

inherit
	ECDP_STATEMENT
	EVENT_TYPE

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
		end
		
feature -- Access

	removed_event: ECDP_EVENT_REFERENCE_EXPRESSION
			-- remove event
	
	listener: ECDP_EXPRESSION
			-- event listener
			
	code: STRING is
			-- | Result := "`removed_event' (`listener')"
			-- Eiffel code of remove event statement
		do
			check
				removed_event_set: removed_event /= Void
				listener_set: listener /= Void
			end

			create Result.make (120)
			Result.append (indent_string)
			set_new_line (False)
			Result.append (removed_event.code)
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
			Result := listener /= Void and then listener.ready and removed_event /= Void and then removed_event.ready
		end

feature -- Statur Setting

	set_removed_event (an_event: like removed_event) is
			-- Set `removed_event' with `an_event'
		require
			non_void_an_event: an_event /= Void
		do
			removed_event := an_event
		ensure
			removed_event_set: removed_event = an_event
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
			-- Event name corresponding to remove event of `attached_event'.
		local
			l_feature_arguments: LINKED_LIST [ECDP_EXPRESSION]
			feature_arguments: NATIVE_ARRAY [TYPE]
		do
			create l_feature_arguments.make
			l_feature_arguments.extend (listener)
			removed_event.set_event_type (Remover)
			removed_event.set_routine_arguments (l_feature_arguments)

			create feature_arguments.make (1)
			feature_arguments.put (0, listener.type)
			Result := Eiffel_types.eiffel_feature_name_from_static_args (removed_event.target_object.type, Remover + removed_event.event_name, feature_arguments)	
		end

end -- class ECDP_REMOVE_EVENT_STATEMENT

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