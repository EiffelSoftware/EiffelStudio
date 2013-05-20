note
	description: "[
			The class provides an easy way to build HTTP header.
			
			You will also find some helper feature to help coding most common usage
			
			Please, have a look at constants classes such as
				HTTP_MIME_TYPES
				HTTP_HEADER_NAMES
				HTTP_STATUS_CODE
				HTTP_REQUEST_METHODS
			(or HTTP_CONSTANTS which groups them for convenience)
			
			Note the return status code is not part of the HTTP header
			However you can set the "Status: " header line if you want
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_HEADER

inherit
	HTTP_HEADER

create
	make,
	make_with_count,
	make_from_array,
	make_from_header,
	make_from_raw_header_data

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
