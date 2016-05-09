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
			xml_resolver: detachable XM_NAMESPACE_RESOLVER

			resolver: detachable XM_NAMESPACE_RESOLVER
			tree: XM_CALLBACKS_TO_TREE_FILTER
		do
			create parser.make
			parser.set_string_mode_mixed

			get_parser_mode

			inspect
				parser_mode
			when debug_mode then
				parser.set_callbacks (create {XML_CALLBACKS_DEBUG})
			when tree_mode then
				tree := new_tree_builder
				create resolver.make_next (tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)
			when xml_tree_mode, xml_tree_vis_mode then
				create xml_tree.make_null
				create xml_resolver.make_next (xml_tree)
				xml_resolver.set_forward_xmlns (True)
				parser.set_callbacks (xml_resolver)
			when null_mode then
			else
			end

			if attached filename as fn then
				test (fn)
			end

		end

	after_test_entry (fn: STRING)
		local
			vis: detachable XML_NODE_VISITOR_PRINT
		do
			if
				parser_mode = xml_tree_vis_mode and then
				attached xml_tree as t and then
				attached t.document as doc
			then
				create vis
				vis.process_document (doc)
			end

			print ("%N")

			if attached last_error_position as pos then
				print ("Error occurred: ")
				print (pos)
				print ("%N")
			end
			if attached last_error_message as msg then
				print ("Error message: ")
				print (msg)
				print ("%N")
			end
		end

	last_error_position: detachable XM_POSITION

	last_error_message: detachable STRING

	parser: XM_EIFFEL_PARSER

	xml_tree: detachable XML_CALLBACKS_TREE
		note option: stable attribute end

	test_file (fn: STRING)
		local
			f: RAW_FILE
			l_xml_file: KL_BINARY_INPUT_FILE
		do
			last_error_position := Void

			print ("Parsing " + fn + "%N")
			create l_xml_file.make (fn)
			l_xml_file.open_read
			print ("Start%N")
			start_chrono
			parser.parse_from_stream (l_xml_file)
			stop_chrono
			print ("End%N")
			l_xml_file.close

			if not parser.is_correct then
				last_error_position := parser.position
				last_error_message := parser.last_error_description
			end
		end

	test_file_content (fn: STRING)
		local
			s: STRING
		do

			s := file_content (fn)

			print ("Parsing " + fn + " as string%N")
			print ("Start%N")
			start_chrono
			parser.parse_from_string (s)
			stop_chrono
			print ("End%N")
			if parser.last_error > 0 then
				last_error_position := parser.position
				last_error_message := parser.last_error_description
			end
		end


note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
