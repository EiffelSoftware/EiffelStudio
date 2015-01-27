note
	description: "Summary description for {CMS_JSON_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_JSON_CONFIGURATION

inherit

	APPLICATION_JSON_CONFIGURATION_HELPER
	
feature -- Access

	is_html_mode (a_path: PATH): BOOLEAN
			-- Is the server running on web mode?
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
				l_parser := new_json_parser (json_file)
				l_parser.parse_content
				if
					l_parser.is_valid and then
					attached l_parser.parsed_json_object as jo and then l_parser.is_parsed and then
					attached {JSON_OBJECT} jo.item ("server") as l_server and then
					attached {JSON_STRING} l_server.item ("mode") as l_mode
				then
					Result := l_mode.item.is_case_insensitive_equal_general ("html")
				end
			end
		end

	is_web_mode (a_path: PATH): BOOLEAN
			-- Is the server running on web mode?
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
				l_parser := new_json_parser (json_file)
				l_parser.parse_content
				if
					l_parser.is_valid and then
					attached l_parser.parsed_json_object as jo and then l_parser.is_parsed and then
					attached {JSON_OBJECT} jo.item ("server") as l_server and then
					attached {JSON_STRING} l_server.item ("mode") as l_mode
				then
					Result := l_mode.item.is_case_insensitive_equal_general ("web")
				end
			end
		end

end
