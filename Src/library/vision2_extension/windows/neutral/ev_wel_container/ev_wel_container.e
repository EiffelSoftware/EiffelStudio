indexing
	description: "Objects that allow positioning of WEL_WINDOW in a Vision2 system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_CONTAINER

inherit
	EV_CELL
		rename
			wipe_out as cell_wipe_out,
			replace as cell_replace,
			put as cell_put,
			has as cell_has,
			prune as cell_prune,
			item as cell_item,
			extend as cell_extend,
			linear_representation as cell_linear_representation
		export {NONE}
			cell_wipe_out,
			cell_replace,
			cell_put, cell_has,
			cell_prune,
			cell_item,
			cell_extend,
			has_recursive,
			cell_linear_representation,
			merge_radio_button_groups,
			propagate_background_color,
			propagate_foreground_color,
			fill,
			is_inserted,
			prune_all
		redefine
			implementation,
			create_implementation,
			full
		end
	
feature -- Access

	implementation_window: WEL_WINDOW is
			-- Underlying WEL_WINDOW which `Current' is
			-- composed of.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.implementation_window
		end
		
	item: WEL_WINDOW is
			-- `Result' is WEL_WINDOW contained in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item
		end
		
	item_minimum_height: INTEGER is
			-- Minimum height of `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item_minimum_height
		end
		
	item_minimum_width: INTEGER is
			-- Minimum width of `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item_minimum_width
		end
	
	full: BOOLEAN is
			-- Is there no element?
		do
			Result := item /= Void
		end
		
	has (v: WEL_WINDOW): BOOLEAN is
			-- Is `v' contained in `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := (v /= Void and then item = v)
		end
		
	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			if implementation.item /= Void then
				l.extend (implementation.item)
			end
			Result := l
		end

feature -- Status setting
		
	set_item_minimum_height (a_height: INTEGER) is
			-- Set minimum height of `item' to `a_height.
		require
			not_destroyed: not is_destroyed
			window_not_void: item /= Void
			height_non_negative: a_height >= 0
		do
			implementation.set_item_minimum_height (a_height)
		ensure
			height_set: item_minimum_height = a_height
		end
		
	set_item_minimum_width (a_width: INTEGER) is
			-- Set minimum height of `item' to `a_height.
		require
			not_destroyed: not is_destroyed
			window_not_void: item /= Void
			height_non_negative: a_width >= 0
		do
			implementation.set_item_minimum_width (a_width)
		ensure
			width_set: item_minimum_width = a_width
		end
		
	set_item_minimum_size (a_width, a_height: INTEGER) is
			-- Set minimum size of `item' to `a_width' and `a_height.
		require
			not_destroyed: not is_destroyed
			window_not_void: item /= Void
			values_non_negative: a_height >= 0
		do
			implementation.set_item_minimum_size (a_width, a_height)
		ensure
			dimensions_set: item_minimum_width = a_width and
				item_minimum_height = a_height
		end
		
	wipe_out is
			-- Remove `child_item'.
		require
			not_destroyed: not is_destroyed
			prunable: prunable
		do
			implementation.replace (Void)
		end
		
	put, replace  (a_window: WEL_WINDOW) is
			-- Replace `child_item' with `a_window'.
		require
			not_destroyed: not is_destroyed
			writeable: writable
			a_window_not_void: a_window /= Void
		do
			implementation.replace (a_window)
		end
		
	extend (an_item: like item) is
			-- Ensure that structure includes `an_item'.
		do	
			replace (an_item)
		end
		
	prune (v: WEL_WINDOW) is
			-- Remove `v' if contained.
		require
			not_destroyed: not is_destroyed
		do
			if item = v then
				wipe_out
			end
		ensure
			v_not_contained: not has (v)
		end
		
feature -- Event handling

	wel_message_actions: EV_WEL_MESSAGE_ACTION_SEQUENCE is
			-- Actions to be performed when a message is received by `implementation_window'.
		do
			Result := implementation.wel_message_actions
		ensure
			not_void: Result /= Void
		end
	
feature {EV_ANY_I} -- Implementation

	implementation: EV_WEL_CONTAINER_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of `Current'.
		do
			create {EV_WEL_CONTAINER_IMP} implementation.make (Current) 
		end
		
end -- class WEL_WINDOW_CELL
