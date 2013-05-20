note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_FORCE_DOWNLOAD_RESPONSE

inherit
	WSF_DOWNLOAD_RESPONSE
		redefine
			get_content_type
		end

create
	make

feature {NONE} -- Implementation

	get_content_type
		do
			content_type := {HTTP_MIME_TYPES}.application_force_download
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
