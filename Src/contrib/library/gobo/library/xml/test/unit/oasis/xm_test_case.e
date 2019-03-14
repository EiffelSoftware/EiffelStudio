note

	description:

		"Base class for XML parser test cases"

	library: "Gobo Eiffel XML Library test"
	copyright: "Copyright (c) 2002-2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class XM_TEST_CASE

inherit

	TS_TEST_CASE
		redefine
			make_default
		end

	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

	UC_UNICODE_FACTORY
		export {NONE} all end

	KL_SHARED_STANDARD_FILES
		export {NONE} all end

feature {NONE} -- Initialization

	make_default
			-- <Precursor>
		do
			precursor
			parser := new_parser
			reset_parser
		end

feature -- XML asserts

	assert_valid (a_name: STRING; in: STRING)
			-- Assert valid.
		require
			name_not_void: a_name /= Void
			in_not_void: in /= Void
		do
			reset_parser
			parser.parse_from_string (new_unicode_string_from_utf8 (in))
			debug ("xml_parser") print_parser_error end
			assert (a_name, not error.has_error)
		end

	assert_invalid (a_name: STRING; in: STRING)
			-- Assert invalid.
		require
			name_not_void: a_name /= Void
			in_not_void: in /= Void
		local
			l_stream: KL_STRING_INPUT_STREAM
		do
			reset_parser
			create l_stream.make (in)
			parser.parse_from_stream (l_stream)
			assert (a_name, error.has_error)
		end


	assert_output (a_name: STRING; in: STRING; an_out: STRING)
			-- Assert valid and compare output with expected.
		require
			name_not_void: a_name /= Void
			in_not_void: in /= Void
			out_not_void: out /= Void
		local
			l_last_output: detachable STRING
		do
			reset_parser
			parser.parse_from_string (new_unicode_string_from_utf8 (in))
			debug ("xml_parser") print_parser_error end

			assert (STRING_.concat ("Valid: ", a_name), parser.is_correct)

				-- Constants are in UTF8, so convert if UC_STRING.
			l_last_output := printer.last_output
			assert ("set_output_to_string_in_reset_parser", l_last_output /= Void)
			check asserted_above: l_last_output /= Void then end
			assert (STRING_.concat ("Output: ", a_name), STRING_.same_string (new_unicode_string_from_utf8 (an_out), l_last_output))
		end

	assert_output_utf16 (a_name: STRING; in_utf16: STRING; an_out: STRING)
			-- Assert valid and compare output with expected.
		require
			name_not_void: a_name /= Void
			in_not_void: in_utf16 /= Void
			out_not_void: out /= Void
		local
			l_last_output: detachable STRING
		do
			reset_parser
			parser.parse_from_string (new_unicode_string_from_utf16 (in_utf16))
			debug ("xml_parser") print_parser_error end

			assert (STRING_.concat ("Valid: ", a_name), parser.is_correct)
			l_last_output := printer.last_output
			assert ("set_output_to_string_in_reset_parser", l_last_output /= Void)
			check asserted_above: l_last_output /= Void then end
			assert (STRING_.concat ("Output: ", a_name), STRING_.same_string (new_unicode_string_from_utf8 (an_out), l_last_output))
		end

	assert_valid_external (a_name: STRING; in: STRING; a_resolver: XM_TEST_STRING_EXTERNAL_RESOLVER)
			-- Assert valid with external entities.
		require
			name_not_void: a_name /= Void
			in_not_void: in /= Void
		do
			reset_parser
			a_resolver.initialize
			parser.set_dtd_resolver (a_resolver)
			parser.set_entity_resolver (a_resolver)
			parser.parse_from_string (new_unicode_string_from_utf8 (in))
			debug ("xml_parser") print_parser_error end

			assert (a_name, not error.has_error)
			assert ("resolver_depth", a_resolver.depth = 0)
		end

	assert_invalid_external (a_name: STRING; in: STRING; a_resolver: XM_EXTERNAL_RESOLVER)
			-- Assert invalid with external entities.
		require
			name_not_void: a_name /= Void
			in_not_void: in /= Void
		do
			reset_parser
			parser.set_dtd_resolver (a_resolver)
			parser.set_entity_resolver (a_resolver)
			parser.parse_from_string (new_unicode_string_from_utf8 (in))
			debug ("xml_parser") print_parser_error end

			assert (a_name, error.has_error)
		end

	assert_output_external (a_name: STRING; in: STRING; an_out: STRING; a_resolver: XM_EXTERNAL_RESOLVER)
			-- Assert output valid with external.
		require
			name: a_name /= Void
			in_not_void: in /= Void
		local
			l_last_output: detachable STRING
		do
			reset_parser
			parser.set_dtd_resolver (a_resolver)
			parser.set_entity_resolver (a_resolver)
			parser.parse_from_string (new_unicode_string_from_utf8 (in))
			debug ("xml_parser") print_parser_error end

			assert (STRING_.concat ("Valid: ", a_name), parser.is_correct)
			l_last_output := printer.last_output
			assert ("set_output_to_string_in_reset_parser", l_last_output /= Void)
			check asserted_above: l_last_output /= Void then end
			assert (STRING_.concat ("Output: ", a_name), STRING_.same_string (new_unicode_string_from_utf8 (an_out), l_last_output))
		end

feature {NONE} -- Debug

	print_parser_error
			-- Debug: print error
		do
			if not parser.is_correct then
				std.output.put_string (parser.last_error_description)
				std.output.put_new_line
			end
		end

feature {NONE} -- Parser

	parser: XM_PARSER
			-- XML parser

	printer: XM_CANONICAL_PRETTY_PRINT_FILTER
			-- Pretty print filter

	error: XM_STOP_ON_ERROR_FILTER
			-- Error collector

	new_parser: XM_EIFFEL_PARSER
			-- New parser
			-- (Can be redefined to test another parser.)
		do
			create Result.make
			Result.disable_namespaces
		end

	reset_parser
			-- Reset parser.
		local
			an_attribute: XM_ATTRIBUTE_DEFAULT_FILTER
			a_error: XM_CALLBACKS_FILTER
		do
			parser := new_parser
			parser.set_string_mode_mixed

			error := new_stop_on_error
			a_error := error
			printer := new_canonical_pretty_print
			printer.set_output_to_string
			create an_attribute.make_null
			parser.set_dtd_callbacks (an_attribute)
			parser.set_callbacks (callbacks_pipe (<<
				new_unicode_validation,
				an_attribute,
				a_error,
				printer >>))
		ensure
			parser_not_void: parser /= Void
			printer_not_void: printer /= Void
		end

end
