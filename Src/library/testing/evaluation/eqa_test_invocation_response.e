note
	description: "[
		Represents the result from executing one of the stages in an Eiffel test.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_INVOCATION_RESPONSE

inherit
	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

create
	make_normal, make_exceptional

feature {NONE} -- Initialization

	make_normal (an_output: like output)
			-- Create new normal response.
		do
			output := an_output
		ensure
			output_set: output = an_output
			not_exceptional: not is_exceptional
		end

	make_exceptional (an_output: like output; an_exception: like exception)
			-- Create new exceptional response.
		do
			output := an_output
			internal_exception := an_exception
		ensure
			output_set: output = an_output
			exceptional: is_exceptional
			exception_set: exception = an_exception
		end

feature -- Query

	is_exceptional: BOOLEAN
			-- Has an exception been thrown during the execution?
		do
			Result := internal_exception /= Void
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

	output: STRING
			-- Output produced by test

feature {NONE} -- Access

	internal_exception: detachable like exception
			-- Internal storage for `exception'

	output_name: STRING = "output"
	internal_exception_name: STRING = "internal_exception"
			-- Name of attributes in `Current'

feature -- Mismatch Correnction

	correct_mismatch
			-- <Precursor>
		do
			if attached {like output} mismatch_information.item (output_name) as l_output then
				output := l_output
				if attached {like exception} mismatch_information.item (internal_exception_name) as l_exception then
					internal_exception := l_exception
				end
			else
				Precursor
			end
		end

;note
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
