note
	description: "Summary description for {ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER_AM}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER_AM

inherit
	ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create shared_singleton
			create vision_xml_translator.make
		end

feature -- Command

	save_tree
			-- <Precursor>
		local
			l_printer: XML_NODE_PRINTER
			l_output_stream: ER_XML_OUTPUT_STREAM
			l_document: XML_DOCUMENT
		do
			vision_xml_translator.save_xml_nodes_for_all_layout_constructors
			l_document := vision_xml_translator.xml_document

			create l_printer.make

			create l_output_stream.make (1)
			l_printer.set_output (l_output_stream)

			l_document.process (l_printer)

			l_output_stream.close
		end

	load_tree (a_ribbon_window_count: INTEGER)
			-- <Precursor>
		local
			l_manager: ER_XML_TREE_MANAGER
			l_factory: ER_VISITOR_FACTORY
			l_visitors: ARRAYED_LIST [ER_VISITOR]
		do
			l_manager := shared_singleton.xml_tree_manager.item
			l_manager.load_tree (0)

			if attached l_manager.xml_root as l_root then
				create l_factory
				l_visitors := l_factory.visitors
				from
					l_visitors.start
				until
					l_visitors.after
				loop
					l_root.accept (l_visitors.item, 1)
					l_visitors.forth
				end
			else
				check False end
			end
		end

feature {NONE}	-- Implementation

	vision_xml_translator: ER_VISION_XML_TREE_TRANSLATOR_AM
			--	
end
