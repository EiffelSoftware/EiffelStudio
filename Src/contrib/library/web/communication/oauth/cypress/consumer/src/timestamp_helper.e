note
	description: "Summary description for {TIMESTAMP_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TIMESTAMP_HELPER

inherit
	HTTP_DATE_TIME_UTILITIES

feature -- Access

	timestamp_now_utc: INTEGER_64
		do
			Result := unix_time_stamp (Void)
		end

note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
