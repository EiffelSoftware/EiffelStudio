indexing
	description: "Source code generator for direction expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_DIRECTION_EXPRESSION

inherit 
	CODE_EXPRESSION

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_expression: like expression; a_is_byref: like is_byref) is
			-- Initialize instance.
		require
			non_void_expression: a_expression /= Void
		do
			expression := a_expression
			is_byref := a_is_byref
		ensure
			expression_set: expression = a_expression
			is_byref_set: is_byref = a_is_byref
		end

feature -- Access

	code: STRING is
			-- | Result := "$expression" if is_byref
			-- | Result := "expression" otherwise
			-- Eiffel code of direction expression
		local
			l_code: STRING
		do
			l_code := expression.code
			if is_byref then
				create Result.make (1 + l_code.count)
				Result.append_character ('$')
				Result.append (l_code)
			else
				Result := l_code
			end
		end

	type: CODE_TYPE_REFERENCE is
			-- Type of expression
		do
			if is_byref then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Incorrect_result, ["type from direction expression"])
				Result := expression.type -- Should be TYPED_POINTER [expression.type]
			else
				Result := expression.type
			end
		end

	is_byref: BOOLEAN
			-- Is direction "out" or "ref"?
	
	expression: CODE_EXPRESSION
			-- Expression direction applies to

invariant
	non_void_expression: expression /= Void

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


end -- class CODE_DIRECTION_EXPRESSION

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