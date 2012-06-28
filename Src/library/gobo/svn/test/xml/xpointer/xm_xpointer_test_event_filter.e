indexing

	description:

		"Test xpointer evaluation for the event implementation"

	library: "Gobo Eiffel XPointer Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPOINTER_TEST_EVENT_FILTER

inherit

	TS_TEST_CASE

	KL_IMPORTED_STRING_ROUTINES

	XM_EIFFEL_PARSER_FACTORY

	XM_RESOLVER_FACTORY

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	UT_SHARED_FILE_URI_ROUTINES
		export {NONE} all end

create

	make_default

feature -- Test

	test_shorthand_with_xml_id is
			-- Test parsing shorthand pointer
		local
			a_filter: XM_XPOINTER_EVENT_FILTER
			system_id: STRING
			a_parser: XM_PARSER
			a_dtd_filter: XM_DTD_CALLBACKS_NULL
			a_sink: XM_PRETTY_PRINT_FILTER
			a_resolver: XM_URI_EXTERNAL_RESOLVER
		do
			system_id := test_event_xml_uri.full_reference
			a_parser := new_eiffel_parser
			a_resolver := new_resolver_current_directory
			a_parser.set_resolver (a_resolver)
			create a_dtd_filter.make
			create a_sink.make_null
			a_sink.set_output_to_string
			create default_media_type.make ("application", "xml")
			create a_filter.make ("an-id", default_media_type, a_resolver, a_sink, a_dtd_filter)
			a_filter.add_media_type (default_media_type)
			a_parser.set_callbacks (a_filter)
			a_parser.set_dtd_callbacks (a_filter)
			a_parser.parse_from_system (system_id)
			assert ("Correct output", a_sink.last_output.count = 338)
		end

	test_shorthand_with_dtd_declared_id is
			-- Test parsing shorthand pointer, and changing the xpointer
		local
			a_filter: XM_XPOINTER_EVENT_FILTER
			system_id: STRING
			a_parser: XM_PARSER
			a_dtd_filter: XM_DTD_CALLBACKS_NULL
			a_sink: XM_PRETTY_PRINT_FILTER
			a_resolver: XM_URI_EXTERNAL_RESOLVER
		do
			system_id := test_event_xml_uri.full_reference
			a_parser := new_eiffel_parser
			a_resolver := new_resolver_current_directory
			a_parser.set_resolver (a_resolver)
			create a_dtd_filter.make
			create a_sink.make_null
			a_sink.set_output_to_string
			create default_media_type.make ("application", "xml")
			create a_filter.make ("fred", default_media_type, a_resolver, a_sink, a_dtd_filter)
			a_filter.set_no_filtering -- immediately overridden!
			a_filter.set_xpointer ("S")
			a_filter.add_media_type (default_media_type)
			a_parser.set_callbacks (a_filter)
			a_parser.set_dtd_callbacks (a_filter)
			a_parser.parse_from_system (system_id)
			assert ("Correct output", a_sink.last_output.count = 134)
		end

	test_pass_through is
			-- Test as pure pass through filter
		local
			a_filter: XM_XPOINTER_EVENT_FILTER
			system_id: STRING
			a_parser: XM_PARSER
			a_dtd_filter: XM_DTD_CALLBACKS_NULL
			a_sink: XM_PRETTY_PRINT_FILTER
			a_resolver: XM_URI_EXTERNAL_RESOLVER
		do
			system_id := test_event_xml_uri.full_reference
			a_parser := new_eiffel_parser
			a_resolver := new_resolver_current_directory
			a_parser.set_resolver (a_resolver)
			create a_dtd_filter.make
			create a_sink.make_null
			a_sink.set_output_to_string
			create default_media_type.make ("application", "xml")
			create a_filter.make ("fred", default_media_type, a_resolver, a_sink, a_dtd_filter)
			a_filter.set_no_filtering
			a_parser.set_callbacks (a_filter)
			a_parser.set_dtd_callbacks (a_filter)
			a_parser.parse_from_system (system_id)
			assert ("Correct output", a_sink.last_output.count = 2453)
		end


	default_media_type: UT_MEDIA_TYPE
			-- Default media type

feature {NONE} -- Implementation

	data_dirname: STRING is
			-- Name of directory containing data files
		once
			Result := file_system.nested_pathname ("${GOBO}",
																<<"test", "xml", "xpointer", "data">>)
			Result := Execution_environment.interpreted_string (Result)
		ensure
			data_dirname_not_void: Result /= Void
			data_dirname_not_empty: not Result.is_empty
		end

	test_event_xml_uri: UT_URI is
			-- URI of file 'test_event.xml'
		local
			a_path: STRING
		once
			a_path := file_system.pathname (data_dirname, "test_event.xml")
			Result := File_uri.filename_to_uri (a_path)
		ensure
			test_event_xml_uri_not_void: Result /= Void
		end

end

