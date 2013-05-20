note
	description: "[
				This class is used to send a redirection
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_REDIRECTION_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (a_url_location: like url_location)
		do
			status_code := {HTTP_STATUS_CODE}.found
			url_location := a_url_location
			create header.make
		end

feature -- Status

	status_code: INTEGER

feature -- Header

	header: HTTP_HEADER
			-- Response' header

	url_location: STRING_8
			-- New url location after redirection

	content: detachable READABLE_STRING_8
			-- Optional content

	content_type: detachable READABLE_STRING_8
			-- Content type associated with `content'

feature -- Element change

	set_status_code (c: like status_code)
			-- Set the status code
		do
			status_code := c
		end

	set_url_location (a_url_location: like url_location)
			-- Set `url_location' to `a_url_location'
		do
			url_location := a_url_location
		end

	set_content (a_content: attached like content; a_content_type: like content_type)
			-- Set `a_content' of type `a_content_type'
			-- If `a_content_type' is Void, use value from `header' or default "text/plain"
		do
			content := a_content
			content_type := a_content_type
		end

	remove_content
			-- Remove content data
		do
			content := Void
			content_type := Void
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			b: like content
			h: like header
		do
			h := header
			b := content
			res.set_status_code (status_code)

			h.put_location (url_location)

			if b /= Void then
				if not h.has_content_length then
					h.put_content_length (b.count)
				end
				if attached content_type as t then
					h.put_content_type (t)
				elseif not h.has_content_type then
					h.put_content_type_text_plain
				end
			end
			res.put_header_text (h.string)
			if b /= Void then
				res.put_string (b)
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
