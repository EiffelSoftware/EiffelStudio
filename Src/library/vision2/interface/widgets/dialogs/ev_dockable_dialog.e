indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DOCKABLE_DIALOG
	
inherit
	EV_DIALOG
		export
			{EV_DOCKABLE_SOURCE_I} close_request_actions
		end

feature -- Access

	original_parent: EV_DOCKABLE_TARGET
			-- Original parent of `item' before it was
			-- dragged out.
			
	original_parent_index: INTEGER
			-- Original index of `item' in parent before it was
			-- dragged out.
			
	expansion_was_disabled: BOOLEAN
		-- Was `item' originally disabled in `original_parent'? This
		-- may only be True if `original_parent' is an EV_BOX.

feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	set_original_parent (an_original_parent: EV_DOCKABLE_TARGET) is
			-- Assign `an_original_parent' to `original_parent'.
		do
			original_parent := an_original_parent
		end
		
	set_original_parent_index (an_index: INTEGER) is
			-- Assign `an_index' to `original_parent_index'.
		do
			original_parent_index := an_index
		end
		
	set_expansion_was_disabled is
			-- Assign `True' to `expansion_was_disabled'.
		do
			expansion_was_disabled := True
		end
		

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_DIALOG
