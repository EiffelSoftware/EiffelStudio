class
   TEST_PARSER
inherit
   EUNIT_TESTCASE
      redefine
	 set_up, 
	 tear_down
      end
   TOE_TREE_FACTORY
   KL_SHARED_EXECUTION_ENVIRONMENT
   KL_INPUT_STREAM_ROUTINES
      rename
	 name as name_input_stream
      end

feature
   
   set_up is
      do
	 xml_tree_parser := create_tree_parser
	 !! fmt.make
      end
   
   tear_down is
      do
	 xml_tree_parser := Void
	 fmt := Void
      end

feature -- Tests
   
   test_creation is
      do
	 assert ("parser_exists", xml_tree_parser /= Void)
	 assert ("fmt_exists", fmt /= Void)
	 assert ("file_name_exists", file_name /= Void)
      end
   
   test_parsing is
      do
	 assert ("parser_exists", xml_tree_parser /= Void)
	 xml_tree_parser.parse_from_file_name (file_name)
	 assert ("parsed_without_errors", xml_tree_parser.is_correct = True)
      end
   
   test_output is
      do
	 xml_tree_parser.parse_from_file_name (file_name)
	 fmt.process_document (xml_tree_parser.document)
	 assert ("output_exists", fmt.last_string /= Void)
	 assert ("output correct", equal (fmt.last_string.to_utf8.out, "<mydoc >%N</mydoc>") = True)
      end
   
   test_real_world is
	 -- reads the exml.xml file, just to see whether we crash or not
      do
	 assert ("parser_exists", xml_tree_parser /= Void)
	 xml_tree_parser.parse_from_file_name (ebook_exml)
	 assert ("parsed_without_errors", xml_tree_parser.is_correct = True)
      end
   
   
feature -- Help functions
   
   xml_tree_parser: XML_TREE_PARSER
   fmt: XML_FORMATER
   
   file_name_: STRING is "${EXML}/examples/test_data/test_simple1.xml"
   
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



