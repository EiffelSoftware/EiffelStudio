indexing
	description: "Tree Widget representing a table of contents."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WIDGET

inherit	
	EV_TREE
		rename
			initialize as initialize_tree
		end
	
create
	make
	
feature -- Initialization

	make (a_toc: TABLE_OF_CONTENTS) is
			-- Create
		require
			toc_not_void: a_toc /= Void
		do
			default_create
			set_pick_and_drop_mode
			toc := a_toc
			initialize
		ensure
			has_toc: toc /= Void
		end

	initialize is
			-- Initialize
		local
			l_node: TABLE_OF_CONTENTS_NODE
			l_widget_node: TABLE_OF_CONTENTS_WIDGET_NODE
		do
			if toc.has_child then
				from
					toc.children.start
				until
					toc.children.after
				loop
					l_node := toc.children.item					
					create l_widget_node.make_from_node (l_node)
					extend (l_widget_node)
					toc.children.forth
				end
			end			
		end		

feature -- Query

	modified: BOOLEAN
			-- Since loading have nodes been modified in a any way?

feature -- Access

	toc: TABLE_OF_CONTENTS
			-- Actual toc
		
feature -- Status Setting

	set_modified (a_flag: BOOLEAN) is
			-- Set `modified' to `a_flag'
		do
			modified := a_flag
		end

feature -- Element Change

	add_node (a_node: TABLE_OF_CONTENTS_WIDGET_NODE) is
			-- Add new heading node
		require
			node_not_void: a_node /= Void
		local
			l_node: EV_TREE_NODE_LIST
			l_toc_node: TABLE_OF_CONTENTS_WIDGET_NODE
		do
			l_node ?= selected_item
			if l_node /= Void then
				if l_node.is_empty then
						-- Selected item is not a heading so go for parent
					l_node ?= l_node.parent					
					if l_node = Void then
							-- Parent no good so take actual list
						l_node := Current
					end
				end
			else
				l_node := Current
			end
			
			check
				target_not_void: l_node /= Void
			end
			
			l_node.extend (a_node)
			l_toc_node ?= l_node
			l_toc_node.node.add_node (a_node.node)
			a_node.enable_select
			set_modified (True)
		end		

	remove_node is
			-- Removed selected node
		require
			has_selected_item: selected_item /= Void
		local
			l_node: TABLE_OF_CONTENTS_WIDGET_NODE
		do
			l_node ?= selected_item
			if l_node /= Void then
				l_node.parent.prune (l_node)
				l_node.node.parent.delete_node (l_node.node.id)
				set_modified (True)
			end						
		end		

end -- class TABLE_OF_CONTENTS_WIDGET
