indexing
	description:
		"Root class for validity test"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	TEST_ROOT

create

	make

feature {NONE} -- Initialization

	make (argv: ARRAY [STRING]) is
			-- Create test.
		local
			log: SCREEN_LOG
			s1: TEST_SUITE
			s2: TEST_SUITE
			drv: SIMPLE_TEST_DRIVER
			st1: PUSH_STEP
			st2: POP_STEP
			st3: POP_STEP
			stack: LINKED_STACK [INTEGER]
			e: EMPTY_STACK_EVALUATOR
			a: ARRAY [INTEGER]
			t1: EXCEPTION_TEST
			t2: TIMING_TEST
		do
			create log.make
			log.set_format ("ascii")
			create stack.make
			create st1.make
			create st2.make
			create st3.make
			create e
			st3.extend (e)
			create s1.make
			s1.set_fixture (stack)
			s1.extend (st1)
			s1.extend (st2)
			s1.extend (st3)
			a := << 1, 2, 1, 3 >>
			s1.select_strategy ("sequential")
			s1.set_context (a)
			create t1.make
			create t2.make
			create s2.make
			s2.extend (s1)
			s2.extend (t1)
			s2.extend (t2)
			s2.select_strategy ("random")
			s2.set_context (200)
			create drv.make (log)
			drv.enable_timing_display
			drv.extend (s2)
			drv.execute
			drv.evaluate
		end;

indexing

	library: "[
			EiffelTest: Library of reusable components for developping unit
			tests.
			]"

	status: "[
			Copyright 2000-2001 Interactive Software Engineering (ISE).
			]"

	license: "[
			EiffelTest may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class TEST_ROOT
