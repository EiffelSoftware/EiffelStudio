note
	description: "[
				Delayed redirection with HTML content using META tag
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_HTML_DELAYED_REDIRECTION_RESPONSE

inherit
	WSF_HTML_PAGE_RESPONSE
		rename
			make as make_html
		redefine
			append_html_head_code
		end

create
	make

feature {NONE} -- Initialization

	make (a_url_location: like url_location; a_delay_in_seconds: INTEGER)
		do
			url_location := a_url_location
			delay := a_delay_in_seconds
			make_html
			status_code := {HTTP_STATUS_CODE}.found
		end

feature -- Header

	url_location: STRING_8
			-- New url location after redirection

	delay: INTEGER

feature -- Element change

	set_url_location (a_url_location: like url_location)
			-- Set `url_location' to `a_url_location'
		do
			url_location := a_url_location
		end

	set_delay (a_seconds: INTEGER)
		do
			delay := a_seconds
		end

feature {NONE} -- Output

	append_html_head_code (s: STRING_8)
		local
			h_lines: like head_lines
			l_lines: like head_lines
		do
			h_lines := head_lines
			l_lines := head_lines.twin
			head_lines := l_lines
			add_meta_http_equiv ("refresh", delay.out + ";url=" + url_location)
			Precursor (s)
			head_lines := h_lines
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
