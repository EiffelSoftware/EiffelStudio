indexing 
	description: "Unique id prefix for codedom statement or expression."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PARTIAL_TREE_ID_PREFIX

feature -- Access

	Statement_prefix: STRING is "`ST:"
			-- Prefix for statement ID

	Expression_prefix: STRING is "`EX:"
			-- Prefix for expression ID


feature -- Status Report

	is_valid_id_prefix (a_prefix: STRING): BOOLEAN is
			-- Is `a_prefix' a valid ID prefix?
		do
			if a_prefix /= Void then
				Result := a_prefix.is_equal (Statement_prefix) or a_prefix.is_equal (Expression_prefix)
			end
		end
	
	is_valid_uuid (a_string: STRING): BOOLEAN is
			-- Is `a_string' a valid uuid?
		require
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
		do
			if a_string.count /= 36 then
				Result := False
			else
				Result := True
				from
					i := 1
				until
					not Result or i > 36
				loop
					if i = 9 or i = 14 or i = 19 or i = 24 then
						Result := a_string.item (i) = '-'
					else
						Result := a_string.item (i).is_hexa_digit
					end
					i := i +1
				end
			end
		end

invariant
	valid_statement_prefix: is_valid_id_prefix (Statement_prefix)
	valid_expression_prefix: is_valid_id_prefix (Expression_prefix)

end -- class CODE_PARTIAL_TREE_ID

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