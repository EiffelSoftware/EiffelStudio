indexing
	description:
		"Factory for execution strategies"

	status:	"See note at end of class"
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

end -- class STRATEGY_FACTORY

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
