indexing
	description:"Converter for FrameMaker 5.5.6 XML format to help-XML format"
	author:"Vincent Brendel"

class
	FM_CONVERT

inherit
	ARGUMENTS

create
	make

feature -- Initialization

	make is
			-- Convert first argument (FM .XML) to 2nd (help .XML)
		local
			struct: FM_XML_STRUCT
			file: STRING
			sep: CHARACTER
		do
			process_command_line
			parse(source_file)
			sep := Operating_environment.Directory_separator
			file := source_file
			file := file.substring (file.last_index_of (sep, file.count) + 1, file.count)
			create struct.make(parser.root_element, file)
			write_file(target_file, struct.xml_string)
		end

	parse(file_name:FILE_NAME) is
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			s: STRING
		do
			create parser.make 
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				create s.make(file.count)
				s.append (file.last_string)
				parser.parse_string(s)
				parser.set_end_of_file
				file.close
			end
		end

	write_file(file_name:FILE_NAME; s:STRING) is
		local
			file: RAW_FILE
		do
			create file.make (file_name)
			file.open_write
			file.putstring(s)
			file.close
		end

	parser: XML_TREE_PARSER	

	process_command_line is
			-- Read the command line for help file and topic.
		local
			n: INTEGER
			err: BOOLEAN
		do
			if not err then
				if argument_count < 2 then
					io.putstring("Usage: convert <fm5>.xml <help>.xml")
				else
					create source_file.make_from_string(arg_option(1))
					create target_file.make_from_string(arg_option(2))
				end
			else
				io.putstring("Error while reading arguments.")
			end
		ensure
			source_file_set: source_file /= Void
			target_file_set: target_file /= Void
		rescue
			err := TRUE
			retry
		end

feature -- Access

	source_file: FILE_NAME
			-- The FrameMaker XML-file to be loaded.

	target_file: FILE_NAME
			-- The XML-help-file to be generated.

end
