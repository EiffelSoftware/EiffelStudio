indexing
	description: "Objects that represent a boolean tree item"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_BOOLEAN_TREE_ITEM

inherit
	ANY
		redefine
			default_create
		end
	
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize `nodes'
		do
			create nodes.make (3)
		end

feature -- Access

	nodes: ARRAYED_LIST [GB_BOOLEAN_TREE_ITEM]
	
	state: BOOLEAN
		-- BOOLEAN state represented by `Current'

feature -- Status setting

	enable_state is
			-- Ensure `state' = True.
		do
			state := True
		ensure
			state_enabled: state = True
		end
		
	disable_state is
			-- Ensure `state' = False.
		do
			state := False
		ensure
			state_disabled: state = False
		end

feature -- Cursor movement

	start is
			-- Move to start of `content'.
		do
			nodes.start
		ensure
			at_first: not nodes.is_empty implies nodes.isfirst
			after_when_empty: nodes.is_empty implies nodes.after
		end
		
	forth is
			-- Move to next item in `content'.
		require
			not_after: not nodes.after
		do
			nodes.forth
		ensure
			moved_forth: nodes.index = old nodes.index + 1
		end
		
	item: GB_BOOLEAN_TREE_ITEM is
			-- Item in `content'.
		do
			Result := nodes.item
		ensure
			Result_consistent: Result = nodes.item
		end
		
	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := nodes.off
		ensure
			Result_consistent: Result = nodes.off
		end
		

feature -- Element change

	extend (an_item: GB_BOOLEAN_TREE_ITEM) is
			-- Add `an_item' to `nodes'.
		require
			an_item_not_void: an_item /= Void
		do
			nodes.extend (an_item)
		ensure
			nodes_has_item_at_last_position: nodes.last = an_item
		end

invariant
	nodes_not_void: nodes /= Void

end -- class GB_BOOLEAN_TREE_ITEM
