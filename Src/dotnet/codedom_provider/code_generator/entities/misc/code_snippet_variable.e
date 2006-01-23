indexing
	description: "Variable reference with resolved Eiffel name and Eiffel type name"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	note: "Instances of this class are used for code snippets, any other variable reference%
			%should use instances of CODE_VARIABLE_REFERENCE"

class
	CODE_SNIPPET_VARIABLE

inherit
	CODE_ENTITY

create
	make
	
feature {NONE} -- Initialization

	make (a_eiffel_name, a_eiffel_type_name: STRING) is
			-- Set `eiffel_name' with `a_eiffel_name' and `eiffel_type_name' with `a_eiffel_type_name'.
		require
			non_void_eiffel_name: a_eiffel_name /= Void
			non_void_eiffel_type_name: a_eiffel_type_name /= Void
		do
			eiffel_name := a_eiffel_name
			eiffel_type_name := a_eiffel_type_name
		ensure
			eiffel_name_set: eiffel_name = a_eiffel_name
			eiffel_type_name_set: eiffel_type_name = a_eiffel_type_name
		end

feature -- Access

	eiffel_name: STRING
			-- Eiffel variable name

	eiffel_type_name: STRING
			-- Eiffel variable type name

	code: STRING is
			-- Local declaration
		do
			create Result.make (200)
			Result.append (Indent_string)
			Result.append (eiffel_name)
			Result.append (": ")
			Result.append (eiffel_type_name)
		end
	
invariant
	non_void_eiffel_name: eiffel_name /= Void
	non_void_eiffel_type_name: eiffel_type_name /= Void

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


end -- class CODE_SNIPPET_VARIABLE

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