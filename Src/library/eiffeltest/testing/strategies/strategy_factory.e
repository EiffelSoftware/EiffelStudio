indexing
	description:
		"Factory for execution strategies"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	STRATEGY_FACTORY

feature {NONE} -- Initialization

	strategy_factory: HASHED_PROTOTYPE_FACTORY [EXECUTION_STRATEGY] is
			-- Singleton of strategy factory
		local
			e: EXECUTION_STRATEGY
		once
			create Result.make
			create {LINEAR_ACCESS_STRATEGY} e
			Result.extend (e, "linear")
			create {SINGLE_TEST_STRATEGY} e
			Result.extend (e, "single")
			create {RANDOM_ACCESS_STRATEGY} e
			Result.extend (e, "random")
			create {RANDOM_N_TIMES_STRATEGY} e
			Result.extend (e, "n-times")
			create {SEQUENTIAL_EXECUTION_STRATEGY} e
			Result.extend (e, "sequential")
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




end -- class STRATEGY_FACTORY

