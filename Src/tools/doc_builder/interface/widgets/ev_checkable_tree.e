indexing
	description: "Tree allowing nodes to be checked."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_TREE

inherit
	EV_TREE
		redefine
			initialize
		end
		
	APPLICATION_CONSTANTS
		rename
			put as app_put
		undefine
			default_create,
			is_equal,
			copy
		end
	
create
	default_create
	
feature {NONE} -- Initialization

	initialize is
			-- Initialize
		do
			Precursor
			state_recursive := True
			create checked_items.make (0)			
		end		
	
feature -- Access

	checked_items: ARRAYED_LIST [EV_CHECKABLE_TREE_ITEM]
			-- All items checked in `Current'.
		
	state_recursive: BOOLEAN
			-- Indicates if children are checked same as parent when parent is altered

feature -- Status setting

	check_item (tree_item: EV_CHECKABLE_TREE_ITEM) is
			-- Ensure check associated with `tree_item' is
			-- checked.
		do
			tree_item.set_checked
			if not checked_items.has (tree_item) then				
				checked_items.extend (tree_item)	
			end
		end

	uncheck_item (tree_item: EV_CHECKABLE_TREE_ITEM) is
			-- Ensure check associated with `tree_item' is
			-- unchecked.
		do
			tree_item.set_unchecked
			if checked_items.has (tree_item) then			
				checked_items.start
				checked_items.prune (tree_item)	
			end
		end
		
	set_state_recursive (a_flag: BOOLEAN) is
			-- Set if parent nodes should apply checked property to children, default True
		do
			state_recursive := a_flag	
		end		

feature -- Implementation

	unchecked_pixmap: EV_PIXMAP is
			-- Unchecked pixmap
		local
			l_filename: FILE_NAME
			l_pix: EV_PIXMAP
		once
			create Result.make_with_size (16, 16)
			Result.set_background_color ((create {EV_STOCK_COLORS}).white)
			Result.clear			
			create l_pix
			create l_filename.make_from_string (icon_resources_directory)
			l_filename.extend ("unchecked.png")
			l_pix.set_with_named_file (l_filename.string)
			Result.draw_sub_pixmap (2, 2, l_pix, create {EV_RECTANGLE}.make (0, 0, l_pix.width, l_pix.height))
		end
	
	checked_pixmap: EV_PIXMAP is
			-- Checked pixmap
		local
			l_filename: FILE_NAME
			
			l_pix: EV_PIXMAP
		once
			create Result.make_with_size (16, 16)
			Result.set_background_color ((create {EV_STOCK_COLORS}).white)
			Result.clear			
			create l_pix
			create l_filename.make_from_string (icon_resources_directory)
			l_filename.extend ("checked.png")
			l_pix.set_with_named_file (l_filename.string)
			Result.draw_sub_pixmap (2, 2, l_pix, create {EV_RECTANGLE}.make (0, 0, l_pix.width, l_pix.height))
		end

feature -- Implementation

	register_checkable_node (a_node: EV_CHECKABLE_TREE_ITEM) is
			-- Register `a_node' as checkable
		require
			node_not_void: a_node /= Void			
		do
			a_node.set_pixmap (unchecked_pixmap)
			a_node.pointer_button_press_actions.force_extend (agent toggle_item (a_node))			
		end		

	toggle_item (tree_item: EV_CHECKABLE_TREE_ITEM) is
			-- Toggle checked item property
		require
			pixmap_not_void: tree_item /= Void
		do
			if tree_item.is_checked then
				uncheck_item (tree_item)
			else
				check_item (tree_item)
			end	
		end	

	internal_checked_items (a_tree_node_list: EV_TREE_NODE_LIST): like checked_items is
			-- Checked items implementation
		require
			list_not_void: a_tree_node_list /= Void
		local
			original_position: INTEGER
			l_checkable: EV_CHECKABLE_TREE_ITEM
		do			
			original_position := index
			create Result.make (0)
			from
				a_tree_node_list.start
			until
				a_tree_node_list.off
			loop
				l_checkable ?= a_tree_node_list.item
				if l_checkable /= Void then				
					if l_checkable.is_checked then
						Result.extend (l_checkable)
					end
					if not l_checkable.is_empty then
						Result.append (internal_checked_items (l_checkable))
					end	
				end
				a_tree_node_list.forth
			end
			a_tree_node_list.go_i_th (original_position)
		end		
		
end -- class EV_CHECKABLE_TREE
