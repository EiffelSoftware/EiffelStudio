note
	description: "Eiffel tests that can be executed by testing tool."
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_XML

inherit
	EQA_TEST_SET

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

feature -- Test routines

	factory: XML_PARSER_FACTORY
		once
			create Result
		end

	new_doc: XML_DOCUMENT
		local
			e: XML_ELEMENT
			a: XML_ATTRIBUTE
			c: XML_CHARACTER_DATA
			s32: STRING_32
			ns: XML_NAMESPACE
			def_ns: XML_NAMESPACE
		do
			create ns.make ("xhtml", "http://www.w3.org/1999/xhtml")
			create def_ns.make_default
			create Result.make_with_root_named ("DOCUMENT", def_ns)
			create e.make_last (Result.root_element, "section", def_ns)
			create a.make_last ("name", def_ns, generator, e)
			create e.make_last (e, "description", def_ns)
			create s32.make (3)
			s32.append_code (20320)
			s32.append_code (22909)
			s32.append_code (21527)
			create c.make_last (e, s32)

			create e.make_last (Result.root_element, "fo:root", def_ns)
			e.add_attribute ("xmlns:fo", def_ns, "http://www.w3.org/1999/XSL/Format")
			create e.make_last (e, "fo:test", def_ns)
		end

	new_doc_with_unicode_tag: XML_DOCUMENT
		local
			e: XML_ELEMENT
			s32: STRING_32
			def_ns: XML_NAMESPACE
		do
			create def_ns.make_default

			Result := new_doc
			create s32.make (3)
			s32.append_code (20320)
			s32.append_code (22909)
			s32.append_code (21527)

			create e.make_last (Result.root_element, {STRING_32} "unicode-" + s32, def_ns)
		end

	generate_xml (fn: PATH; d: XML_DOCUMENT)
		local
			vis: XML_FORMATTER
			f: RAW_FILE
		do
			create vis.make
			create f.make_with_path (fn)
			f.open_write
			vis.set_output_file (f)
			vis.process_document (d)
			f.close
		end

	generate_xml_from_string (fn: PATH; s: READABLE_STRING_8)
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			f.open_write
			f.put_string (s)
			f.close
		end

	doc_to_string_32 (d: XML_DOCUMENT): STRING_32
		local
			vis: XML_FORMATTER
			o: XML_STRING_32_OUTPUT_STREAM
		do
			create Result.make_empty
			create o.make (Result)
			create vis.make
			vis.set_output (o)
			vis.process_document (d)
		end

	doc_to_utf8 (d: XML_DOCUMENT): STRING_8
		local
			vis: XML_FORMATTER
			f: XML_CHARACTER_8_OUTPUT_STREAM_UTF8_FILTER
			o: XML_STRING_8_OUTPUT_STREAM
			u: UTF_CONVERTER
			decl: XML_DECLARATION
		do
			create Result.make_empty
			Result.append (u.utf_8_bom_to_string_8)
			if attached d.xml_declaration as x_decl then
				x_decl.set_encoding ("UTF-8")
			else
				create decl.make_in_document (d, "1.0", "UTF-8", False)
			end
			create o.make (Result)
			create f.make (o)
			create vis.make
			vis.set_output (f)
			vis.process_document (d)
		end

	generate_ecf (fn: PATH)
		local
			s: STRING_8
			f: RAW_FILE
		do
			s := ecf_content_with_size (0)
			create f.make_with_path (fn)
			f.open_write
			f.put_string (s)
			f.close
		end

	ecf_content_with_size (a_size: INTEGER): STRING_8
		require
			a_size = 0 or a_size > 1070 -- current content of manifest string, see below
		local
			t: STRING_8
		do
			Result := "[
					<?xml version="1.0" encoding="ISO-8859-1"?>
					<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-8-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-8-0 http://www.eiffel.com/developers/xml/configuration-1-8-0.xsd" name="tests" uuid="8E006284-3BDE-4DB9-9F1B-ED1322ABD360">
						<target name="tests">
							<root class="ANY" feature="default_create"/>
							<file_rule>
								<exclude>/.git$</exclude>
								<exclude>/EIFGENs$</exclude>
								<exclude>/.svn$</exclude>
							</file_rule>
							<option warning="true" full_class_checking="true" is_attached_by_default="true" void_safety="all" syntax="standard">
								<assertions precondition="true" postcondition="true" supplier_precondition="true"/>
							</option>
							<setting name="concurrency" value="none"/>
							<library name="base" location="$ISE_LIBRARY\library\base\base-safe.ecf"/>
							<library name="testing" location="$ISE_LIBRARY\library\testing\testing-safe.ecf" readonly="false"/>
							<tests name="src" location="." recursive="true"/>
						</target>
					</system>
				]"
			check Result.count = 1070 end
			if a_size > 0 then
				if Result.count < a_size then
					t := "</system>"
					t.prepend (create {STRING_8}.make_filled (' ', a_size - Result.count))
					Result.replace_substring_all ("</system>", t)
				end
				check Result.count = a_size end
			end
		end

	generate_ecf_with_size (fn: PATH; a_size: INTEGER)
		local
			s: STRING_8
			f: RAW_FILE
		do
			s := ecf_content_with_size (a_size)
			create f.make_with_path (fn)
			f.open_write
			f.put_string (s)
			f.close
		end

	generate_ecf_truncated_at_size (fn: PATH; a_size: INTEGER; a_end: READABLE_STRING_8)
		local
			s: STRING_8
			f: RAW_FILE
			t: READABLE_STRING_8
		do
			t := "</system>"

			s := ecf_content_with_size (a_size - a_end.count + t.count)
			s.replace_substring_all (t, a_end)
			check s.count = a_size end
			create f.make_with_path (fn)
			f.open_write
			f.put_string (s)
			f.close
		end

	xml_file_name (a_name: READABLE_STRING_GENERAL): PATH
		do
			Result := execution_environment.current_working_path
--			across 1 |..| 5 as c loop Result := Result.extended ("..") end

			Result := Result.extended (a_name)
		end

	new_callbacks_pipe (a_output: STRING_GENERAL; cbs: detachable ARRAY [XML_CALLBACKS_FILTER]; cb: detachable XML_CALLBACKS): XML_CALLBACKS
		local
			pretty: XML_PRETTY_PRINT_FILTER
			endtags: XML_END_TAG_CHECKER
			fact: XML_CALLBACKS_FILTER_FACTORY
			l_last: XML_CALLBACKS_FILTER
			l_end: XML_CALLBACKS_FILTER
		do
			create fact
			create l_last.make_null
			l_end := l_last

			create pretty.make_with_next (l_last)
			pretty.set_output_string (a_output)
			l_end := pretty

			create endtags.set_next (l_end)
			l_end := endtags

			if cbs /= Void and then not cbs.is_empty then
				l_last.set_next (fact.callbacks_pipe (cbs))
				l_last := cbs.item (cbs.upper)
			end
			if cb /= Void then
				l_last.set_next (cb)
			end

			Result := fact.standard_callbacks_pipe (<<l_end>>)
		end

	test_xml_parser
			-- New test routine
		local
			p: XML_PARSER
			d: like new_doc
			s: STRING
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
		do
			p := factory.new_parser

			create s.make_empty

--			p.set_callbacks (ns_cb)
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			d := new_doc
			generate_xml (xml_file_name ("test.xml"), d)
			p.parse_from_path (xml_file_name ("test.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has unicode", vis_uc.has_unicode)
		end

	test_xml_parser_without_start
			-- If you do not call `start' on input stream and let the parser
			-- call it for you, it will fail to parse the XML file when it should
			-- just be ok.
		local
			p: XML_PARSER
			l_input: XML_FILE_INPUT_STREAM
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				p := factory.new_parser
				create l_file.make_open_write ("test_xml_parser_without_start.xml")
				l_file.put_string ("<system></system>")
				l_file.close
				create l_input.make_with_filename ("test_xml_parser_without_start.xml")
				p.parse_from_stream (l_input)
				l_input.close
				assert ("parsed", p.is_correct)
				assert ("succeed", not p.error_occurred)
				assert ("exception raised", False) --!!!
			end
		rescue
			assert ("exception raised", True)
			retried := True
			retry
		end

	test_xml_parser_with_unicode_tag
			-- New test routine
		local
			p: XML_PARSER
			d: like new_doc_with_unicode_tag
			s: STRING_32
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
		do
			p := factory.new_parser

			create s.make_empty

--			p.set_callbacks (ns_cb)
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			d := new_doc_with_unicode_tag
			p.parse_from_string_32 (doc_to_string_32 (d))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has unicode", vis_uc.has_unicode)
		end

	test_xml_parser_ecf
			-- New test routine
		local
			p: XML_PARSER
			s: STRING_32
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
		do
			p := factory.new_parser
			create s.make_empty
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			generate_ecf (xml_file_name ("ecf.xml"))
			p.parse_from_path (xml_file_name ("ecf.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
		end

	test_xml_parser_ecf_file_size_as_chunk_size
			-- New test routine
		local
			p: XML_PARSER
			s: STRING_32
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
			l_input: XML_FILE_INPUT_STREAM
		do
			p := factory.new_parser
			create s.make_empty
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			create l_input.make_with_path (xml_file_name ("file_size_as_chunk_size-ecf.xml"))
			generate_ecf_with_size (xml_file_name ("file_size_as_chunk_size-ecf.xml"), l_input.chunk_size)
--			p.parse_from_path (xml_file_name ("ecf.xml"))
			l_input.open_read
			l_input.start
			p.parse_from_stream (l_input)
			l_input.close
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
		end

	test_xml_parser_ecf_file_size_truncated_at_various_chunk_size
			-- New test routine
		local
			p: XML_PARSER
			s: STRING_8
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
			l_end_checker: XML_END_TAG_CHECKER
			l_input: XML_FILE_INPUT_STREAM
			n: INTEGER
			l_chunk_size: INTEGER
		do
			p := factory.new_parser
			create s.make_empty
			create doc_cb.make_null
			create l_end_checker.make_null
			l_end_checker.set_associated_parser (p)

			p.set_callbacks (new_callbacks_pipe (s, <<l_end_checker>>, doc_cb))
			create vis_uc

			s := ecf_content_with_size (2_000)
			n := s.count
			generate_xml_from_string (xml_file_name ("truncated_at_various_chunk_size-ecf.xml"), s)

			across
				(1 |..| (2 * n)) as ic
			loop
				l_chunk_size := ic
				print ("Chunk size=" + l_chunk_size.out + "%N")
				create l_input.make_with_path (xml_file_name ("truncated_at_various_chunk_size-ecf.xml"))
				l_input.set_chunk_size (l_chunk_size)
				l_input.open_read
				l_input.start
				p.parse_from_stream (l_input)
				l_input.close

				assert ("parsed", p.is_correct)
				assert ("succeed", not p.error_occurred)
			end

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
		end

	test_xml_parser_ecf_file_size_truncated_at_chunk_size
			-- New test routine
		local
			p: XML_PARSER
			s: STRING_32
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
			l_end_checker: detachable XML_END_TAG_CHECKER
			l_input: XML_FILE_INPUT_STREAM
		do
			p := factory.new_parser
			create s.make_empty
			create doc_cb.make_null

			p.set_callbacks (new_callbacks_pipe (s, <<>>, doc_cb))
			create vis_uc

			create l_input.make_with_path (xml_file_name ("truncated_at_chunk-ecf.xml"))
			generate_ecf_truncated_at_size (xml_file_name ("truncated_at_chunk-ecf.xml"), l_input.chunk_size, "</foo_bar>")

			l_input.open_read
			l_input.start

--			p.parse_from_path (xml_file_name ("ecf.xml"))
			p.parse_from_stream (l_input)
			l_input.close
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			create vis_uc
			vis_uc.reset
			vis_uc.process_document (doc_cb.document)

			create doc_cb.make_null
			create l_end_checker.make_null
			l_end_checker.set_associated_parser (p)
			p.set_callbacks (new_callbacks_pipe (s, <<l_end_checker>>, doc_cb))

				-- checking end tags
			create l_input.make_with_path (xml_file_name ("truncated_at_chunk-ecf.xml"))
			l_input.open_read
			l_input.start

--			p.parse_from_path (xml_file_name ("ecf.xml"))
			p.parse_from_stream (l_input)
			l_input.close
			assert ("end tag mismatch", p.error_occurred)

		end

	test_xml_parser_ecf_text_size_4096
			-- New test routine
		local
			p: XML_PARSER
			s: STRING_32
			l_content: STRING_32
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
		do
			p := factory.new_parser
			create s.make_empty
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			l_content := ecf_content_with_size (4_096)
			p.parse_from_string (l_content)
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
		end

	test_xml_parser_with_unicode_tag_and_utf8
			-- New test routine
		local
			p: XML_PARSER
			d: like new_doc_with_unicode_tag
			s: STRING_32
			s8: STRING_8
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
			u: UTF_CONVERTER
			vis_tester: XML_NODE_TESTER
		do
			p := factory.new_parser

			create s.make_empty

--			p.set_callbacks (ns_cb)
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))

			d := new_doc_with_unicode_tag
			s8 := doc_to_utf8 (d)
			if attached u.utf_8_string_8_to_string_32 (s8) as s32 then

			end
			p.parse_from_string_8 (s8)
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			create vis_uc
			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has unicode", vis_uc.has_unicode)

			create vis_tester
			vis_tester.reset
			vis_tester.process_document (doc_cb.document)
			assert ("has no error", not vis_tester.has_error)

		end

	test_xml_parser_with_unicode_tag_and_utf8_detection
			-- New test routine
		local
			p: XML_PARSER
			d: like new_doc_with_unicode_tag
			s: STRING_32
			s8: STRING_8
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
			u: UTF_CONVERTER
		do
			p := factory.new_parser

			create s.make_empty

--			p.set_callbacks (ns_cb)
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			d := new_doc_with_unicode_tag
			s8 := doc_to_utf8 (d)
			if attached u.utf_8_string_8_to_string_32 (s8) as s32 then

			end

			p.parse_from_string_8 (s8)
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has unicode", vis_uc.has_unicode)
		end

feature -- ASCII

	test_xml_parser_ascii
			-- New test routine
		local
			p: XML_PARSER
			d: like new_doc
			s: STRING
			doc_cb: XML_CALLBACKS_DOCUMENT
			test_cbs: TEST_XML_ASCII_CALLBACKS
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
			ascii_fwd: XML_FORWARD_TO_ASCII_CALLBACKS
		do
			p := factory.new_parser

			create s.make_empty
			create doc_cb.make_null
			create test_cbs.make_null
			create ascii_fwd.make (test_cbs)
			p.set_callbacks (new_callbacks_pipe (s, Void, ascii_fwd))

			create vis_uc

			d := new_doc
			generate_xml (xml_file_name ("ascii-test.xml"), d)
			p.parse_from_path (xml_file_name ("ascii-test.xml"))

			if attached p.error_message as err then
				print (err)
				print ("%N")
			end
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has no unicode", not vis_uc.has_unicode)

			generate_ecf (xml_file_name ("ascii-ecf.xml"))
			p.parse_from_path (xml_file_name ("ascii-ecf.xml"))
			if attached p.error_message as err then
				print (err)
				print ("%N")
			end
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has no unicode", not vis_uc.has_unicode)
		end

	test_xml_contents
		do
				-- valid
			test_xml_content ("case_valid_001", True, False, "<doc/>")
			test_xml_content ("case_valid_002", True, False, "<D/>")
			test_xml_content ("case_valid_003", True, False, "<foo><bar></bar></foo>")
			test_xml_content ("case_valid_004", True, False, "<foo><bar  ></bar></foo>")
			test_xml_content ("case_valid_005", True, False, "<foo><bar ></bar ></foo>")
			test_xml_content ("case_valid_006", True, False, "<foo><bar att=%"test%"></bar></foo>")
			test_xml_content ("case_valid_007", True, False, "<foo><bar att=%"test%" ></bar></foo>")
			test_xml_content ("case_valid_008", True, False, "<foo><bar att=%"test%" %T></bar></foo>")
			test_xml_content ("case_valid_009", True, False, "<foo><bar att=%"test%"/></foo>")
			test_xml_content ("case_valid_010", True, False, "<foo><bar att=%"test%" /></foo>")
			test_xml_content ("case_valid_011", True, False, "<foo><bar att=%"test%" att2=%"test%"></bar></foo>")
			test_xml_content ("case_valid_012", True, False, "<foo><bar att=%"test%" %T att2=%"test%"></bar></foo>")

				-- not well formed
			test_xml_content ("case_invalid_001", False, False, "<doc><></doc>")
			test_xml_content ("case_invalid_002", False, False, "<doc></></doc>")
			test_xml_content ("case_invalid_003", False, False, "<doc><?></doc>")
			test_xml_content ("case_invalid_004", False, False, "<doc><123></123></doc>")
			test_xml_content ("case_invalid_005", False, False, "<doc><foo'bar/></doc>")
			test_xml_content ("case_invalid_006", False, False, "</>")
			test_xml_content ("case_invalid_007", False, False, "<doc>aa<//doc>")
			test_xml_content ("case_invalid_008", False, False, "<doc>aa</doc><//")

				-- valid but truncated
			test_xml_content ("case_truncated_001", True, True, "<doc")
			test_xml_content ("case_truncated_002", True, True, "<doc ")
			test_xml_content ("case_truncated_003", True, True, "<doc  %T")
			test_xml_content ("case_truncated_004", True, True, "<doc foo")
			test_xml_content ("case_truncated_005", True, True, "<doc foo=")
			test_xml_content ("case_truncated_006", True, True, "<doc foo=%"")
			test_xml_content ("case_truncated_007", True, True, "<doc foo=%"bar")
			test_xml_content ("case_truncated_008", True, True, "<doc foo=%"bar%"")
			test_xml_content ("case_truncated_009", True, True, "<doc foo=%"bar%"  ")
			test_xml_content ("case_truncated_010", True, True, "<doc foo=%"bar%"  ><")
		end

	test_valid_xml_01
		do
			test_xml_content ("valid_xml_01", True, False, valid_xml_01)
		end

	test_bad_xml_01
		do
			test_xml_content ("bad_xml_01", False, False, bad_xml_01)
		end

	test_bad_xml_02
		do
			test_xml_content ("bad_xml_02", False, False, bad_xml_02)
		end

	test_bad_xml_03
		do
			test_xml_content ("bad_xml_03", False, False, bad_xml_03)
		end

	test_bad_xml_04
		do
			test_xml_content ("bad_xml_04", False, False, bad_xml_04)
		end

	test_bad_xml_05
		do
			test_xml_content ("bad_xml_05", False, False, bad_xml_05)
		end

	test_bad_xml_06
		do
			test_xml_content ("bad_xml_06", False, False, bad_xml_06)
		end

	test_bad_xml_07
		do
			test_xml_content ("bad_xml_07", False, False, bad_xml_07)
		end

	test_bad_xml_08
		do
			test_xml_content ("bad_xml_08", False, False, bad_xml_08)
		end

	test_bad_xml_09
		do
			test_xml_content ("bad_xml_08", False, False, bad_xml_08)
		end

	test_cdata
		do
			test_xml_content ("cdata_01", True, False, "<doc><![CDATA[<author>John Smith</author>]]></doc>")
			test_xml_content ("cdata_02", True, False, "<doc><![CDATA[]]></doc>") -- empty
			test_xml_content ("cdata_03", True, False, "<doc><![CDATA[<author>John Smith</author>]]><![CDATA[<author>Foo Bar</author>]]></doc>")
			test_xml_content ("cdata_04", True, False, "<doc><![CDATA[]]><![CDATA[]]></doc>") -- empty
		end

	test_cdata_bracket
		do
			test_xml_content ("cdata_bracket_01", True, False, "<doc><![CDATA[]]]]></doc>") -- ]]
			test_xml_content ("cdata_bracket_02", True, False, "<doc><![CDATA[]]]]><![CDATA[>]]></doc>")
		end

	test_entity_at_end_of_input
		local
			p: XML_PARSER
			doc_cb: XML_CALLBACKS_DOCUMENT
			s: STRING_8
		do
			print ("Testing case MarkH%N")
			p := Factory.new_parser
			create s.make_empty
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
				-- valid
			p.parse_from_string ("<foo att=%"AT&ampT")
			p.parse_from_string_32 ({STRING_32} "<foo att=%"AT&ampT")
			p.parse_from_string_32 ({STRING_32} "<doc><foo att=%"AT&ampT%">AT&ampT</foo><foo att=%"AT&ampT%">AT&ampT</foo></doc>")
			assert ("mark", not p.is_correct)
		end

feature {NONE} -- XML content

	test_xml_content (a_assert_name: READABLE_STRING_8; a_expecting_success: BOOLEAN; a_expecting_truncation_reported: BOOLEAN; a_xml_content: READABLE_STRING_8)
		local
			p: XML_PARSER
			doc_cb: XML_CALLBACKS_DOCUMENT
			s: STRING
		do
			print ("Testing case %"" + a_assert_name + "%"%N")
			p := factory.new_parser

			create s.make_empty
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))

				-- As file input
			generate_xml_from_string (xml_file_name (a_assert_name + "-test.xml"), a_xml_content)
			p.parse_from_path (xml_file_name (a_assert_name + "-test.xml"))
			if a_expecting_success then
				assert ("test:" + a_assert_name + ":file:parsed", p.is_correct)
				assert ("test:" + a_assert_name + ":file:succeed", not p.error_occurred)
				assert ("test:" + a_assert_name + ":file:truncation_reported", p.truncation_reported = a_expecting_truncation_reported)
			else
				if attached p.error_message as err then
					print (err)
					print ("%N")
				elseif p.error_occurred then
					print ("error without message!%N")
				end

				assert ("test:" + a_assert_name + ":file:error", not p.is_correct or p.error_occurred)
			end

				-- As string input
			p.parse_from_string (a_xml_content)
			if a_expecting_success then
				assert ("test:" + a_assert_name + ":string:parsed", p.is_correct)
				assert ("test:" + a_assert_name + ":string:succeed", not p.error_occurred)
				assert ("test:" + a_assert_name + ":string:truncation_reported", p.truncation_reported = a_expecting_truncation_reported)
			else
				if attached p.error_message as err then
					print (err)
					print ("%N")
				elseif p.error_occurred then
					print ("error without message!%N")
				end

				assert ("test:" + a_assert_name + ":string:error", not p.is_correct or p.error_occurred)
			end
		end

	valid_xml_01: STRING
		do
			Result :=
				"[
					<DOCUMENT><section name="TEST_XML"><description>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_01: STRING
		do
			Result := -- see name=!TE...
				"[
					<DOCUMENT><section name=!TEST_XML"><description>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_02: STRING
		do
			Result := -- see <<desc
				"[
					<DOCUMENT><section name="TEST_XML"><<description>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_03: STRING
		do
			Result := -- see description//>
				"[
					<DOCUMENT><section name="TEST_XML"><description//>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_04: STRING
		do
			Result := -- see name@foo=
				"[
					<DOCUMENT><section name@foo="TEST_XML"><description>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_05: STRING
		do
			Result := -- see name+foo+bar=
				"[
					<DOCUMENT><section name+foo+bar="TEST_XML"><description>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_06: STRING
		do
			Result := -- see <foo&#20320;>
				"[
					<DOCUMENT><section name="TEST_XML"><foo&#20320;>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_07: STRING
		do
			Result := -- see bad-attrib
				"[
					<DOCUMENT><section bad-attrib name="TEST_XML"><description>&#20320;&#22909;&#21527;</description></section><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"><fo:test></fo:test></fo:root></DOCUMENT>
				]"
		end

	bad_xml_08: STRING
		do
			Result := -- see bad-attrib
				"[
					<DOCUMENT><section name="TEST_XML"?/></DOCUMENT>
				]"
		end

	bad_xml_09: STRING
		do
			Result := -- see bad-attrib
				"[
					<DOCUMENT><section name="TEST_XML"/></DOCUMENT>>
				]"
		end

end

