indexing
	description: "Converts XML file to table of contents file."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_TABLE_OF_CONTENTS_CONVERTER

inherit
	XML_CONVERTER
		rename
			make as make_formatter
		redefine
			process_element
		end
		
	TABLE_OF_CONTENTS_CONSTANTS

create
	make

feature -- Creation

	make is
			-- Create
		do
			create toc_file.make
			toc_file.initialize
			create parent_stack.make (10)
			parent_stack.compare_objects
			make_formatter
		end		

feature -- Access

	process_element (e: XM_ELEMENT) is
			-- Process `e'
		local
			l_node, l_parent: XML_TABLE_OF_CONTENTS_NODE
			l_id: INTEGER
			l_url, l_title: STRING
			l_is_parent: BOOLEAN
		do			
			if e.is_root_node then
				create l_node.make_root (e.name, Void)
				toc_file.set_root (l_node)
				parent_stack.extend (l_node)
			else
				l_id := e.attribute_by_name (Id_string).value.to_integer
				if e.has_attribute_by_name (Url_string) then
					l_url := e.attribute_by_name (Url_string).value
				end				
				l_title := e.attribute_by_name (Title_string).value
				l_is_parent := e.name.is_equal (Folder_string)
				l_parent := parent_stack.item
				create l_node.make (l_id, l_parent, l_url, l_title, l_is_parent)
				l_parent.put_last (l_node)
				if not e.elements.is_empty then
						-- This is parent node so add it to stack for children to access
					parent_stack.extend (l_node)
				end				
				toc_file.add_node (l_node)
			end
			Precursor (e)
			if parent_stack.has (l_node) then
				parent_stack.remove
			end
		end

	toc_file: XML_TABLE_OF_CONTENTS
			-- Tree widget
			
	parent_stack: ARRAYED_STACK [XML_TABLE_OF_CONTENTS_NODE]
			-- Parent stack

end -- class XML_TABLE_OF_CONTENTS_CONVERTER
