indexing
	description:"Key generator for eBOOK page keys"
	note:			"this example compiles with ISE Eiffel and SmallEiffel.%
					%Therefore GOBO library must be correctly installed.";
	status:		"See notice at end of class."
	author:		"Andreas Leitner"

class
	EBOOK
inherit
	EXPAT_ERROR_CODES
	KL_INPUT_STREAM_ROUTINES
	KL_OUTPUT_STREAM_ROUTINES
		rename
			close as close_output,
			is_closed as is_closed_output
		end

creation

	make

feature -- Initialization

	make is
		local
			xml_parser: EBOOK_XML_PARSER
		do
			print ("starting...%N")
			!! xml_parser.make
			print ("parsing and analyzing input...%N")
			xml_parser.parse_file

			if
				not xml_parser.is_correct
			then
				print (xml_parser.last_error_extended_description)
				print ("%N")
			else
				if 
					not xml_parser.is_valid
				then
					print ("The XML-document is not valid%N")
				else
					print ("parsing and analyzing was successfull%N")
					print ("generating html files...%N")
					xml_parser.generate_html_pages
				end
			end

			print ("exiting...%N")
		end


feature

end -- class EBOOK
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------





