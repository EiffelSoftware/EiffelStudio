indexing
	description: "Objects that demonstrate EV_CELL used for padding%
		%in an EV_VERTICAL_BOX."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CELL_AS_PADDING_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization 

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
		do
			create vertical_box
			vertical_box.set_minimum_size (300, 300)
				-- By inserting two EV_CELL into the box, we force the
				-- button to be centered in the box, as the minimum sizes
				-- of the cells are identical.
			vertical_box.extend (create {EV_CELL})
			vertical_box.extend (create {EV_BUTTON}.make_with_text ("Centered in box"))
			vertical_box.disable_item_expand (vertical_box @ 2)
			vertical_box.extend (create {EV_CELL})
			widget := vertical_box
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CELL_AS_PADDING_TEST
