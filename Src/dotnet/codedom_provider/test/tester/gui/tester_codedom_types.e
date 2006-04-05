indexing
	description: "Codedom trees types constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_CODEDOM_TYPES

feature -- Access

	Codedom_compile_unit_type: INTEGER is 1
			-- Compile unit tree

	Codedom_namespace_type: INTEGER is 2
			-- Namespace tree

	Codedom_type_type: INTEGER is 3
			-- Type tree

	Codedom_expression_type: INTEGER is 4
			-- Expression tree

	Codedom_statement_type: INTEGER is 5
			-- Statement tree

	Codedom_method_type: INTEGER is 6
			-- Method tree node
	
	Codedom_property_type: INTEGER is 7
			-- Property tree node
	
	Codedom_event_type: INTEGER is 8
			-- Event tree node
	
	Codedom_field_type: INTEGER is 9
			-- Field tree node

	Codedom_snippet_member_type: INTEGER is 10
			-- Member snippet tree node

	Codedom_type_reference_type: INTEGER is 11
			-- Type reference tree node

	Codedom_comment_type: INTEGER is 12
			-- Comment tree node

	Codedom_import_type: INTEGER is 13
			-- Namespace import tree node

feature -- Status Report

	is_valid_codedom_type (a_type: INTEGER): BOOLEAN is
			-- Is `a_type' a valid codedom type?
		do
			Result := a_type = Codedom_compile_unit_type or a_type = Codedom_namespace_type or
				a_type = Codedom_expression_type or a_type = Codedom_type_type or
				a_type = Codedom_statement_type or a_type = Codedom_method_type or
				a_type = Codedom_property_type or a_type = Codedom_event_type or
				a_type = Codedom_field_type or a_type = Codedom_snippet_member_type or
				a_type = Codedom_type_reference_type or a_type = Codedom_comment_type or
				a_type = Codedom_import_type
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


end -- class TESTER_CODEDOM_TYPES

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------