note
	description: "Logging facilities component"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_LOGGER

feature -- Logs

	log (a_message: separate READABLE_STRING_8)
			-- Log `a_message'
		deferred
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
