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

feature -- Status Report

	is_valid_codedom_type (a_type: INTEGER): BOOLEAN is
			-- Is `a_type' a valid codedom type?
		do
			Result := a_type = Codedom_compile_unit_type or a_type = Codedom_namespace_type or
				a_type = Codedom_expression_type or a_type = Codedom_type_type or
				a_type = Codedom_statement_type
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