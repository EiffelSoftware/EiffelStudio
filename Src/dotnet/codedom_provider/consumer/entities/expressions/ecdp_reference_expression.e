indexing 
	description: "Common parent of all source code generators for reference expressions"
	date: "$$"
	revision: "$$"

deferred class
	ECDP_REFERENCE_EXPRESSION

inherit 
	ECDP_EXPRESSION

feature -- Access

	arguments: LINKED_LIST [ECDP_EXPRESSION]
			-- Arguments

	code: STRING is
			-- Will never be used because not in the Eiffel Tree.
		deferred
		end

feature -- Status Report

	ready: BOOLEAN is
			-- Is entity ready to be generated?
		deferred
		end

feature -- Status Setting

	set_routine_arguments (an_argument_list: like arguments) is
			-- Set `arguments' with `an_argument_list'.
		require
			non_void_an_argument_list: an_argument_list /= Void
		do
			arguments := an_argument_list
		ensure
			arguments_set: arguments = an_argument_list
		end		

invariant
	non_void_arguments: arguments /= Void

end -- class ECDP_REFERENCE_EXPRESSION

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