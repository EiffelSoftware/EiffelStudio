indexing
	description: "Eiffel representation of a CodeDom attach event statement"
	date: "$$"
	revision: "$$"	

class
	CODE_ATTACH_EVENT_STATEMENT

inherit
	CODE_STATEMENT

	CODE_EVENT_METHOD_KIND

create
	make

feature {NONE} -- Initialization

	make (a_event: like attached_event; a_listener: like listener) is
			-- Creation routine
		require
			non_void_event: a_event /= Void
			non_void_listener: a_listener /= Void
		do
			attached_event := a_event
			listener := a_listener
		ensure
			attached_event_set: attached_event = a_event
			listener_set: listener = a_listener
		end
		
feature -- Access
	
	attached_event: CODE_EVENT_REFERENCE_EXPRESSION 
			-- attached event

	listener: CODE_EXPRESSION
			-- event listener

	code: STRING is
			-- | Result := "`attached_event' (`listener')"
			-- Eiffel code of attach event statement
		do
			create Result.make (120)
			Result.append (indent_string)
			set_new_line (False)
			Result.append (attached_event.code)
			Result.append (adder_eiffel_name)
			Result.append (" (")
			set_new_line (False)
			Result.append (listener.code)
			Result.append (")%N")
		end

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end
		
feature {NONE} -- Implementation

	adder_eiffel_name: STRING is
			-- Eiffel name of adder method
		require
			is_in_code_generation: current_state = Code_generation
		local
			l_name: STRING
			l_type: CODE_TYPE_REFERENCE
			l_member: CODE_MEMBER_REFERENCE
		do
			create l_name.make (method_prefix (Adder).count + attached_event.event_name.count)
			l_name.append (method_prefix (Adder))
			l_name.append (attached_event.event_name)
			l_type := attached_event.target.type
			if l_type /= Void then
				l_member := l_type.member_from_name (l_name)
				if l_member /= Void then
					Result := l_member.eiffel_name
				end
			end
		end
		
invariant
	non_void_attached_event: attached_event /= Void
	non_void_listener: listener /= Void
	
end -- class CODE_ATTACH_EVENT_STATEMENT

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