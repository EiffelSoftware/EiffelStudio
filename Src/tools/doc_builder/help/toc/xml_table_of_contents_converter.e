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
			create toc.make_empty
			create parent_stack.make (10)
			parent_stack.compare_objects
			parent_stack.extend (toc)
			make_formatter
		end		

feature -- Access

	process_element (e: XM_ELEMENT) is
			-- Process `e'
		local
			l_node, l_parent: TABLE_OF_CONTENTS_NODE
			l_id: INTEGER
			l_url, 
			l_title,
			l_icon: STRING
			l_is_parent: BOOLEAN
		do			
			if not e.is_root_node then
				l_parent ?= parent_stack.item
				if e.has_attribute_by_name (Id_string) then
					l_id := e.attribute_by_name (Id_string).value.to_integer
				end			
				if e.has_attribute_by_name (Url_string) then
					l_url := e.attribute_by_name (Url_string).value
				end				
				if e.has_attribute_by_name (Title_string) then
					l_title := e.attribute_by_name (Title_string).value
				end				
				create l_node.make (l_id, l_parent, l_url, l_title)
				if e.has_attribute_by_name (Icon_string) then
					l_icon := e.attribute_by_name (Icon_string).value
					l_node.set_icon (l_icon)
				end
				l_parent.add_node (l_node)
				if not e.elements.is_empty then
						-- This is parent node so add it to stack for children to access
					parent_stack.extend (l_node)
				end	
			end			
			Precursor (e)
			if parent_stack.has (l_node) then
				parent_stack.remove
			end
		end

	toc: TABLE_OF_CONTENTS
			-- Tree widget
			
	parent_stack: ARRAYED_STACK [TABLE_OF_CONTENTS_NODE]
			-- Parent stack

end -- class TABLE_OF_CONTENTS_CONVERTER
