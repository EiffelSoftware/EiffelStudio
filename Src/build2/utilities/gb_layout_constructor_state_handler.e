indexing
	description: "[
			Objects that allow you to store and retrieve the exanded state of all items in the
			GB_LAYOUT_CONSTRUCTOR.
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
	
inherit
	GB_SHARED_TOOLS

feature -- Access

	store_layout_constructor is
			-- Store representation of `layout_constructor' in `state_tree'.
		local
			tree_item: GB_BOOLEAN_TREE_ITEM
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			child_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			create state_tree
			create tree_item
			layout_constructor_item ?= Layout_constructor.first
			check
				not_void: layout_constructor_item /= Void
			end
			store_item (tree_item, layout_constructor_item)
			state_tree.set_root_node (tree_item)
		end
		
	restore_layout_constructor is
			-- Restore representation of `layout_constructor' from `state_tree'.
		local
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			layout_constructor_item ?= Layout_constructor.first
			reset_item (state_tree.root_node, layout_constructor_item)
		end
		
	reset_item (tree_item: GB_BOOLEAN_TREE_ITEM; layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Reset state of `layout_item' from `tree_item'.
		local
			current_tree_item: GB_BOOLEAN_TREE_ITEM
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			from
				tree_item.start
				layout_item.start
			until
				tree_item.off
			loop
				current_tree_item := tree_item.item
				layout_constructor_item ?= layout_item.item
				check
					not_void: layout_constructor_item /= Void
				end
				reset_item (current_tree_item, layout_constructor_item)
				if tree_item.state then
					layout_item.expand
				else
					layout_item.collapse
				end
				layout_item.forth
				tree_item.forth
			end
		end
		
		
	store_item (tree_item: GB_BOOLEAN_TREE_ITEM; layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Store representation of `layout_item' into `tree_item'.
		local
			new_tree_item: GB_BOOLEAN_TREE_ITEM
			temp_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			if layout_item.is_expanded then
				tree_item.enable_state
			else
				tree_item.disable_state
			end
			from
				layout_item.start
			until
				layout_item.off
			loop
				create new_tree_item
				tree_item.extend (new_tree_item)
				temp_item ?= layout_item.item
				check
					temp_item_not_void: temp_item /= Void
				end
				store_item (new_tree_item, temp_item)
				layout_item.forth
			end
		end
		
	state_tree: GB_BOOLEAN_TREE
		-- An internal representation of layout_constructor.
		-- Void unless `store_layout_constructor' called.
		
end -- class GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
