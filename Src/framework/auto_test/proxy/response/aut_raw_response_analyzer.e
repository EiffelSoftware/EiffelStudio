note
	description: "[
		Raw response analyzer.
		It parses the raw response retrieved from interpreter, and put them
		into a more detailed form.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_RAW_RESPONSE_ANALYZER

feature -- Access

	raw_response: AUT_RAW_RESPONSE
			-- Raw response

	response: AUT_RESPONSE
			-- More detailed response from `raw_response'
		local
			l_summary: STRING
		do
			l_summary := raw_response_summary

			if is_normal_response then
				if has_valid_testee_error then
					create {AUT_NORMAL_RESPONSE} Result.make_exception (l_summary, exception_from_error)
				else
					create {AUT_NORMAL_RESPONSE} Result.make (l_summary)
				end
			elseif is_error_response then
				create {AUT_ERROR_RESPONSE} Result.make (raw_response.error)
			else
				check is_bad_response end
				create {AUT_BAD_RESPONSE} Result.make (l_summary)
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_error_response: BOOLEAN
			-- Is Current response an error message?
		do
			Result :=
				not is_bad_response and then
				has_valid_interpreter_error
		end

	is_bad_response: BOOLEAN
			-- Is Current response not syntactially well formed?
		local
			l_raw_response: like raw_response
		do
			l_raw_response := raw_response

			Result :=
				l_raw_response = Void or else
				l_raw_response.output = Void or else
				l_raw_response.error = Void
		end

	has_valid_interpreter_error: BOOLEAN
			-- Does `raw_response' contains a valid interpreter error message?
		require
			not_bad: not is_bad_response
		do
			Result := raw_response /= Void and then raw_response.is_interpreter_error
		ensure
			good_result: Result = (raw_response /= Void and then raw_response.is_interpreter_error)
		end

	has_valid_testee_error: BOOLEAN
			-- Does `raw_response' contains a valid exception trace from a testee feature?
		require
			not_bad: not is_bad_response
		do
			Result :=
				raw_response /= Void and then
				not raw_response.is_interpreter_error and then
				raw_response.error /= Void and then
				not raw_response.error.is_empty
		end

	is_normal_response: BOOLEAN
			-- Is response a normal response?
		do
			Result :=
				not is_bad_response and then
				not has_valid_interpreter_error
		end

feature -- Setting

	set_raw_response (a_raw_response: like raw_response)
			-- Set `raw_response' with `a_raw_response'.
		do
			raw_response := a_raw_response
		end

feature{NONE} -- Implementation

	raw_response_summary: STRING
			-- Summary for `raw_response'
		do
			if raw_response /= Void and then raw_response.output /= Void then
				Result := raw_response.output.twin
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

	exception_from_error: AUT_EXCEPTION
			-- Exception from error
		require
			raw_response_is_normal: is_normal_response
			raw_response_has_trace: has_valid_testee_error
		local
			l_message: STRING
			l_reader: KL_STRING_INPUT_STREAM
			l_exception_code: INTEGER
			l_recipient_name: STRING
			l_recipient_class_name: STRING
			l_tag_name: STRING
			l_trace: STRING
			l_inv_on_entry: BOOLEAN
		do
			l_message := raw_response.error
			create l_reader.make (l_message)

				-- Read exception code.
			if not l_reader.end_of_input then
				l_reader.read_line
				if l_reader.last_string.is_integer then
					l_exception_code := l_reader.last_string.to_integer
				end
			end

				-- Read recipient.
			if not l_reader.end_of_input then
				l_reader.read_line
				l_recipient_name := l_reader.last_string.twin
			else
				l_recipient_name := ""
			end

				-- Read recipient class.
			if not l_reader.end_of_input then
				l_reader.read_line
				l_recipient_class_name := l_reader.last_string.twin
			else
				l_recipient_class_name := ""
			end

				-- Read tag.
			if not l_reader.end_of_input then
				l_reader.read_line
				l_tag_name := l_reader.last_string.twin
			else
				l_tag_name := ""
			end

				-- Read invariant violation flag
			if not l_reader.end_of_input then
				l_reader.read_line
				if l_reader.last_string.is_boolean then
					l_inv_on_entry := l_reader.last_string.to_boolean
				end
			end

				-- Read trace.
			from
				create l_trace.make (2048)
			until
				l_reader.end_of_input
			loop
				l_reader.read_line
				l_trace.append (l_reader.last_string)
				l_trace.append (new_line_string)
			end

			create Result.make (l_exception_code, l_recipient_name, l_recipient_class_name, l_tag_name, l_inv_on_entry, l_trace)
		end

feature{NONE} -- Constants

	default_summary_length: INTEGER = 1024
			-- Default size in byte for raw response summary

	new_line_string: STRING = "%N"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
