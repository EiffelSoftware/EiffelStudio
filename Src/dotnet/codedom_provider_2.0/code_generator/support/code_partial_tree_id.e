indexing 
	description: "Unique id for codedom statement or expression."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PARTIAL_TREE_ID

inherit
	HASHABLE
		redefine
			out,
			is_equal
		end
	
	CODE_PARTIAL_TREE_ID_PREFIX
		redefine
			out,
			is_equal
		end

create
	make_statement,
	make_expression,
	make_from_string


feature {NONE} -- Initialization

	make_statement is
			-- Initialize new statement id.
		do
			is_statement_id := True
			id := {GUID}.new_guid.to_string (("D").to_cil)
		end

	make_expression is
			-- Initialize new expression id.
		do
			is_expression_id := True
			id := {GUID}.new_guid.to_string (("D").to_cil)
		end

	make_from_string (a_string: STRING) is
			-- Initialize instance from string `a_string'.
			-- `a_string' should be the result of a call to `out' on a CODE_PARTIAL_TREE_ID instance.
		require
			attached_string: a_string /= Void
			valid_string: a_string.count = 40 and is_valid_id_prefix (a_string.substring (1, 4))
							and is_valid_uuid (a_string.substring (5, 40))
		local
			l_prefix: STRING
		do
			id := a_string.substring (5, 40)
			l_prefix := a_string.substring (1, 4)
			if l_prefix.is_equal (Statement_prefix) then
				is_statement_id := True
			else
				is_expression_id := True
			end
		ensure
			initialized: (is_statement_id xor is_expression_id) and id /= Void
		end

feature -- Status Report

	is_statement_id: BOOLEAN
			-- Is id a statement id?
	
	is_expression_id: BOOLEAN
			-- Is id an expression id?
	
feature -- Access

	out: STRING is
			-- Generate key as string
		do
			create Result.make (40)
			if is_statement_id then
				Result.append (Statement_prefix)
			else
				Result.append (Expression_prefix)
			end
			Result.append (id)
		end

	hash_code: INTEGER is
			-- Hash code
		do
			if internal_hash_code = 0 then
				internal_hash_code := out.hash_code
			end
			Result := internal_hash_code
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := out.is_equal (other.out)
		end

feature {NONE} -- Implementation

	id: STRING
			-- Unique id

	internal_hash_code: INTEGER
			-- Cache for hash code

invariant
	attached_id: id /= Void
	statement_xor_expression: is_statement_id xor is_expression_id

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