note
	description: "Summary description for {SERVER_CONTENT_NEGOTIATION}. Utility class to support Server Side Content Negotiation "
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
	SERVER_CONTENT_NEGOTIATION

inherit
	SERVER_MEDIA_TYPE_NEGOTIATION
		rename
			make as make_media_type,
			preference as media_type_preference
		end

	SERVER_LANGUAGE_NEGOTIATION
		rename
			make as make_language,
			preference as language_preference
		end

	SERVER_CHARSET_NEGOTIATION
		rename
			make as make_charset,
			preference as charset_preference
		end

	SERVER_ENCODING_NEGOTIATION
		rename
			make as make_encoding,
			preference as encoding_preference
		end

create
	make

feature {NONE} -- Initialization

	make (a_mediatype_dft: READABLE_STRING_8; a_language_dft: READABLE_STRING_8; a_charset_dft: READABLE_STRING_8; a_encoding_dft: READABLE_STRING_8)
			-- Initialize Current with default Media type, language, charset and encoding.
		do
			make_media_type (a_mediatype_dft)
			make_language (a_language_dft)
			make_charset (a_charset_dft)
			make_encoding (a_encoding_dft)
		ensure
			default_media_type_set: default_media_type = a_mediatype_dft
			default_language_set: default_language = a_language_dft
			default_charset_set: default_charset = a_charset_dft
			default_encoding_set: default_encoding = a_encoding_dft
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
