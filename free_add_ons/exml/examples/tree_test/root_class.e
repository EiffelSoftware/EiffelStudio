indexing
   description:	"demonstration of using the tree based xml parser";
   note:			 	"this example compiles with ISE Eiffel and SmallEiffel.%
   %Therefor GOBO library must be correctly installed.";
   
class
   ROOT_CLASS
inherit
   EXPAT_ERROR_CODES
   KL_INPUT_STREAM_ROUTINES
creation
   
   make
   
feature -- Initialization
   
   make is
      do
	 !! parser.make
	 
	 parse_file (file_name)			
	 
      end;
   
feature -- Access
   
   parser: XML_TREE_PARSER
   
   file_name: STRING is "../test_data/test.xml"
	 -- for se/linux
	 --file_name: STRING is "..\test_data\test.xml"
	 -- for se/win
	 --file_name: STRING is "../../../test_data/test.xml"
	 -- for ise/linux
	 --file_name: STRING is "..\..\..\test_data\test.xml"
	 -- for ise/win
   
feature -- basic routines
   parse_file (a_file_name: STRING) is
      require
	 file_name_not_void: a_file_name /= Void
			
      local
	 in_file: like INPUT_STREAM_TYPE
	 buffer: STRING
      do
	 in_file := make_file_open_read (a_file_name)

	 check
	    file_open: is_open_read (in_file)
	 end

	 from
	 until
	    end_of_input (in_file) or not parser.is_correct
	 loop
		
	    buffer := read_string (in_file, 10)

	    --check
	    --	file_state_consitency_check: (buffer.count = 0) = end_of_input (in_file)
	    --end
	    -- TODO: check doesn't work with se ??!?!

	    if
	       buffer.count > 0
	     then
	       parser.parse_string (buffer)
	    else
	       parser.set_end_of_file	
	    end

	    if
	       not parser.is_correct
	     then
	       print (parser.last_error_extended_description)
	    end
	 end
	 close (in_file)
	 print (parser.out)
				
      end
   
   
 
		     
end -- class ROOT_CLASS
