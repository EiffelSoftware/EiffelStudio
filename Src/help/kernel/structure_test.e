class STRUCTURE_TEST

creation
	make

feature -- Initialization

	make is
		do
			parse("d:\help_tool\structure\example2.xml")
		end

feature -- Operations

	parse(fn: STRING) is
			-- Resources specified by the user
		local
			file_name: FILE_NAME
			file: RAW_FILE 
			s: STRING
			parser: XML_TREE_PARSER 
		do	
			!! file_name.make_from_string(fn)
			!! parser.make 
			!! file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				!! s.make(file.count)
				s.append (file.last_string)
				parser.parse_string(s)
				parser.set_end_of_file
				file.close		
			end
			create document.make_from_xml_tree(parser.root_element)
			document.display_info
		end

	document:E_DOCUMENT

end --VIEWER