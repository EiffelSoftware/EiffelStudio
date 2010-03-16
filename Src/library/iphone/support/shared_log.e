note
	description: "Log facilities"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOG

feature -- Output

	put_string (a_str: detachable STRING)
		do
			if a_str /= Void then
				file.put_string (a_str)
				file.flush
			end
		end

feature {NONE} -- Implementation

	file: PLAIN_TEXT_FILE
		once
			create Result.make_open_append ("/tmp/eiffel_iphone.log")
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
