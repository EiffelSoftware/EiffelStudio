indexing
	description:
		"Factory producing test run results"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	RUN_RESULT_FACTORY

feature {NONE} -- Initialization

	run_result_factory: HASHED_PROTOTYPE_FACTORY [TEST_RUN_RESULT] is
			-- Singleton of run result factory
		local
			r: TEST_RUN_RESULT
		once
			create Result.make
			create r.make_pass; Result.extend (r, "T")
			create r.make_failure; Result.extend (r, "F")
			create r.make_exception; Result.extend (r, "E")
		ensure
			not_empty: Result /= Void and then not Result.is_empty
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class RUN_RESULT_FACTORY

