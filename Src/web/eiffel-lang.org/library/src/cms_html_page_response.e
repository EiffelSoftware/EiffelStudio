note
	description: "Summary description for {CMS_HTML_PAGE_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HTML_PAGE_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (a_html: like html)
		do
			html := a_html
			status_code := {HTTP_STATUS_CODE}.ok
			create header.make
			header.put_content_type_text_html
		end

feature -- Status

	status_code: INTEGER

feature -- Header

	header: HTTP_HEADER

feature -- Html access

	html: STRING

feature -- Element change

	set_status_code (c: like status_code)
		do
			status_code := c
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			h: like header
			s: STRING_8
		do
			h := header
			res.set_status_code (status_code)
			s := html

			if not h.has_content_length then
				h.put_content_length (s.count)
			end
			if not h.has_content_type then
				h.put_content_type_text_html
			end
			res.put_header_text (h.string)
			res.put_string (s)
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

