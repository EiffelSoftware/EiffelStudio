note
	description: "Object parsing a JSON configuration file."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CONFIG

	-- To be implemented

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (p: PATH)
			-- Create object from a file `p'
		do
			parse (p)
		end


feature -- Access

	layout_root : detachable READABLE_STRING_32
			-- root directory.
		do
			if
				attached json_value as jv and then
				attached {JSON_OBJECT} jv.item ("layout") as l_layout and then
			    attached {JSON_STRING} l_layout.item ("root") as l_root
			then
				Result := l_root.unescaped_string_8
			end
		end

	layout_wiki: detachable READABLE_STRING_32
			-- Wiki path.
		do
			if
				attached json_value as jv and then
				attached {JSON_OBJECT} jv.item ("layout") as l_layout and then
			    attached {JSON_STRING} l_layout.item ("wiki") as l_wiki
			then
				Result := l_wiki.unescaped_string_8
			end
		end

	ui_theme: detachable READABLE_STRING_32
			-- Current UI theme, if any.
		do
			if
				attached json_value as jv and then
				attached {JSON_OBJECT} jv.item ("ui") as l_layout and then
			    attached {JSON_STRING} l_layout.item ("theme") as l_theme
			then
				Result := l_theme.unescaped_string_8
			end
		end

	settings_cache_duration: detachable READABLE_STRING_32
		do
			if
				attached json_value as jv and then
				attached {JSON_OBJECT} jv.item ("settings") as l_layout and then
			    attached {JSON_STRING} l_layout.item ("cache_duration") as l_cache_duration
			then
				Result := l_cache_duration.unescaped_string_8
			end
		end

feature -- Implementation

	parse (a_path: PATH)
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed then
			 	json_value := jv
			 end
			end
		end

feature {NONE} -- JSON

	json_value: detachable JSON_OBJECT
		-- Possible json object representation.

	json_file_from (a_fn: PATH): detachable STRING
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name.out)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_parser (a_string)
		end

end

