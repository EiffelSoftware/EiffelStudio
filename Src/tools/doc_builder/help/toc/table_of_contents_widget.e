indexing
	description: "Tree Widget representing a table of contents."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WIDGET

inherit	
	EV_TREE	
	
create
	make
	
feature -- Creation

	make is
			-- Create
		do
			default_create
			set_pick_and_drop_mode			
		end

feature -- Query

	modified: BOOLEAN
			-- Since loading have nodes been modified in a any way?

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
			a_node.enable_select
			set_modified (True)
		end		

end -- class TABLE_OF_CONTENTS_WIDGET
