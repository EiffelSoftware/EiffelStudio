note
	description: "Summary description for {SERVER_CHARSET_NEGOTIATION}. Utility class to support Server Side Content Negotiation on charset "
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
	SERVER_CHARSET_NEGOTIATION

inherit
	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_charset_dft: READABLE_STRING_8)
		do
			create accept_charset_utilities
			set_default_charset (a_charset_dft)
		ensure
			default_charset_set: default_charset = a_charset_dft
		end

	accept_charset_utilities: HTTP_ANY_ACCEPT_HEADER_UTILITIES
			-- Charset

feature -- Access: Server Side Defaults Formats

	default_charset: READABLE_STRING_8
			-- Character set that is  acceptable for the response.

feature -- Change Element

	set_default_charset (a_charset: READABLE_STRING_8)
			-- Set `default_charset' with `a_charset'
		do
			default_charset := a_charset
		ensure
			default_charset_set: a_charset = default_charset
		end

feature -- Charset Negotiation

	preference (a_server_charset_supported: ITERABLE [READABLE_STRING_8]; a_header: detachable READABLE_STRING_8): HTTP_ACCEPT_CHARSET_VARIANTS
			-- `a_server_charset_supported' represent a list of character sets supported by the server.
			-- `a_header' represents the Accept-Charset header, ie, the client preferences.
			-- Return which Charset to use in a response, if the server supports
			-- the requested Charset, or empty in other case.
		note
			EIS: "name=charset", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.2", "protocol=uri"
		local
			l_charset_match: READABLE_STRING_8
		do
			create Result.make
			Result.set_supported_variants (a_server_charset_supported)
			if a_header = Void or else a_header.is_empty then
					-- the request has no Accept-Charset header, ie the header is empty, in this case use default charset encoding
				Result.set_acceptable (True)
				Result.set_variant_value (default_charset)
			else
				Result.set_vary_header_value

					-- select the best match, server support, client preferences
				l_charset_match := accept_charset_utilities.best_match (a_server_charset_supported, a_header)
				if l_charset_match.is_empty then
						-- The server does not support any of the compression types prefered by the client
					Result.set_acceptable (False)
				else
						-- Set the best match
					Result.set_variant_value (l_charset_match)
					Result.set_acceptable (True)
				end
			end
		end


note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
