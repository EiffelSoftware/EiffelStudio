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
	 f: STD_FILE_READ
	 s: STRING
      do
	 print ("file test:%N")
	 !! f.connect_to ("..\test_data\test.xml")
	 check
	    file_open: f.is_connected
	 end
	 !! s.make (0)
	 f.read_tail_in (s)
	 parser.parse_string (s)
	 parser.set_end_of_file
	 if
	    parser.is_correct
	  then
	    print ("%NNo errors detected%N")
	 else
	    print (parser.last_error_extended_description)
	 end
	 parser.set_end_of_file
	 f.disconnect
      end

end -- class ROOT_CLASS



