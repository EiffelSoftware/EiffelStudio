indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_WINDOW

inherit
	EV_MULTI_COLUMN_LIST
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo window in `par'.
		do
			make_with_text (par, <<"Part 1", "Part 2", "Part 3", "Part 4", "Part 5">>)
			set_multiple_selection
			set_columns_width (<<80, 80, 80, 80, 80>>)		
			set_right_alignment (2)
			set_center_alignment (3)
			set_left_alignment (4)

			!! row.make_with_text (Current, <<"Ceci","est","un","objet","row">>)
			row.set_selected (True)
			!! row.make (Current)
			row.set_text (<<"This","is","an","objet","row">>)
			!! row.make_with_text (Current, <<"This","is","an","objet","row">>)
			row.set_selected (True)
			!! row.make (Current)
			row.set_text (<<"This","is","an","objet","row">>)
		end

feature -- Access

	row: EV_MULTI_COLUMN_LIST_ROW
		-- Row

end -- class MULTI_COLUMN_LIST_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
