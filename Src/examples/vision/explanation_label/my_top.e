indexing
	description: "Second window of the example";
	date: "$Date$";
	revision: "$Revision$"

class MY_TOP
		
inherit
	TOP_SHELL
		rename
			make as top_make,
			realize as top_realize
		end
		
	TOP_SHELL
		redefine
			make,
			realize
		select
			make,
			realize
		end

	TOOLTIP_INITIALIZER
		--widget containing focusable widgets
		
creation
	make

feature -- Initialization

	make (a_name: STRING; a_s: SCREEN) is
		do
				--initiliaze as top shell
			top_make (a_name, a_s)
				-- initialize as tooltip initializer
			tooltip_initialize (Current)

			!!row_col.make ("Row_column", Current)
			row_col.set_row_layout

			!!p1.make ("P1", row_col)
			p1.set_focus_string ("explanation text for P1")
		
			!!p2.make ("P2", row_col)
			p2.set_focus_string ("explanation text for P2")

			!!p3.make ("P3", row_col)
			p3.set_focus_string ("explanation text for P3")

		end		
	
	realize is
		do
			if not(realized) then
					--realize as top shell
				top_realize
					--realize as tooltip initializer
				tooltip_realize
			end
		end

feature -- Properties

	row_col: ROW_COLUMN
	
	p1, p2, p3: FOCUSABLE_B
		-- some focusables
		
end -- class MY_TOP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

