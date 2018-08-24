note
	description: "Summary description for {CODEBOARD_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODEBOARD_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

create {CODEBOARD_MODULE}
	make

feature {NONE} -- Initialization

	initialize
			-- Create user profile api object with api `a_api' and storage `a_storage'.
		do
			Precursor
		end

feature -- Access

	code_count: INTEGER
		local
			d: DIRECTORY
		do
			create d.make_with_path (cms_api.module_resource_location_by_name ({CODEBOARD_MODULE}.name, (create {PATH}.make_from_string ("snippet"))))
			across
				d.entries as ic
			loop
				if attached ic.item.extension as ext then
					if
						ext.is_case_insensitive_equal_general ("e")
						or ext.is_case_insensitive_equal_general ("json")
					then
						Result := Result + 1
					end
				end
			end
		end

	code (a_id: INTEGER): detachable CODEBOARD_SNIPPET
		local
			p: PATH
			fut: FILE_UTILITIES
			utf: UTF_CONVERTER
			jp: JSON_PARSER
		do
			p := cms_api.module_resource_location_by_name ({CODEBOARD_MODULE}.name, (create {PATH}.make_from_string ("snippet")).extended (a_id.out))
			if
				fut.file_path_exists (p.appended_with_extension ("json")) and then
				attached file_unicode_content (p.appended_with_extension ("json")) as l_json_text
			then
				create jp.make_with_string (l_json_text)
				jp.parse_content
				if jp.is_parsed and jp.is_valid and attached jp.parsed_json_object as jo then
					if attached {JSON_STRING} jo.item ("code") as l_code then
						create Result.make (l_code.unescaped_string_32)
						if attached {JSON_STRING} jo.item ("description") as l_desc then
							Result.set_description (l_desc.unescaped_string_32)
						end
						if attached {JSON_STRING} jo.item ("lang") as l_lang then
							Result.set_lang (l_lang.unescaped_string_8)
						end
					end
				end
			elseif
				fut.file_path_exists (p.appended_with_extension ("e")) and then
				attached file_unicode_content (p.appended_with_extension ("e")) as l_code
			then
				create Result.make (l_code)
				Result.lang := "eiffel"
			end
		end

feature {NONE} -- Implementation

	file_unicode_content (p: PATH): detachable STRING_32
		local
			utf: UTF_CONVERTER
		do
			if attached file_content (p) as s then
				Result := utf.utf_8_string_8_to_string_32 (s)
			end
		end

	file_content (p: PATH): detachable STRING_8
		local
			f: PLAIN_TEXT_FILE
			l_done: BOOLEAN
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
					f.start
				until
					l_done
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
					l_done := f.last_string.count < 1_024
								or f.exhausted
								or f.end_of_file
				end
				f.close

			end
		end

end
