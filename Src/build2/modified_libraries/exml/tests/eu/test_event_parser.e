class
   TEST_EVENT_PARSER
inherit
   EUNIT_TESTCASE
      redefine
	 set_up, 
	 tear_down
      end
   
   KL_SHARED_EXECUTION_ENVIRONMENT
   KL_INPUT_STREAM_ROUTINES
      rename
	 name as name_input_stream
      end
feature
   
   set_up is
      do
	 !! my_event_parser.make
      end
   
   tear_down is
      do
	 my_event_parser := Void
      end

feature -- Tests
   
   test_creation is
      do
	 assert ("parser_exists", my_event_parser /= Void)
	 assert ("file_name_exists", file_name /= Void)
      end
   
   test_parsing is
      do
	 assert ("parser_exists", my_event_parser /= Void)
	 my_event_parser.parse_from_file_name (file_name)
	 assert ("parsed_without_errors", my_event_parser.is_correct = True)
      end
   
   test_callback is
      do
	 my_event_parser.parse_from_file_name (file_name)
  	 assert ("start_tag_ok", my_event_parser.is_start_tag_ok = True)
  	 assert ("end_tag_ok", my_event_parser.is_end_tag_ok = True)
  	 assert ("content_ok", my_event_parser.is_content_ok = True)
      end
   
   test_real_world is
	 -- reads the exml.xml file, just to see whether we crash or not
      do
	 assert ("parser_exists", my_event_parser /= Void)
	 my_event_parser.parse_from_file_name (ebook_exml)
	 assert ("parsed_without_errors", my_event_parser.is_correct = True)
      end

   
feature -- Help functions
   
   my_event_parser: MY_EVENT_PARSER
   
   file_name_: STRING is "${EXML}/examples/test_data/event_test_1.xml"
   
   file_name: UCSTRING is 
      once
	 !! Result.make_from_string (Execution_environment.interpreted_string (file_name_))
      end
   
   ebook_exml_: STRING is "${EXML}/examples/test_data/ebook/input/exml.xml"
   
   ebook_exml: UCSTRING is 
      once
	 !! Result.make_from_string (Execution_environment.interpreted_string (ebook_exml_))
      end
end	 





