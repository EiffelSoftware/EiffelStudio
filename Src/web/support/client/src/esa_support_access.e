note
	description: "[
		Communication base for accessing the New Eiffel support system using HTTP Client.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SUPPORT_ACCESS

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_config: ESA_CLIENT_CONFIGURATION)
			-- Initialize `Current'.
		do
			config := a_config
			client := (create {DEFAULT_HTTP_CLIENT}).new_session (service_url)
			client.set_timeout (config.connection_timeout)
			client.set_is_insecure (True)
			client.set_any_auth_type
		end

	config: ESA_CLIENT_CONFIGURATION
			-- client configuration.

feature -- Access

	client: HTTP_CLIENT_SESSION
			-- Http client session.

	get (a_path: READABLE_STRING_GENERAL; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): ESA_SUPPORT_RESPONSE
			-- Response for GET request based on Current, `a_path' and `ctx'.
		local
			l_http_response: STRING_8
			col: detachable CJ_COLLECTION
			l_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			l_url: STRING_8
			l_status: INTEGER
		do
			create l_http_response.make_empty
			l_ctx := ctx
			if l_ctx = Void then
				create l_ctx.make
			end
			l_ctx.add_header ("Accept", config.media_type)
			l_url := a_path.to_string_8
			if attached client.get (l_url, l_ctx) as g_response then
				l_url := g_response.url
				l_http_response.append ("Status: " + g_response.status.out + "%N")
				l_http_response.append (g_response.raw_header)
				l_status := g_response.status
				if attached g_response.body as l_body then
					l_http_response.append ("%N%N")
					l_http_response.append (l_body)
					if 	not l_body.is_empty and then
						attached json (l_body) as j then
						col := cj_collection (j)
					end
				end
			end
			create Result.make (l_url, l_http_response, l_status, col)
		end

feature -- Change Element

	create_with_template (a_path: READABLE_STRING_GENERAL; tpl: CJ_TEMPLATE; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): ESA_SUPPORT_RESPONSE
			-- Create a new report using a `tpl'.
		local
			l_http_response: STRING_8
			col: detachable CJ_COLLECTION
			d: detachable STRING_8
			l_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			l_url: STRING_8
			l_status: INTEGER
		do
			create l_http_response.make_empty
			l_ctx := ctx
			if l_ctx = Void then
				create l_ctx.make
			end
			l_ctx.add_header ("Accept", config.media_type)
			l_ctx.add_header ("Content-Type", config.media_type)
			if attached cj_template_to_json (tpl) as j then
				d := "{ %"template%": " + j.representation + " }"
			end
			l_url := a_path.to_string_8
			if attached client.post (l_url, l_ctx, d) as g_response then
				l_url := g_response.url
				l_http_response.append ("Status: " + g_response.status.out + "%N")
				l_http_response.append (g_response.raw_header)
				l_status := g_response.status
				if attached g_response.body as l_body then
					l_http_response.append ("%N%N")
					l_http_response.append (l_body)
					if attached json (l_body) as j then
						col := cj_collection (j)
					end
				end
			end
			create Result.make (l_url, l_http_response, l_status, col)
		end

feature -- Status report

	is_support_accessible: BOOLEAN
			-- Indicates if access to the support site is available
		do
			Result := client.is_available
		ensure
			support_accessible: Result implies client.is_available
		end

feature {NONE} -- Implementation

	shared_ejson: SHARED_EJSON
			-- Json configuration
		once
			fixme ("Refactor code: update class to remove the use of obsolete code.")
			create Result
		end

	initialize_json_converters
			-- json converters initialization.
		once
			fixme ("Refactor code: update class to remove the use of obsolete code.")
			if attached shared_ejson.json as j then
				j.add_converter (create {CJ_COLLECTION_JSON_CONVERTER}.make)
				j.add_converter (create {CJ_DATA_JSON_CONVERTER}.make)
				j.add_converter (create {CJ_ERROR_JSON_CONVERTER}.make)
				j.add_converter (create {CJ_ITEM_JSON_CONVERTER}.make)
				j.add_converter (create {CJ_QUERY_JSON_CONVERTER}.make)
				j.add_converter (create {CJ_TEMPLATE_JSON_CONVERTER}.make)
				j.add_converter (create {CJ_LINK_JSON_CONVERTER}.make)
				if j.converter_for (create {ARRAYED_LIST [detachable ANY]}.make (0)) = Void then
					j.add_converter (create {CJ_ARRAYED_LIST_JSON_CONVERTER}.make)
				end
			end
		end

feature -- Access

	cj_collection (j: JSON_VALUE): detachable CJ_COLLECTION
			-- collection json represenation.
		local
			conv: CJ_COLLECTION_JSON_CONVERTER
		do
			fixme ("Refactor code: update class to remove the use of obsolete code.")
			if attached {JSON_OBJECT} j as jo then
				initialize_json_converters
				create conv.make
				Result := conv.from_json (jo)
			end
		end

	json (s: READABLE_STRING_8): detachable JSON_VALUE
		local
			p: JSON_PARSER
		do
			create p.make_with_string (s)
			if attached p.parse as v and then p.is_parsed then
				Result := v
			end
		end

	cj_template_to_json (tpl: CJ_TEMPLATE): detachable JSON_VALUE
		local
			conv: CJ_TEMPLATE_JSON_CONVERTER
		do
			initialize_json_converters
			create conv.make
			Result := conv.to_json (tpl)
		end

feature {NONE} -- Constants

	service_url: STRING = ""
			-- service url setup.

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
