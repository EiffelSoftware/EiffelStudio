indexing
	description:
		"Root class for validity test"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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


end -- class TEST_ROOT

