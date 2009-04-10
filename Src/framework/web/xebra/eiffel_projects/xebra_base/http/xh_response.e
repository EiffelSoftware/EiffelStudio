note
	description: "[
		The {RESPONSE} contains all the data which is sent back to the http server (the requester).
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_RESPONSE

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Creates current
		do
			create cookie_orders.make
			create file.make
			create html.make (file)
			goto_request := ""
		end

feature -- Access

feature {NONE} -- Constants

	Html_start: STRING = "#H#"

feature -- Access


	html: XU_INDENDATION_STREAM
			-- Reponse html (xhtml)

	file: XU_SIMPLE_OUTPUTER
			-- use another stream!

	cookie_orders: LINKED_LIST [XH_COOKIE_ORDER]
			-- A cookie order will generate a cookie in the browser
			-- once the response has been processed

	goto_request: STRING assign set_goto_request
			-- Can be used to order the REQUEST_HANLDER to generate a new request

feature -- Element change

	set_goto_request (a_string: STRING)
			-- Setter. A_string can be empty!
		do
			goto_request := a_string
		end


	set_html (a_html: XU_INDENDATION_STREAM)
			-- Sets the text
		do
			html := a_html
		ensure
			html_set: html = a_html
		end

	append (a_string: STRING)
			-- Appends a string to the html result
		do
			html.append_string (a_string)
		end

	append_newline
			-- Appends a new line to the html result
		do
			html.append_string ("%N")
		end

	put_cookie_order (a_cookie: XH_COOKIE_ORDER)
			-- Adds a cookie_order
		do
			cookie_orders.put_right (a_cookie)
		ensure
			cookie_order_bigger: cookie_orders.count > old cookie_orders.count
		end

	render_to_string: STRING
			-- Renders to Response object to a string that can be sent to the mod_xebra
		do
			Result := ""
			from
				cookie_orders.start
			until
				cookie_orders.after
			loop
				Result := Result +  cookie_orders.item.render_to_string
				cookie_orders.forth
			end

			Result := Result + Html_start + file.get_text
		ensure
			result_not_empty: not Result.is_empty
		end



note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
