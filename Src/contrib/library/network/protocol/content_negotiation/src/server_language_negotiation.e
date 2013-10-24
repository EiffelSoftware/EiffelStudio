note
	description: "Summary description for {SERVER_LANGUAGE_NEGOTIATION}. Utility class to support Server Side Content Negotiation on language"
	date: "$Date$"
	revision: "$Revision$"
	description: "[
		Reference : http://www.w3.org/Protocols/rfc2616/rfc2616-sec12.html#sec12.1
		Server-driven Negotiation :	If the selection of the best representation for a response is made by an algorithm located at the server,
		it is called server-driven negotiation. Selection is based on the available representations of the response (the dimensions over which it can vary; e.g. language, content-coding, etc.)
		and the contents of particular header fields in the request message or on other information pertaining to the request (such as the network address of the client).
		Server-driven negotiation is advantageous when the algorithm for selecting from among the available representations is difficult to describe to the user agent,
		or when the server desires to send its "best guess" to the client along with the first response (hoping to avoid the round-trip delay of a subsequent request if the "best guess" is good enough for the user).
		In order to improve the server's guess, the user agent MAY include request header fields (Accept, Accept-Language, Accept-Encoding, etc.) which describe its preferences for such a response.
	]"
	EIS: "name=server driven negotiation", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec12.html#sec12.", "protocol=uri"

class
	SERVER_LANGUAGE_NEGOTIATION

inherit
	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_language_dft: READABLE_STRING_8)
		do
			create accept_language_utilities
			set_default_language (a_language_dft)
		ensure
			default_language_set: default_language = a_language_dft
		end

	accept_language_utilities: HTTP_ACCEPT_LANGUAGE_UTILITIES
			-- Language	

feature -- Access: Server Side Defaults Formats

	default_language: READABLE_STRING_8
			-- Natural language that is preferred as a response to the request.

feature -- Change Element

	set_default_language (a_language: READABLE_STRING_8)
			-- Set `default_language' with `a_language'
		do
			default_language := a_language
		ensure
			default_language_set: a_language = default_language
		end

feature -- Language Negotiation

	preference (a_server_language_supported: ITERABLE [READABLE_STRING_8]; a_header_value: detachable READABLE_STRING_8): HTTP_ACCEPT_LANGUAGE_VARIANTS
			-- `a_server_language_supported' represent a list of languages supported by the server.
			-- `a_header_value' represent the Accept-Language header, ie, the client preferences.
			-- Return which Language to use in a response, if the server supports
			-- the requested Language, or empty in other case.
		note
			EIS: "name=language", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4", "protocol=uri"

		local
			l_language_match: READABLE_STRING_8
		do
			create Result.make
			Result.set_supported_variants (a_server_language_supported)

			if a_header_value = Void or else a_header_value.is_empty then
					-- the request has no Accept header, ie the header is empty, in this case we use the default format
				Result.set_acceptable (True)
				Result.set_variant_value (default_language)
			else
				Result.set_vary_header_value

					-- select the best match, server support, client preferences
				l_language_match := accept_language_utilities.best_match (a_server_language_supported, a_header_value)
				if l_language_match.is_empty then
						-- The server does not support any of the media types prefered by the client
					Result.set_acceptable (False)
				else
						-- Set the best match
					Result.set_variant_value (l_language_match)
					Result.set_acceptable (True)
				end
			end
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
