indexing
	description: "Codedom trees types constants"
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

	Custom_attribute_type: INTEGER is 14
			-- Custom attribute tree node

	Custom_attribute_argument_type: INTEGER is 15
			-- Custom attribute argument

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
				a_type = Codedom_import_type or a_type = Custom_attribute_type or
				a_type = Custom_attribute_argument_type
		end

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
