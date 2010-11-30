note
	description: "[
		Objects providing byte code support for testing facilities.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EXTERNALS

feature {NONE} -- Basic operations

	frozen invoke_routine (a_test_set: EQA_TEST_SET; a_body_id: INTEGER)
			-- Call arbitrary routine on given test set.
			--
			-- Note: this routine can raise an exception.
		require
			a_test_set_attached: a_test_set /= Void
			a_body_id_not_negative: a_body_id >= 0
		external
			"built_in static"
		end

	frozen override_byte_code_of_body (a_body_id: INTEGER; a_pattern_id: INTEGER; a_byte_code: POINTER; a_length: INTEGER)
			-- Store `a_byte_code' of `a_length' byte long for feature with `a_body_id'.
		require
			a_body_id_not_negative: a_body_id >= 0
			a_byte_code_attached: a_byte_code /= default_pointer
			a_length_positive: a_length > 0
		external
			"built_in static"
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
