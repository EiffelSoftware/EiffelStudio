note
	description: "Provide access to json configuration"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_JSON_CONFIGURATION

create
	make,
	make_with_uri

feature {NONE} -- Initialization

	make (a_path: PATH)
			-- Build a new client configuration.
		local
			l_parser: JSON_PARSER
		do
			make_with_uri ({ES_UPDATE_CONSTANTS}.update_service_url)
			if attached json_file_from (a_path) as json_file then
				l_parser := new_json_parser (json_file)
				l_parser.parse_content
				json_object := l_parser.parsed_json_object
			end
		end

	make_with_uri (a_uri: READABLE_STRING_8)
			-- Build a new client configuration with uri `a_uri`.
		do
			internal_service_uri := a_uri
		ensure
			internal_service_uri_set: internal_service_uri = a_uri
		end

feature -- Access

	connection_timeout: INTEGER_32
			-- Connection timeout
		do
			if
				attached json_object as l_jo and then
				attached l_jo.number_item ("connection.timeout") as j_timeout
			then
				Result := j_timeout.integer_64_item.to_integer_32
			else
				Result := 30
			end
		end

	service_root: READABLE_STRING_8
			-- Root uri.
		do
			Result := internal_service_uri
			if
				attached json_config_string_item ("service.root") as l_root and then
				l_root.is_valid_as_string_8
			then
				Result := l_root.to_string_8
			end
		end

feature {NONE} -- JSON implementation

	json_config_string_item (a_name: READABLE_STRING_GENERAL): detachable STRING_32
		do
			if
				attached json_object as jo and then
				attached jo.string_item (a_name) as js
			then
				Result := js.unescaped_string_32
			end
		end

	json_object: detachable JSON_OBJECT
			-- JSON object

	json_file_from (a_fn: PATH): detachable STRING
			-- Json content from file.
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name.out)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
			-- new json parser.
		do
			create Result.make_with_string (a_string)
		end

	internal_service_uri: READABLE_STRING_8
			-- Update service URI.

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
