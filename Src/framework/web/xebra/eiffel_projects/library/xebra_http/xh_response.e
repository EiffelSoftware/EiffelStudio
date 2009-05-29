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
			create html_stream.make
			create formatter.make (html_stream)
			goto_request := ""
		ensure
			cookie_orders_attached: cookie_orders /= Void
			html_stream_attached: html_stream /= Void
			formatter_attached: formatter /= Void
			goto_request_attached: goto_request /= Void
		end

feature -- Access

feature {NONE} -- Constants

	Html_start: STRING = "#H#"

feature -- Access

	formatter: XU_INDENDATION_FORMATTER
			-- Formats the html code

	html_stream: XU_SIMPLE_STREAM
			-- Contains the html code

	cookie_orders: LINKED_LIST [XH_COOKIE_ORDER]
			-- A cookie order will generate a cookie in the browser
			-- once the response has been processed

	goto_request: STRING assign set_goto_request
			-- Can be used to order the {REQUEST_HANDLER} to generate a new request

feature -- Element change

	set_goto_request (a_goto_request: STRING)
			-- Setter. A_string can be empty! ?
		require
			not_a_goto_request_is_detached_or_empty: a_goto_request /= Void and then not a_goto_request.is_empty
		do
			goto_request := a_goto_request
		ensure
			goto_request_set: goto_request = a_goto_request
		end

	set_formatter (a_formatter: XU_INDENDATION_FORMATTER)
			-- Sets the text
		require
			a_formatter_attached: a_formatter /= Void
		do
			formatter := a_formatter
		ensure
			formatter_set: formatter = a_formatter
		end

	append (a_string: STRING)
			-- Appends a string to the html result
		require
			string_not_detached: a_string /= Void
		do
			formatter.append_string (a_string)
		end

	append_newline
			-- Appends a new line to the html result
		do
			formatter.append_string ("%N")
		end

	put_cookie_order (a_cookie: XH_COOKIE_ORDER)
			-- Adds a cookie_order
		require
			a_cookie_attached: a_cookie /= Void
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

			Result := Result + Html_start + html_stream.get_text
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

invariant
	cookie_orders_attached: cookie_orders /= Void
	html_stream_attached: html_stream /= Void
	formatter_attached: formatter /= Void
	goto_request_attached: goto_request /= Void

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
