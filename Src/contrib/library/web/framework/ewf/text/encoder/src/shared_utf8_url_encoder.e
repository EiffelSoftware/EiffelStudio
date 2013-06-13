note
	description: "Objects to access the shared once UTF8_URL_ENCODER ..."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_UTF8_URL_ENCODER

feature -- Encoder

	url_encoder: UTF8_URL_ENCODER
			-- Shared UTF8 URL encoder.
		once
			create Result
		end

note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
