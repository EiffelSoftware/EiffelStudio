indexing
	description: "Objects that represent the different kind of event methods."
	legal: "See notice at end of class."
	status: "See notice at end of class."

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