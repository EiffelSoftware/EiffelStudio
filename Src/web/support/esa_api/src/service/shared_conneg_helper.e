note
	description: "Summary description for {SHARED_CONNEG_HELPER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONNEG_HELPER


feature -- Access

	conneg (req: WSF_REQUEST): SERVER_CONTENT_NEGOTIATION
			-- Content negotiatior for all requests
		once
			create Result.make ({HTTP_MIME_TYPES}.text_html, "en", "UTF-8", "identity")
		end

	mime_types_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept header that `Current' can serve
		do
			create {ARRAYED_LIST [STRING]} Result.make_from_array (<<{HTTP_MIME_TYPES}.text_html, "application/vnd.collection+json">>)
			Result.compare_objects
		ensure
			mime_types_supported_includes_default: Result.has (conneg (req).default_media_type)
		end

	media_type_variants (req: WSF_REQUEST): HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			-- Media type negotiation
		do
			Result := conneg (req).media_type_preference (mime_types_supported (req), req.http_accept)
		end

end
