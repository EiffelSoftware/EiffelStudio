indexing
	description:
		"Fixture accessing facility"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class FIXTURE_ACCESSOR inherit

	CALLBACK
		rename
			callback as connected_test
		redefine
			connected_test
		end

	EXCEPTIONS
		export
			{NONE} all
		end
		
create

	make

feature {NONE} -- Access

	fixture: ANY is
			-- Fixture accessor
		require
			test_has_has_fixture: connected_test.has_fixture
		do
			Result ?= connected_test.container.fixture
			if Result = Void then
				raise ("Wrong type for fixture")
			end
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation

	connected_test: TESTABLE
			-- Reference to connected test
			
end -- class FIXTURE_ACCESSOR

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
