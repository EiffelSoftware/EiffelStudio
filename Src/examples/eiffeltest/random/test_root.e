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

	make (argv: ARRAY[STRING]) is
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

end -- class TEST_ROOT

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
