indexing
	description:
		"Fixture accessing facility"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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

	connected_test: TESTABLE;
			-- Reference to connected test
			
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




end -- class FIXTURE_ACCESSOR

