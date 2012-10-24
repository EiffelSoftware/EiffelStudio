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
			create e.make_last (Result.root_element, "xhtml:test", def_ns)

		end

	generate_xml (fn: STRING_32; d: XML_DOCUMENT)
		local
			vis: XML_FORMATTER
			u: FILE_UTILITIES
			f: FILE
		do
			create vis.make
			f := u.make_raw_file (fn)
			f.open_write
			vis.set_output_file (f)
			vis.process_document (d)
			f.close
		end

	generate_ecf (fn: STRING_32)
		local
			s: STRING_32
			u: FILE_UTILITIES
			f: FILE
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

			f := u.make_raw_file (fn)
			f.open_write
			f.put_string (s)
			f.close
		end

	xml_file_name (a_name: STRING_32): STRING_32
		local
			fn: FILE_NAME_32
		do
			create fn.make_from_string (execution_environment.current_working_directory)
--			across 1 |..| 5 as c loop fn.extend ("..") end

			fn.set_file_name (a_name)
			Result := fn.to_string_32
		end

	new_callbacks_pipe (a_output: STRING_GENERAL; cbs: detachable ARRAY [XML_CALLBACKS_FILTER]; cb: detachable XML_CALLBACKS): XML_CALLBACKS
		local
			pretty: XML_PRETTY_PRINT_FILTER
--			pretty: XML_INDENT_PRETTY_PRINT_FILTER
			endtags: XML_END_TAG_CHECKER
			fact: XML_CALLBACKS_FILTER_FACTORY
			l_last: XML_CALLBACKS_FILTER
		do
			create fact

			create pretty.make_null
			l_last := pretty
			pretty.set_output_string (a_output)
			create endtags.set_next (pretty)
			if cbs /= Void and then not cbs.is_empty then
				l_last.set_next (fact.callbacks_pipe (cbs))
				l_last := cbs.item (cbs.upper)
			end
			if cb /= Void then
				l_last.set_next (cb)
			end

			Result := fact.standard_callbacks_pipe (<<endtags>>)
		end

	test_xml_parser_string_8
			-- New test routine
		local
			p: XML_LITE_PARSER
			d: like new_doc
			s: STRING
			doc_cb: XML_CALLBACKS_DOCUMENT
			test_cbs: TEST_STRING_8_XML_CALLBACKS
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
		do
			create p.make_ascii

			create s.make_empty
			create doc_cb.make_null
			create test_cbs.make (doc_cb)
			p.set_callbacks (new_callbacks_pipe (s, Void, test_cbs))

			create vis_uc

			d := new_doc
			generate_xml (xml_file_name ("test.xml"), d)
			p.parse_from_filename (xml_file_name ("test.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has no unicode", not vis_uc.has_unicode)

			generate_ecf (xml_file_name ("ecf.xml"))
			p.parse_from_filename (xml_file_name ("ecf.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has no unicode", not vis_uc.has_unicode)

		end

	test_xml_parser_unicode
			-- New test routine
		local
			p: XML_LITE_PARSER
			d: like new_doc
			s: STRING
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
		do
			create p.make_unicode

			create s.make_empty

--			p.set_callbacks (ns_cb)
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			d := new_doc
			generate_xml (xml_file_name ("test.xml"), d)
			p.parse_from_filename (xml_file_name ("test.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
			assert ("has unicode", vis_uc.has_unicode)
		end

	test_xml_parser_unicode_ecf
			-- New test routine
		local
			p: XML_LITE_PARSER
			s: STRING
			doc_cb: XML_CALLBACKS_DOCUMENT
			vis_uc: XML_HAS_UNICODE_NODE_VISITOR
		do
			create p.make_unicode
			create s.make_empty
			create doc_cb.make_null
			p.set_callbacks (new_callbacks_pipe (s, Void, doc_cb))
			create vis_uc

			generate_ecf (xml_file_name ("ecf.xml"))
			p.parse_from_filename (xml_file_name ("ecf.xml"))
			assert ("parsed", p.is_correct)
			assert ("succeed", not p.error_occurred)

			vis_uc.reset
			vis_uc.process_document (doc_cb.document)
		end

end


