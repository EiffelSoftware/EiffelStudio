note
	description: "[
				{HTTP_ACCEPT_CHARSET_VARIANTS}
				Represent the character sets results between client preferences and character sets variants supported by the server.
				If the server is unable to supports the requested Accept-Charset values, the server can build
				a response with the list of supported character sets.
			]"

	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_ACCEPT_CHARSET_VARIANTS

inherit
	HTTP_ACCEPT_VARIANTS
		rename
			variant_value as charset
		end

create
	make

feature -- Change

	set_vary_header_value
			-- <Precursor>
		do
			vary_header_value := {HTTP_HEADER_NAMES}.header_accept_charset -- "Accept-Charset"
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
