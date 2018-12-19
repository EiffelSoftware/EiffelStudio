note
	description: "Summary description for {SSL_SHARED_EXCEPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_SHARED_EXCEPTIONS

feature -- Exception

	raise_exception (a_description: STRING_8)
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			create l_exception
			l_exception.set_description (generator + ": " + a_description )
			l_exception.raise
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
