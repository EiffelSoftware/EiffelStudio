indexing
	description:
		"Statistical information about test results"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	TEST_STATISTICS

feature -- Access

	pass_percentage: DOUBLE is
			-- Percentage of passed tests
		do
			Result := passed_tests / count * 100
		end

	fail_percentage: DOUBLE is
			-- Percentage of failed tests
		do
			Result := failed_tests / count * 100
		end

feature -- Measurement

	count: INTEGER is
			-- Number of tests
		deferred
		end
	 
	passed_tests: INTEGER is
			-- Number of passed tests
		deferred
		end
	 
	failed_tests: INTEGER is
			-- Number of failed tests
		deferred
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




end -- class TEST_STATISTICS

