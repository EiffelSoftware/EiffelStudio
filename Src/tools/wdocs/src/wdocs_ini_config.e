note
	description: "Summary description for {WDOCS_INI_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_INI_CONFIG

inherit
	WDOCS_DEFAULT_CONFIG
		rename
			make as make_default
		end

create
	make

feature {NONE} -- Initialization

	make (p: PATH)
		do
			make_default
			import_ini_file (p)
		end

	import_ini_file (p: PATH)
		local
			utf: UTF_CONVERTER
			f: PLAIN_TEXT_FILE
			s,k,v: STRING_8
			i: INTEGER
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_line_thread_aware
					s := f.last_string
					s.left_adjust
					i := s.index_of ('=', 1)
					if i > 1 then
						k := s.head (i - 1)
						k.right_adjust
						v := s.substring (i + 1, s.count)
						v.left_adjust
						v.right_adjust
						if k.is_case_insensitive_equal_general ("root") then
							create root_dir.make_from_string (v)
						elseif k.is_case_insensitive_equal_general ("wiki") then
							create wiki_dir.make_from_string (v)
						elseif k.is_case_insensitive_equal_general ("theme") then
							create theme_name.make_from_string_general (utf.utf_8_string_8_to_escaped_string_32 (v))
						end
					end
				end
				f.close
			end
		end

end
