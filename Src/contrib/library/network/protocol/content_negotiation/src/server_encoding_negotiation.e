note
	description: "Summary description for {SERVER_ENCODING_NEGOTIATION}. Utility class to support Server Side Content Negotiation on encoding"
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
	SERVER_ENCODING_NEGOTIATION

inherit
	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_encoding_dft: READABLE_STRING_8)
		do
			create accept_encoding_utilities
			set_default_encoding (a_encoding_dft)
		ensure
			default_encoding_set: default_encoding = a_encoding_dft
		end

	accept_encoding_utilities: HTTP_ANY_ACCEPT_HEADER_UTILITIES
			-- Encoding

feature -- Access: Server Side Defaults Formats

	default_encoding: READABLE_STRING_8
			--  Content-coding  that is acceptable in the response.

feature -- Change Element

	set_default_encoding (a_encoding: READABLE_STRING_8)
			-- Set `default_encoding' with `a_encoding'	
		do
			default_encoding := a_encoding
		ensure
			default_encoding_set: a_encoding = default_encoding
		end

feature -- Encoding Negotiation

	preference (a_server_encoding_supported: ITERABLE [READABLE_STRING_8]; a_header_value: detachable READABLE_STRING_8): HTTP_ACCEPT_ENCODING_VARIANTS
			-- `a_server_encoding_supported' represent a list of encoding supported by the server.
			-- `a_header_value' represent the Accept-Encoding header, ie, the client preferences.
			-- Return which Encoding to use in a response, if the server supports
			-- the requested Encoding, or empty in other case.
		note
			EIS: "name=encoding", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3", "protocol=uri"
		local
			l_compression_match: READABLE_STRING_8
		do
			create Result.make
			Result.set_supported_variants (a_server_encoding_supported)
			if a_header_value = Void or else a_header_value.is_empty then
					-- the request has no Accept-Encoding header, ie the header is empty, in this case do not compress representations
				Result.set_acceptable (True)
				Result.set_variant_value (default_encoding)
			else
				Result.set_vary_header_value

					-- select the best match, server support, client preferences
				l_compression_match := accept_encoding_utilities.best_match (a_server_encoding_supported, a_header_value)
				if l_compression_match.is_empty then
						-- The server does not support any of the compression types prefered by the client
					Result.set_acceptable (False)
				else
						-- Set the best match
					Result.set_variant_value (l_compression_match)
					Result.set_acceptable (True)
				end
			end
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
