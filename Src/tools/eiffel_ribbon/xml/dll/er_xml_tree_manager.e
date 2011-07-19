note
	description: "Summary description for {ER_XML_TREE_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_TREE_MANAGER

feature -- Command

	load_tree (a_index: INTEGER)
			-- Load from Microsoft XML ribbon markup tree
		local
			l_callback: ER_XML_CALLBACKS
			l_factory: XML_LITE_PARSER_FACTORY
			l_parser: XML_LITE_PARSER
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			if attached l_constants.xml_full_file_name (a_index) as l_file_name then
				create l_factory
				l_parser := l_factory.new_parser

				create l_callback.make
				l_parser.set_callbacks (l_callback)
				l_parser.parse_from_filename (l_file_name)

				xml_root := l_callback.xml_root
				check set: xml_root /= Void end
			else
				check should_not_happend: False end
			end
		end

	xml_root: detachable ER_XML_TREE_ELEMENT
			--
end
