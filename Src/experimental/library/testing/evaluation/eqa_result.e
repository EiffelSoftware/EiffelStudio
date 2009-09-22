note
	description: "[
		Abstract description of a test result.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_RESULT

feature -- Access

	start_date: DATE_TIME
			-- Date/time when test was launched
		deferred
		ensure
			result_attached: Result /= Void
		end

	finish_date: DATE_TIME
			-- Date and time when `Current' was obtained
		deferred
		ensure
			result_attached: Result /= Void
		end

	frozen duration: DATE_TIME_DURATION
			-- Duration of test execution
		do
			Result := finish_date.relative_duration (start_date)
		ensure
			result_attached: Result /= Void
		end

	tag: READABLE_STRING_8
			-- Short tag describing status of `Current'
		deferred
		ensure
			result_attached: Result /= Void
		end

	information: READABLE_STRING_8
			-- More detailed information regarding the test result
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_pass: BOOLEAN
			-- Did test pass?
		deferred
		ensure
			result_implies_not_fail_or_unresolved: Result implies not (is_fail or is_unresolved)
		end

	is_fail: BOOLEAN
			-- Did test fail?
		deferred
		ensure
			result_implies_not_pass_or_unresolved: Result implies not (is_pass or is_unresolved)
		end

	is_unresolved: BOOLEAN
			-- Is test judgment unresolvable?
		do
			Result := not (is_pass or is_fail)
		ensure
			definition: Result = not (is_pass or is_fail)
		end

invariant
	pass_or_fail_or_unresolved: is_pass or is_fail or is_unresolved

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
