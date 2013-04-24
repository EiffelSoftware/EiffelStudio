note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	EQA_OUTPUT_BUFFER

inherit
	EQA_SYSTEM_TEST_SET

feature -- Test routines

	test_output_buffer
			-- New test routine
		local
			i: INTEGER
			l_buffer_count: like buffer_count
		do
			from
				i := 1
				l_buffer_count := buffer_count
			until
				i > l_buffer_count
			loop
				print ("0123456789")
				i := i + 1
			end
		end

feature {NONE} -- Constants

	buffer_count: INTEGER = 10000

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


