indexing
	description: "Source code generator for direction expression"
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