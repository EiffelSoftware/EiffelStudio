indexing 
	description: "Source code generator for event reference expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"
	
class
	CODE_EVENT_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_event_name: like event_name; a_target: like target) is
			-- Creation routine
		require
			non_void_name: a_event_name /= Void
			non_void_target: a_target /= Void
		do
			event_name := a_event_name
			target := a_target
		ensure
			event_name_set: event_name = a_event_name
			target_set: target = a_target
		end
		
feature -- Access

	event_name: STRING
			-- Event name
	
	target: CODE_EXPRESSION
			-- Target object
			
	code: STRING is
			-- | Result := "`target object'.[`event_name']"
			-- In fact the `event_name' will be generate in the CODE_ATTACH_EVENT_STATEMENT or in the CODE_REMOVE_EVENT_STATEMENT
			-- Eiffel code of event reference expression
		do
			create Result.make (120)
			if new_line then
				Result.append (indent_string)
				set_new_line (False)
			end
			Result.append (target.code)
			Result.append (".")
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := None_type_reference
			Event_manager.raise_event ({CODE_EVENTS_IDS}.Incorrect_result, ["type from event reference expression"])
		end

invariant
	non_void_event_name: event_name /= Void
	non_void_target: target /= Void
		
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
end -- class CODE_EVENT_REFERENCE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------