indexing
	description: "XML parser for help files"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	HELP_DOCUMENT_PARSER

inherit
	XML_TREE_PARSER
	EXPAT_ERROR_CODES
		undefine
			out
		end
	KL_INPUT_STREAM_ROUTINES
		undefine
			out
		end
create
	make

feature -- Basic operations

	parse_file (file_name: STRING): HELP_DOCUMENT is
			-- Parse `file_name' with eXML.
		require
			file_name_not_void: file_name /= Void
			
		local
			in_file: like INPUT_STREAM_TYPE
			buffer : STRING
		do
			in_file := make_file_open_read (file_name)

			check
				file_open: is_open_read (in_file)
			end

			from
			until
				end_of_input (in_file) or not is_correct
			loop
				buffer := read_string (in_file, 10)

				if
					buffer.count > 0
				then
					parse_string (buffer)
				else
					set_end_of_file	
				end

				if
					not is_correct
				then
					print (last_error_extended_description)
				end
			end
			close (in_file)

			create Result.make (root_element)
		end;

end -- class HELP_DOCUMENT_PARSER