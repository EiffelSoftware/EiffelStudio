indexing
	description: "Objects that demonstrate EV_CELL used for padding%
		%in an EV_VERTICAL_BOX."
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

end -- class CELL_AS_PADDING_TEST
