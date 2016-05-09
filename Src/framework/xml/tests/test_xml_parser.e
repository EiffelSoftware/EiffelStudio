note
	description : "test/example for XML_PARSER"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_XML_PARSER

inherit
	TEST_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			resolver: detachable XML_NAMESPACE_RESOLVER
			tree: detachable XML_CALLBACKS_TREE
		do
			create {XML_LITE_CUSTOM_PARSER} parser.make

			get_parser_mode

			inspect
				parser_mode
			when debug_mode then
				parser.set_callbacks (create {XML_CALLBACKS_DEBUG})
			when tree_mode then
				create tree.make_null
				tree.set_source_parser (parser)
				create resolver.make_next (tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)
			when xml_tree_mode, xml_tree_vis_mode then
				create xml_tree.make_null
				xml_tree.set_source_parser (parser)
				create resolver.make_next (xml_tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)
			when null_mode then
			else
			end

--			parser.set_entity_mapping (html_entity_mapping)

			if attached filename as fn then
				test (fn)
			end
		end

	xml_tree: detachable XML_CALLBACKS_TREE
		note option: stable attribute end

	parser: XML_PARSER

	last_error_position: detachable XML_POSITION

	last_error_message: detachable STRING

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
				print ("[Error occurred] ")
				if attached last_error_message as msg then
					print (msg)
				end
				print (" : ")
				print (pos)
				print ("%N")
			end
		end

	test_file (fn: STRING)
		local
			f: RAW_FILE
		do
			last_error_position := Void

			print ("Parsing " + fn + "%N")
			create f.make (fn)
			f.open_read
			print ("Start%N")
			start_chrono
--			parser.set_error_ignored (True)
			parser.parse_from_file (f)
			stop_chrono
			print ("End%N")
			if parser.error_occurred then
				last_error_position := parser.error_position
				last_error_message := parser.error_message
			end
			f.close
		end

	test_file_content (fn: STRING)
		local
			s: STRING
		do
			last_error_position := Void

			s := file_content (fn)

			print ("Parsing " + fn + " as string%N")
			print ("Start%N")
			start_chrono
--			parser.set_error_ignored (True)
			parser.parse_from_string (s)
			stop_chrono
			print ("End%N")
			if parser.error_occurred then
				last_error_position := parser.error_position
				last_error_message := parser.error_message
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
