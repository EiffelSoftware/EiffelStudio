indexing
	description: "Converts a table of contents structure to a corresponding tree widget."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WIDGET_FORMATTER
	
create
	make

feature -- Creation

	make is
			-- Create
		do
			create toc_widget.make
		end		

feature -- Access

	process_toc (a_toc: TABLE_OF_CONTENTS) is
			-- Process `a_toc'			
		do			
			process_toc_node (a_toc, toc_widget)
		end
		
	process_toc_node (a_node: TABLE_OF_CONTENTS_NODE; a_node_list: EV_TREE_NODE_LIST) is
			-- Process `a_node', creating widget nodes into `a_node_list'
		require
			a_node /= Void
		local
			l_item: TABLE_OF_CONTENTS_NODE
			l_children: ARRAYED_LIST [like a_node]			
			l_widget_item: TABLE_OF_CONTENTS_WIDGET_NODE
			l_is_parent: BOOLEAN
		do
			if a_node.has_child then
				l_children := a_node.children
				from
					l_children.start
				until
					l_children.after
				loop
					l_item := l_children.item
					l_is_parent := l_item.url_is_directory or l_item.has_child
					create l_widget_item.make (l_item.title, l_item.url, l_item.id, l_is_parent)
					a_node_list.extend (l_widget_item)
					if l_item.has_child then
						process_toc_node (l_item, l_widget_item)
					end
					l_children.forth
				end
			end			
		end		

	toc_widget: TABLE_OF_CONTENTS_WIDGET
			-- Tree widget

end -- class TABLE_OF_CONTENTS_WIDGET_FORMATTER
