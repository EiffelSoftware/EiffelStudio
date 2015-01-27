note
	description: "Summary description for {CMS_GENERIC_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_GENERIC_RESPONSE

feature -- Responses

	new_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; a_location: READABLE_STRING_32)
			-- Redirect to `a_location'
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_current_date
			h.put_location (a_location)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

	new_response_authenticate (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle authenticate.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_current_date
			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"CMSRoc-User%"")
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
		end

	new_response_denied (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle access denied.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
		end

	new_response_unauthorized (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle not authorized.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.forbidden)
			res.put_header_text (h.string)
		end

end
