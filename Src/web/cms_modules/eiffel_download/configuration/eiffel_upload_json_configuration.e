note
	description: "Summary description for {EIFFEL_UPLOAD_JSON_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_UPLOAD_JSON_CONFIGURATION

inherit

	SHARED_LOGGER

feature

	configuration_from_uploaded_json_file (a_path: PATH): detachable EIFFEL_UPLOAD_CONFIGURATION
			-- Upload json configuration from path `a_path'.
		do
			if attached json_file_from (a_path) as js then
				Result := configuration_from_uploaded_json_string (js)
			end
		end

	configuration_from_uploaded_json_string (a_json: READABLE_STRING_8): detachable EIFFEL_UPLOAD_CONFIGURATION
			-- Upload json configuration from path `a_path'.
		local
			l_parser: JSON_PARSER
			l_conf: EIFFEL_UPLOAD_CONFIGURATION
		do
			l_parser := new_json_parser (a_json)
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_value as jv and then l_parser.is_parsed then
				create l_conf
				if attached {JSON_STRING} jv.item ("location") as l_location then
					l_conf.set_location (l_location.unescaped_string_8)
				end
				if	attached {JSON_ARRAY} jv.item ("files") as l_files then
					across l_files as  ic
					loop
						if
							attached {JSON_OBJECT} ic.item as l_item and then
							attached {JSON_STRING} l_item.item ("name") as l_name and then
							attached {JSON_NUMBER} l_item.item ("size") as l_size and then
							attached {JSON_STRING} l_item.item ("sha256") as l_sha256 and then
							attached {JSON_STRING} l_item.item ("version") as l_version and then
							attached {JSON_STRING} l_item.item ("major") as l_major and then
							attached {JSON_STRING} l_item.item ("minor") as l_minor and then
							attached {JSON_NUMBER} l_item.item ("revision") as l_revision and then
							attached {JSON_STRING} l_item.item ("platform") as l_platform
						then
								-- TUPLE [name: STRING; size: INTEGER; sha256: STRING; major: STRING; minor: STRING; revision: INTEGER; platform: STRING]
							l_conf.add_element ([l_name.item, l_size.integer_64_item, l_sha256.item, l_version.item, l_major.item, l_minor.item, l_revision.integer_64_item, l_platform.item])
						end
					end
				end
			end
			if l_conf /= Void and then attached l_conf.files then
				Result := l_conf
			end
		end

feature {NONE} -- Implementation

	json_file_from (a_fn: PATH): detachable STRING
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

end
