note
	description: "Provide access to json configuration"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_JSON_CONFIGURATION

create
	make

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
				Result := 250
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
			else
					-- Default service location.
				Result := "https://www2.eiffel.com/support"
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

end
