indexing
	description:
		"Single test steps that can be added to a test suite"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_STEP inherit

	SINGLE_TEST
		undefine
			copy, is_equal
		redefine
			run_without_rescue
		end

	BASIC_CONTAINER [EVALUATOR]
		undefine
			copy, is_equal
		end

	ARRAYED_ADAPTER [EVALUATOR]
		rename
			make as list_make, index as evaluator, go_i_th as set_evaluator
		export
			{NONE} all
		redefine
			extend, remove
		end

feature {NONE} -- Initialization

	make is
			-- Create test step.
		do
			list_make (0)
		end

feature -- Status report

	Is_complete_test: BOOLEAN is False
			-- Is test a complete test? (Answer: no)

	Top_level_allowed: BOOLEAN is False
			-- Can test be inserted in the top level of test hierarchy?
			-- (Answer: no)

	produces_result: BOOLEAN is
			-- Does test produce result?
		do
			Result := not is_empty
		end

	insertable (v: EVALUATOR): BOOLEAN is
			-- Can evaluator `v' be inserted?
		do
			Result := True
		end
		
feature -- Element change

	extend (v: EVALUATOR) is
			-- Add evaluator `v' at end.
		do
			if test_results = Void then create test_results.make end
			v.set_name (Name_prefix + (count + 1).out)
			v.set_test_step (Current)
			Precursor (v)
		ensure then
			evaluator_complete: v.is_setup_ok
			result_counter_created: test_results /= Void
		end


feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th item.
		do
			Precursor (i)
			if is_empty then test_results := Void end
		ensure then
			empty_implies_no_result: is_empty implies test_results = Void
		end

feature {NONE} -- Constants

	Name_prefix: STRING is "Evaluator #"
			-- Name prefix for evaluators
			
feature {NONE} -- Implementation

	run_without_rescue is
			-- Run without exception trapping.
		do
			Precursor
			if produces_result then
				from start until after loop
					assert (item.is_true, item.name)
					forth
				end
			end
		end

invariant

	evaluators_produce_result: not is_empty = produces_result

end -- class TEST_STEP

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
