note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
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
			s: STRING_32
			f: RAW_FILE
		do
			s :=
"[
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
		<library name="testing" location="$ISE_LIBRARY\library\testing\testing-safe.ecf"/>
		<library name="xml_parser" location="$ISE_LIBRARY\library\text\parser\xml\parser\xml_parser-safe.ecf" readonly="false"/>
		<library name="xml_tree" location="$ISE_LIBRARY\library\text\parser\xml\tree\xml_tree-safe.ecf"/>

		<tests name="src" location="." recursive="true"/>
	</target>
</system>
]"

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
			generate_xml (xml_file_name ("test.xml"), d)
			p.parse_from_path (xml_file_name ("test.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has no unicode", not vis_uc.has_unicode)

			generate_ecf (xml_file_name ("ecf.xml"))
			p.parse_from_path (xml_file_name ("ecf.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has no unicode", not vis_uc.has_unicode)

		end

end


