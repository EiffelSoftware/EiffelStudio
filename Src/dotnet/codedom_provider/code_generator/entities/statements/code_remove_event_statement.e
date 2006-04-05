indexing
	description: "Eiffel representation of a CodeDom remove event statement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"		
	
class
	CODE_REMOVE_EVENT_STATEMENT

inherit
	CODE_STATEMENT

	CODE_EVENT_METHOD_KIND

create
	make

feature {NONE} -- Initialization

	make (a_event: like removed_event; a_listener: like listener) is
			-- Creation routine
		require
			non_void_event: a_event /= Void
			non_void_listener: a_listener /= Void
		do
			removed_event := a_event
			listener := a_listener
		ensure 
			removed_event_set: removed_event = a_event
			listener_set: listener = a_listener
		end		
feature -- Access

	removed_event: CODE_EVENT_REFERENCE_EXPRESSION
			-- remove event
	
	listener: CODE_EXPRESSION
			-- event listener
			
	code: STRING is
			-- | Result := "`removed_event' (`listener')"
			-- Eiffel code of remove event statement
		do
			create Result.make (120)
			Result.append (indent_string)
			set_new_line (False)
			Result.append (removed_event.code)
			Result.append (remover_eiffel_name)
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

	remover_eiffel_name: STRING is
			-- Eiffel name of adder method
		require
			is_in_code_generation: current_state = Code_generation
		local
			l_name: STRING
		do
			create l_name.make (method_prefix (Remover).count + removed_event.event_name.count)
			l_name.append (method_prefix (Remover))
			l_name.append (removed_event.event_name)
			Result := removed_event.target.type.member_from_name (l_name).eiffel_name
		end

invariant
	non_void_removed_event: removed_event /= Void
	non_void_listener: listener /= Void

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


end -- class CODE_REMOVE_EVENT_STATEMENT

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