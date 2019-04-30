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
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 l_parser.parse_content
			 json_object := l_parser.parsed_json_object
			end
		end

	make_with_uri (a_uri: READABLE_STRING_8)
			-- Build a new clinet configuration from a uri `a_uri`.
		do
			internal_service_uri := a_uri
		ensure
			internal_service_uri_set: internal_service_uri = a_uri
		end

feature -- Access

	connection_timeout: INTEGER_64
			-- Connection timeout
		do
			if
				attached {JSON_OBJECT} json_object as l_jo and then
				attached {JSON_NUMBER} l_jo.item ("connection.timeout") as l_timeout
			then
				Result := l_timeout.integer_64_item
			else
				Result := 30
			end
		end

	service_root: STRING_8
			-- Root uri.
		do
			if
				attached {JSON_OBJECT} json_object as l_jo and then
				attached {JSON_STRING} l_jo.item ("service.root") as l_root
			then
				Result := l_root.item
			elseif attached internal_service_uri as l_url then
				Result := l_url
			else
					-- Default service location.
				Result := {ES_UPDATE_CONSTANTS}.update_service_url
			end
		end

feature {NONE} -- JSON implementation

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


	internal_service_uri: detachable STRING_8
			-- Update service URI.

end
