indexing
	description:
		"Factory producing test run results"

	status:	"See note at end of class"
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
		
end -- class RUN_RESULT_FACTORY

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
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
--|----------------------------------------------------------------------
