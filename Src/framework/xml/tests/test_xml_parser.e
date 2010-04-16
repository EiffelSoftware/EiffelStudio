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
			xml_tree: detachable XML_CALLBACKS_TREE
			parser: XML_PARSER
			vis: detachable XML_NODE_VISITOR_PRINT
		do
			create {XML_CUSTOM_PARSER} parser.make

			get_parser_mode

			inspect
				parser_mode
			when debug_mode then
				parser.set_callbacks (create {XML_CALLBACKS_DEBUG})
			when tree_mode then
				create tree.make
				tree.set_source_parser (parser)
				create resolver.set_next (tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)
			when xml_tree_mode, xml_tree_vis_mode then
				create xml_tree.make
				xml_tree.set_source_parser (parser)
				create resolver.set_next (xml_tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)
			when null_mode then
			else
			end

--			parser.set_entity_mapping (html_entity_mapping)
			if attached filename as fn then
				if file_as_string_mode then
					test_file_content (fn, parser)
				else
					test_file (fn, parser)
				end
			end

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

			report_chrono

		end

	last_error_position: detachable XML_POSITION

	test_file (fn: STRING; a_parser: XML_PARSER)
		local
			f: RAW_FILE
		do
			last_error_position := Void

			print ("Parsing " + fn + "%N")
			create f.make (fn)
			f.open_read
			print ("Start%N")
			start_chrono
--			a_parser.set_error_ignored (True)
			a_parser.parse_from_file (f)
			stop_chrono
			print ("End%N")
			if a_parser.error_occurred then
				last_error_position := a_parser.error_position
			end
			f.close
		end

	test_file_content (fn: STRING; a_parser: XML_PARSER)
		local
			s: STRING
		do
			last_error_position := Void

			s := file_content (fn)

			print ("Parsing " + fn + " as string%N")
			print ("Start%N")
			start_chrono
--			a_parser.set_error_ignored (True)
			a_parser.parse_from_string (s)
			stop_chrono
			print ("End%N")
			if a_parser.error_occurred then
				last_error_position := a_parser.error_position
			end
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
