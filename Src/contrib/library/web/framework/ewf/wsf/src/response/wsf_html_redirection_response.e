note
	description: "[
				Immediate redirection with HTML content
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_HTML_REDIRECTION_RESPONSE

inherit
	WSF_HTML_PAGE_RESPONSE
		rename
			make as make_html
		redefine
			send_to
		end

create
	make

feature {NONE} -- Initialization

	make (a_url_location: like url_location)
		do
			url_location := a_url_location
			make_html
			set_status_code ({HTTP_STATUS_CODE}.found)
		end

feature -- Header

	url_location: STRING_8
			-- New url location after redirection

feature -- Element change

	set_url_location (a_url_location: like url_location)
			-- Set `url_location' to `a_url_location'
		do
			url_location := a_url_location
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			h,rh: like header
		do
			h := header
			create rh.make_with_count (1)

			rh.put_location (url_location)
			rh.append_header_object (h)

			header := rh
			Precursor (res)
			header := h
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
