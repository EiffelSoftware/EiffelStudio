note
	description: "[
				{HTTP_ACCEPT_MEDIA_TYPE_VARIANTS}. 
				Represents the media type results between client preferences and media type variants supported by the server..
				If the server is unable to supports the requested Accept values, the server can build
				a response with the list of supported representations
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_ACCEPT_MEDIA_TYPE_VARIANTS

inherit
	HTTP_ACCEPT_VARIANTS
		rename
			variant_value as media_type
		end

create
	make

feature -- Change

	set_vary_header_value
			-- <Precursor>
		do
			vary_header_value := {HTTP_HEADER_NAMES}.header_accept -- "Accept"
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
