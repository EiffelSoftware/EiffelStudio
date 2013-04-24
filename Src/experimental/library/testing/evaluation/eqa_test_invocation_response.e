note
	description: "[
		Represents the result from executing one of the stages in an Eiffel test.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_INVOCATION_RESPONSE

create
	make, make_exceptional

feature {NONE} -- Initialization

	make
			-- Create new normal response.
		do
		ensure
			not_exceptional: not is_exceptional
		end

	make_exceptional (an_exception: like exception)
			-- Create new exceptional response.
		do
			internal_exception := an_exception
		ensure
			exceptional: is_exceptional
			exception_set: exception = an_exception
		end

feature -- Access

	exception: EQA_TEST_INVOCATION_EXCEPTION
			-- Exception thrown during the execution
		require
			exceptional: is_exceptional
		local
			l_exception: like internal_exception
		do
			l_exception := internal_exception
			check l_exception /= Void end
			Result := l_exception
		end

feature {NONE} -- Access

	internal_exception: detachable like exception
			-- Internal storage for `exception'

feature -- Status report

	is_exceptional: BOOLEAN
			-- Has an exception been thrown during the execution?
		do
			Result := internal_exception /= Void
		end

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
