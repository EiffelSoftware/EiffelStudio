note
	description: "Summary description for {SERVER_MEDIA_TYPE_NEGOTIATION}. Utility class to support Server Side Content Negotiation on media type"
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
	SERVER_MEDIA_TYPE_NEGOTIATION

inherit
	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_mediatype_dft: READABLE_STRING_8)
		do
			create accept_media_type_utilities
			set_default_media_type (a_mediatype_dft)
		ensure
			default_media_type_set: default_media_type = a_mediatype_dft
		end

	accept_media_type_utilities: HTTP_ACCEPT_MEDIA_TYPE_UTILITIES
			-- MIME

feature -- Access: Server Side Defaults Formats

	default_media_type: READABLE_STRING_8
			-- Media type which is acceptable for the response.

feature -- Change Element

	set_default_media_type (a_mediatype: READABLE_STRING_8)
			-- Set `default_media_type' with `a_mediatype'
		do
			default_media_type := a_mediatype
		ensure
			default_media_type_set: a_mediatype = default_media_type
		end

feature -- Media Type Negotiation

	preference (a_mime_types_supported: ITERABLE [READABLE_STRING_8]; a_header: detachable READABLE_STRING_8): HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			-- `a_mime_types_supported' represent media types supported by the server.
			-- `a_header represent' the Accept header, ie, the client preferences.
			-- Return which media type to use for representation in a response, if the server supports
			-- the requested media type, or empty in other case.
		note
			EIS: "name=media type", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1", "protocol=uri"
		local
			l_mime_match: READABLE_STRING_8
		do
			create Result.make
			Result.set_supported_variants (a_mime_types_supported)
			if a_header = Void or else a_header.is_empty then
					-- the request has no Accept header, ie the header is empty, in this case we use the default format
				Result.set_acceptable (True)
				Result.set_variant_value (default_media_type)
			else
				Result.set_vary_header_value

					-- select the best match, server support, client preferences
				l_mime_match := accept_media_type_utilities.best_match (a_mime_types_supported, a_header)
				if l_mime_match.is_empty then
						-- The server does not support any of the media types preferred by the client
					Result.set_acceptable (False)
				else
						-- Set the best match
					Result.set_variant_value (l_mime_match)
					Result.set_acceptable (True)
				end
			end
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
