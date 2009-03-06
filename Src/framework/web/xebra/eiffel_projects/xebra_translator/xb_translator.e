note
	description: "Summary description for {XB_TRANSLATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XB_TRANSLATOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `XB_TRANSLATOR'.
		do
			create error_handler.make_standard
			create preprocessor.make
		end


feature {NONE} -- Access

	error_handler: UT_ERROR_HANDLER
			-- Error handler

	preprocessor: XB_PREPROCESSOR
			-- Preprocesses the file


feature {NONE} -- Processing


	read_file (a_filename: STRING): STRING
			--reads a file into a string			
		local
			a_file: KL_TEXT_INPUT_FILE
			cannot_read: UT_CANNOT_READ_FILE_ERROR
		do
			Result := ""
			create a_file.make (a_filename)
			a_file.open_read
			if not a_file.is_open_read then
				create cannot_read.make (a_filename)
				error_handler.report_error (cannot_read)

			else
				from

				until
					a_file.end_of_file
				loop
					a_file.read_line
					Result.append(a_file.last_string)
				end

			end

		end


feature -- Processing

	process_with_file (a_filename: STRING): BOOLEAN
				--
		do
			Result := process_with_string (read_file(a_filename))
		end


	process_with_string (a_string: STRING): BOOLEAN
			--
		local
			id_stream: INDENDATION_STREAM
			temp_root: ROOT_SERVLET_ELEMENT
			fn: STRING
			output_elements: LIST[OUTPUT_ELEMENT]
					--only temp
		do

				fn := "testt"

				output_elements := preprocessor.parse_string (a_string)

				create temp_root.make_with_elements (fn, fn + "_controller", output_elements)

				create id_stream.make_open_write ("code_gen/generated/" + fn + ".e")
				id_stream.set_ind_character ('%T')
				temp_root.serialize (id_stream)
				id_stream.close
		end




feature {NONE} -- Implementation		

--	parse_stream (a_stream: KI_CHARACTER_INPUT_STREAM)
--			-- Parse open stream.
--		require
--			a_stream_not_void: a_stream /= Void
--			a_stream_open: a_stream.is_open_read
--		local
--			a_parser: XM_PARSER
--			a_consumer: XB_XML_PARSER_CALLBACKS
--		do
--			-- Create the parser.
--			-- It is left in the default state, which means:
--			-- ascii only, no external entities or DTDs,
--			-- no namespace resolving.
--			create {XM_EIFFEL_PARSER} a_parser.make

--			-- Create the event consumer that counts start tags.
--			create  a_consumer.make
--			a_parser.set_callbacks (a_consumer)



--			-- Parse and display result
--			a_parser.parse_from_stream (a_stream)
--			if not a_parser.is_correct then
--				error_handler.report_error_message (a_parser.last_error_extended_description)
--			else
--			--	error_handler.report_info_message ("Number of tags found: " + a_consumer.count.out)
--			end
--		end






invariant

	error_handler_not_void: error_handler /= Void
end
