indexing
	description: "Source code generator for direction expression"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_DIRECTION_EXPRESSION

inherit 
	ECDP_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `arguments'.
		do
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

	ready: BOOLEAN is
			-- Can `code' be called?
		do
			Result := expression /= Void and then expression.ready
		end

	type: TYPE is
			-- Type of expression
		do
			if is_byref then
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Incorrect_result, ["type from direction expression"])
				Result := expression.type -- Should be TYPED_POINTER [expression.type]
			else
				Result := expression.type
			end
		end

	is_byref: BOOLEAN
			-- Is direction "out" or "ref"?
	
	expression: ECDP_EXPRESSION
			-- Expression direction applies to
			
feature -- Element settings

	set_byref (a_bool: BOOLEAN) is
			-- Set `is_byref' with `a_bool'
		do
			is_byref := a_bool
		ensure
			is_byref_set: is_byref = a_bool
		end

	set_expression (an_expression: ECDP_EXPRESSION) is
			-- Set `expression' with `an_expression'
		require
			non_void_expression: an_expression /= Void
		do
			expression := an_expression
		ensure
			expression_set: expression = an_expression
		end
		
end -- class ECDP_DIRECTION_EXPRESSION

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