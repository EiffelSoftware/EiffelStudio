note
	description: "WSF response based on complete html content."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_RESPONSE_MESSAGE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (a_content: like content)
		do
			content := a_content
			status_code := {HTTP_STATUS_CODE}.ok
			create header.make
			header.put_content_type_text_html
		end

feature -- Status

	status_code: INTEGER

feature -- Header

	header: HTTP_HEADER

feature -- Html access

	content: STRING

feature -- Element change

	set_status_code (c: like status_code)
		do
			status_code := c
		end

	set_content (s: like content)
		do
			content := s
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			s: STRING
		do
			s := content
			h := header
			h.put_content_length (s.count)
			h.put_current_date
			if not h.has_content_type then
				h.put_content_type_text_html
			end
			res.set_status_code (status_code)
			res.put_header_text (h.string)
			res.put_string (s)
		end

end
