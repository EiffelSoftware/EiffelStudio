indexing
	description: "Converts a table of contents file to a corresponding tree widget."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WIDGET_FORMATTER

inherit
	TABLE_OF_CONTENTS_FORMATTER
		rename
			make as make_formatter
		redefine
			process_element
		end
	
create
	make

feature -- Creation

	make is
			-- Create
		do
			create toc_widget.make
			element_stack.wipe_out
			make_formatter
		end		

feature -- Access

	process_element (e: XM_ELEMENT) is
			-- Process`e'			
		do			
			add_node_item (e)
			Precursor (e)
			if not e.is_empty and then not Element_stack.is_empty then
				Element_stack.remove
			end
		end

	toc_widget: TABLE_OF_CONTENTS_WIDGET
			-- Tree widget

feature {NONE} -- Status setting

	add_node_item (e: XM_ELEMENT) is
			-- Add new node item based on `e'
		local
			l_title, l_url: STRING
			l_id: INTEGER
			l_toc_node: TABLE_OF_CONTENTS_WIDGET_NODE
			l_is_parent: BOOLEAN
		do	
					-- Extract attribute data
			if not e.attributes.is_empty then
				l_title := e.attribute_by_name (Title_string).value
				if e.has_attribute_by_name (Url_string) then
					l_url := e.attribute_by_name (Url_string).value
				end				
				l_id := e.attribute_by_name (Id_string).value.to_integer
				l_is_parent := e.name.is_equal (Folder_string)
				
				create l_toc_node.make (l_title, l_url, l_id, l_is_parent)
			
						-- Create node widget
				if Element_stack.is_empty then
					toc_widget.extend (l_toc_node)
				else
					current_node_item.extend (l_toc_node)
				end
				
				if not e.is_empty then						
					element_stack.extend (l_toc_node)
				end
			end		
		end		

feature {NONE} -- Implementation

	current_node_item: EV_TREE_ITEM is
			-- Current node item for inserting new values
		do
			Result := element_stack.item
		end

	element_stack: ARRAYED_STACK [EV_TREE_ITEM] is
			-- Element stack
		once
			create Result.make (0)
		end

end -- class TABLE_OF_CONTENTS_WIDGET_FORMATTER
