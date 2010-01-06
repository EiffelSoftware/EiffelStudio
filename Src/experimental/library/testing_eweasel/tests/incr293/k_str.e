deferred class
	K_STR

feature

	append_string (s: STR) is
		require
			s_not_void: s /= Void
		deferred
		ensure
			appended: current_string.is_equal (old cloned_string (current_string) + old cloned_string (s))
		end

	current_string: STR is
			-- Current string
		do
		end

	cloned_string (a_string: STR): STR is
			-- Clone of `a_string'
		do
		end

end
