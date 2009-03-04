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

				print ("%N+++++++++++++++++++ START TRANSLATOR+++++++++++++++++++%N")
			print ("%N+++++++++++++++++++ END TRANSLATOR++++++++++++++++++++++++++++++++++++++%N")
		end


feature -- Access

	error_handler: UT_ERROR_HANDLER
			-- Error handler

	preprocessor: XB_PREPROCESSOR
			-- Preprocesses the file


feature -- Processing


	process (filename: STRING): BOOLEAN
			-- -- reads a xebra scriptlet from a_filename and writes
			-- a eiffel class document. Returns if it was successfull.
		require
			filename_not_void: filename /= Void
		local
			a_file: KL_TEXT_INPUT_FILE
				--
			cannot_read: UT_CANNOT_READ_FILE_ERROR
			id_stream: INDENDATION_STREAM
			temp_root: ROOT_SERVLET_ELEMENT
			fn: STRING
					--only temp
		do
			error_handler.report_info_message ("Parsing...")
			create a_file.make (filename)
			a_file.open_read
			if not a_file.is_open_read then
				create cannot_read.make (filename)
				error_handler.report_error (cannot_read)
				Result := False
			else
				fn := "testt"

				create temp_root.make (fn, fn + "_controller")

				preprocessor.parse_from_stream (temp_root, a_file)
				a_file.close

				if preprocessor.is_correct  then

					create id_stream.make_open_write ("code_gen/generated/" + fn + ".e")
					id_stream.set_ind_character ('%T')
					temp_root.serialize (id_stream)
					id_stream.close
				else
					Result := False
				end
			end
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
