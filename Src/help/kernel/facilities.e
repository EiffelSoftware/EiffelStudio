indexing
	description: "Provide global functionality to all objects."
	author: "pascalf"

class
	FACILITIES

inherit
	E_XML_TAGS

feature -- Access

	structure: E_DOCUMENT is 
			-- The help topic tree.
		do
			Result := onces.main_structure
		end

	main_window: VIEWER_WINDOW is
		do
			Result := onces.main_window
		end

	set_main_window(vw:VIEWER_WINDOW) is
		do
			onces.set_main_window(vw)
		end

	set_main_structure(ms:E_DOCUMENT) is
		do
			onces.set_main_structure(ms)
		end

	warning(title, message:STRING; par:EV_CONTAINER) is
		local
			win: EV_WARNING_DIALOG
		do
			!! win.make_with_text(par, title, message)
			win.show
		end

	is_xml_file(fn: STRING):BOOLEAN is
		local
			s: STRING
		do
			s := clone(fn)
			s.tail(4)
			s.to_upper
			Result := s.is_equal(".XML")
		end

	transform_relative_path (path, file: STRING) is
			-- Prepend `file' the path of `path'.
		require
			path_exists: path /= Void
			path_long_enough: path.count > 0
			file_exists: file /= Void
		local
			sep: CHARACTER
		do
			sep := Operating_environment.Directory_separator
			file.prepend (path.substring (1, path.last_index_of (sep, path.count)))
		end

	parse_xml_file (file_name: FILE_NAME): XML_ELEMENT is
			-- Creates a xml-tree-structure from `file_name'.
			-- Wil be Void if an error of any kind occurs.
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
			err: BOOLEAN
		do
			if not err then
				create parser.make 
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.read_stream (file.count)
					create s.make(file.count)
					s.append (file.last_string)
					parser.parse_string (s)
					parser.set_end_of_file
					file.close
					Result := parser.root_element
				end
			else
				warning ("Error while reading file", "Error while parsing " + file_name, main_window)
			end
		rescue
			err := True
			retry
		end

feature {NONE}

	onces: ONCES is
		once
			create Result
		end

end -- class FACILITIES
