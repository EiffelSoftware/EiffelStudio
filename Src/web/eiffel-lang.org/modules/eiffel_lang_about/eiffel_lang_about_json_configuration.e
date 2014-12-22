note
	description: "Summary description for {EIFFEL_LANG_ABOUT_JSON_CONFIGURATION}."

class
	EIFFEL_LANG_ABOUT_JSON_CONFIGURATION

inherit

	JSON_CONFIGURATION

feature -- Access

	new_recaptcha_key (a_path: PATH): READABLE_STRING_32
			-- Get the recaptcha private key
		local
			l_parser: JSON_PARSER
		do
			Result := "False"
			if attached json_file_from (a_path) as json_file then
				l_parser := new_json_parser (json_file)
				l_parser.parse_content
				if l_parser.is_valid and then
					attached {JSON_OBJECT} l_parser.parsed_json_value as jv and then
					attached {JSON_OBJECT} jv.item ("recaptcha") as l_recaptcha and then
					attached {JSON_STRING} l_recaptcha.item ("key") as l_key
				then
					Result := l_key.item
				end
			end
		end

end
