note
	description: "Summary description for {WDOCS_METADATA_WIKI_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_METADATA_WIKI_FILE

inherit
	WDOCS_METADATA_WIKI

create
	make_with_path

feature {NONE} -- Initialization

	make_with_path (p: PATH)
		do
			path := p
		end

	path: PATH

feature -- Status report

	exists: BOOLEAN
			-- Is metadata file exists?
		do
			Result := (create {FILE_UTILITIES}).file_path_exists (path)
		end

feature {NONE} -- Implementation

	parse (a_items: STRING_TABLE [READABLE_STRING_32]; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL])
		local
			f: RAW_FILE
			n: detachable STRING_8
			l_line: STRING_8
		do
			is_parsing_done := False
			create f.make_with_path (path)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted or f.end_of_file or is_parsing_done
				loop
					n := Void
					f.read_line_thread_aware
					l_line := f.last_string
					parse_line (l_line, a_items, a_restricted_names)
				end
				f.close
			end
		end

end
