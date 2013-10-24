note
	description: "[
				{HTTP_ACCEPT_LANGUAGE_VARIANTS}.
				Represent the language results between client preferences and language variants supported by the server.
				If the server is unable to supports the requested Accept-Language values, the server can build
				a response with the list of supported languages
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_ACCEPT_LANGUAGE_VARIANTS

inherit
	HTTP_ACCEPT_VARIANTS
		rename
			variant_value as language
		end

create
	make

feature -- Change

	set_vary_header_value
			-- <Precursor>
		do
			vary_header_value := {HTTP_HEADER_NAMES}.header_accept_language -- "Accept-Language"
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
