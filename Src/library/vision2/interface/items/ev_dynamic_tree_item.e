--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Dynamically expandable tree items"
	status: "See notice at end of file"
	author: "Mark Howard"
	date: "11/4/1999"
	revision: "$Revision$"

class
	EV_DYNAMIC_TREE_ITEM [G]

inherit
	EV_TREE_ITEM
		redefine
			data
		end
		
creation
	default_create

feature -- Initialization

	set_dynamic (a_expand: like expand_agent; a_data: G) is
			-- Initialize the item to call `a_expand' on expand.
		local
			t_item: EV_TREE_ITEM
		do
			expand_agent := a_expand
			if expand_agent /= Void then
				create t_item
				t_item.set_text ("to_be_expanded")
				extend (t_item)
				expand_actions.extend (~expand_node)
			end
			data := a_data
		end

feature -- Access

	data: G

feature {NONE} -- Implementation

	expand_agent: PROCEDURE [ANY, TUPLE [like Current]]
		-- Agent used to create create child items.

	expand_node is
		local
			a_counter: INTEGER
			temp_count: INTEGER
		do
			--| FIXME IEK Add wipe_out when bug is fixed.
			--wipe_out
			from
				start
			until
				count = 1 or off
			loop
				remove
			end
			expand_agent.call ([Current])
			start
			remove
		end

end -- class EV_DYNAMIC_TREE_ITEM

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
