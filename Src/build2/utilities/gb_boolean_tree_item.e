indexing
	description: "Objects that represent a boolean tree item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		-- All nodes of `Current'.
	
	state: BOOLEAN
		-- BOOLEAN state represented by `Current'
		
	selected: BOOLEAN
		-- An additional state representing selection.

feature -- Status setting

	enable_selected is
			-- Ensure `selected' is True
		do
			selected := True
		ensure
			state_selected: selected = True
		end
		
	disable_selected is
			-- Ensure `selected' is False
		do
			selected := False
		ensure
			state_selected: selected = False
		end

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_BOOLEAN_TREE_ITEM
