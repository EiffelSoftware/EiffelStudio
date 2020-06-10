note
	description: "Conneg Helper"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONNEG_HELPER


feature -- Access

	conneg (req: WSF_REQUEST): SERVER_CONTENT_NEGOTIATION
			-- Content negotiatior for all requests.
		once
			create Result.make ({HTTP_MIME_TYPES}.text_html, "en", "UTF-8", "identity")
		end

	mime_types_supported (req: WSF_REQUEST): LIST [READABLE_STRING_8]
			-- All values for Accept header that `Current' can serve.
		do
			create {ARRAYED_LIST [STRING]} Result.make_from_array (<<{HTTP_MIME_TYPES}.text_html, "application/vnd.collection+json">>)
			Result.compare_objects
		ensure
			mime_types_supported_includes_default: Result.has (conneg (req).default_media_type)
		end

	media_type_variants (req: WSF_REQUEST): HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			-- Media type negotiation.
		do
			Result := conneg (req).media_type_preference (mime_types_supported (req), req.http_accept)
		end

	compression_supported (req: WSF_REQUEST): LIST [READABLE_STRING_8]
			-- All values for Accept-Encofing header that `Current' can serve.
		do
				create {ARRAYED_LIST [STRING]} Result.make_from_array (<<"identity","deflate">>)
				Result.compare_objects
		ensure
				compression_supported_includes_default: Result.has (conneg (req).default_encoding)
		end

	compression_variants (req: WSF_REQUEST): HTTP_ACCEPT_ENCODING_VARIANTS
			-- Compression negotiation.
		do
			Result := conneg (req).encoding_preference (compression_supported (req), req.http_accept_encoding)
		end

end
