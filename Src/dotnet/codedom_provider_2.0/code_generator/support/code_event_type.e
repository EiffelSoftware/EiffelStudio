indexing
	description: "Objects that represent the different kind of event methods."

class
	CODE_EVENT_METHOD_KIND

feature -- Access

	Adder: INTEGER is 1
			-- Method to add an event handler
	
	Remover: INTEGER is 2
			-- Method to remove an event handler
	
	Raiser: INTEGER is 3
			-- Method to raise an event

	method_prefix (a_kind: INTEGER): STRING is
			-- Prefix for event methods of kind `a_kind'
		require
			valid_event_method_kind (a_kind)
		do
			Result := Event_methods_prefixes.item (a_kind)
		end
		
feature {NONE} -- Implementation

	Event_methods_prefixes: ARRAY [STRING] is
			-- Event methods prefixes
		once
			Result := <<"add_", "remove_", "raise_">>
		end
		
feature -- Status Repport

	valid_event_method_kind (a_kind: INTEGER): BOOLEAN is
			-- Is `a_kind' a valid event method kind?
		do
			Result := (a_kind >= Adder) and (a_kind <= Raiser)
		end

end -- class CODE_EVENT_METHOD_KIND

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