note
	description: "Response message interface specific to the CMS component."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_RESPONSE_MESSAGE

inherit
	WSF_RESPONSE_MESSAGE

feature {NONE} -- Initialization

	initialize
		do
			status_code := {HTTP_STATUS_CODE}.ok
			create header.make_with_count (2)
			header.put_current_date
			header.put_content_type_utf_8_text_html
		end

feature -- Access

	status_code: INTEGER
			-- Status code for the response.

	header: HTTP_HEADER
			-- Header associated with the response.

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
			-- <Precursor>
		do
			res.set_status_code (status_code)

			send_header_to (res)
			send_payload_to (res)
		end

	send_header_to (res: WSF_RESPONSE)
			-- Send header to response `res'.
		do
			res.put_header_lines (header)
		end

	send_payload_to (res: WSF_RESPONSE)
			-- Send payload data to response `res'.
		do
			-- Nothing by default
		end

end
