note
	description: "Summary description for {TEST_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTION

inherit
	WSF_EXECUTION

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature -- Execution

	execute
		local
			s: STRING
			i64: INTEGER_64
		do
			i64 := {INTEGER_64} 1_000_000_000
			s := "Test Concurrent EWF ["
			s.append (request.percent_encoded_path_info)
			s.append ("] (counter=")
			s.append_integer (next_cell_counter_item (counter_cell))
			s.append (")%N")

			if attached {WSF_STRING} request.query_parameter ("sleep") as p_sleep then
				if attached p_sleep.value.is_integer then
					s.append ("sleep for ")
					i64 := p_sleep.value.to_integer_64 * ({INTEGER_64} 1_000_000_000)
					s.append_integer_64 (i64)
					execution_environment.sleep (i64)
				end
			end

			response.set_status_code (200)
			response.put_header_line ("X-EWF-Dev: v1.0")
			response.header.put_content_type_text_plain
			response.header.put_content_length (s.count)

			response.put_string (s)
		end

	next_cell_counter_item (cl: like counter_cell): INTEGER
		do
			Result := cl.next_item
		end

	counter_cell: separate TEST_COUNTER
		once ("PROCESS")
			create Result.put (0)
		end


note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
