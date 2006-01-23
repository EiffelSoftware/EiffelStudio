indexing
	description: "Variable used in code, could be argument or local variable."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"	

class
	CODE_VARIABLE
	
inherit
	CODE_ENTITY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_variable: CODE_VARIABLE_REFERENCE) is
			-- Initialize instance with arguments.
		require
			non_void_variable: a_variable /= Void
		do
			variable := a_variable
		ensure
			variable_set: variable = a_variable
		end
		
feature -- Access

	variable: CODE_VARIABLE_REFERENCE
			-- Corresponding variable reference
		
	code: STRING is
			-- Type source code
		do
			Result := variable.eiffel_name
		end

	declaration_code: STRING is
			-- Result := "name: SYSTEM_TYPE"
		do
			create Result.make (100)
			Result.append (Indent_string)
			Result.append (variable.eiffel_name)
			Result.append (": ")
			Result.append (variable.type.eiffel_name)
			Result.append ("%N")
		end

feature -- Comparison

	is_equal (other: CODE_VARIABLE): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := other.variable.is_equal (variable)
		end

invariant
	non_void_variable: variable /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CODE_VARIABLE

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