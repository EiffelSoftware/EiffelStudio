class A

feature

	inherited_no_precondition
		do
		end

	inherited_true_precondition
		require
			true
		do
		end

	inherited_false_precondition
		require
			false
		do
		end

	inherited_some_precondition
		require
			Current.out /= out
		do
		end

	no_no_precondition
		do
		end

	no_true_precondition
		require
			true
		do
		end

	no_false_precondition
		require
			false
		do
		end

	no_some_precondition
		require
			Current.out /= out
		do
		end

	true_no_precondition
		do
		end

	true_true_precondition
		require
			true
		do
		end

	true_false_precondition
		require
			false
		do
		end

	true_some_precondition
		require
			Current.out /= out
		do
		end

	false_no_precondition
		do
		end

	false_true_precondition
		require
			true
		do
		end

	false_false_precondition
		require
			false
		do
		end

	false_some_precondition
		require
			Current.out /= out
		do
		end

end