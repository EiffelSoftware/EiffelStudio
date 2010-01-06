class 
	TEST

inherit
	A
		redefine
			no_no_precondition,
			no_true_precondition,
			no_false_precondition,
			no_some_precondition,
			true_no_precondition,
			true_true_precondition,
			true_false_precondition,
			true_some_precondition,
			false_no_precondition,
			false_true_precondition,
			false_false_precondition,
			false_some_precondition
		end

create
	inherited_no_precondition,
	inherited_true_precondition,
	inherited_false_precondition,
	inherited_some_precondition,
	no_no_precondition,
	no_true_precondition,
	no_false_precondition,
	no_some_precondition,
	true_no_precondition,
	true_true_precondition,
	true_false_precondition,
	true_some_precondition,
	false_no_precondition,
	false_true_precondition,
	false_false_precondition,
	false_some_precondition

feature {NONE} -- Creation

	no_no_precondition
		do
		end

	no_true_precondition
		do
		end

	no_false_precondition
		do
		end

	no_some_precondition
		do
		end

	true_no_precondition
		require else
			true
		do
		end

	true_true_precondition
		require else
			true
		do
		end

	true_false_precondition
		require else
			true
		do
		end

	true_some_precondition
		require else
			true
		do
		end

	false_no_precondition
		require else
			false
		do
		end

	false_true_precondition
		require else
			false
		do
		end

	false_false_precondition
		require else
			false
		do
		end

	false_some_precondition
		require else
			false
		do
		end

end
