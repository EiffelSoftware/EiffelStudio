class B_BASIC

feature

	empty
		do
		end

	check_false
		do
			check has_to_fail: False end
		end

	check_true
		do
			check has_to_succeed: True end
		end

	ensure_false
		do
		ensure
			has_to_fail: False
		end

	ensure_true
		do
		ensure
			has_to_succeed: True
		end

	require_false
		require
			never_called: False
		do
			check has_to_succeed: False end
		end

	assume_false
		do
			check assume: False end
			check has_to_succeed: False end
		end

end
