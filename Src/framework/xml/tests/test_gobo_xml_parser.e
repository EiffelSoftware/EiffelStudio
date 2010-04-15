note
	description : "test/example for Gobo's XM_PARSER"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_GOBO_XML_PARSER

inherit
	TEST_PARSER

	XM_CALLBACKS_FILTER_FACTORY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			xml_tree: XML_CALLBACKS_TREE
			xml_resolver: XML_NAMESPACE_RESOLVER

			resolver: XM_NAMESPACE_RESOLVER
			tree: XM_CALLBACKS_TO_TREE_FILTER
			parser: XM_EIFFEL_PARSER
			vis: XML_NODE_VISITOR_PRINT
		do
			create parser.make
			parser.set_string_mode_mixed

			get_parser_mode

			inspect
				parser_mode
			when debug_mode then
				parser.set_callbacks (create {XML_CALLBACKS_DEBUG})
			when tree_mode then
				tree :=  new_tree_builder
				create resolver.set_next (tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)
			when xml_tree_mode, xml_tree_vis_mode then
				create xml_tree.make
				create xml_resolver.set_next (xml_tree)
				xml_resolver.set_forward_xmlns (True)
				parser.set_callbacks (xml_resolver)
			when null_mode then
			else
			end

			if attached filename as fn then
				test_file (fn, parser)
			end

			if
				parser_mode = xml_tree_vis_mode and then
				attached xml_tree as t and then
				attached t.document as doc
			then
				create vis
				vis.process_document (doc)
			end
			report_chrono

		end

	test_file (fn: STRING; a_parser: XM_PARSER)
		local
			f: RAW_FILE
			l_xml_file: KL_BINARY_INPUT_FILE
		do
			print ("Parsing " + fn + "%N")
			create l_xml_file.make (fn)
			l_xml_file.open_read
			print ("Start%N")
			start_chrono
			a_parser.parse_from_stream (l_xml_file)
			stop_chrono
			print ("End%N")
			l_xml_file.close
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
