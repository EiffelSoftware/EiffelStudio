indexing
	description: "Simple test of eXML for ISE Eiffel. Using the standard event based parser";

class
	ROOT_CLASS
inherit
	EXPAT_ERROR_CODES
creation

	make

feature -- Initialization

	make is
		do
			!! parser.make
			parser_test
		end;

	parser: MY_XML_PARSER

	parser_test is
		local
			f: RAW_FILE
		do
			!! f.make_open_read ("..\..\..\test_data\test.xml")
			f.read_stream (f.count)
			if
				f.last_string /= Void
			then
				parser.parse_string (f.last_string)
				parser.set_end_of_file
				if
					not parser.is_correct
				then
					print (parser.last_error_extended_description)
				else
					print ("%NNo errors detected%N")
				end
			else
				print ("File has no content%N")
			end
		end

feature


end -- class ROOT_CLASS
