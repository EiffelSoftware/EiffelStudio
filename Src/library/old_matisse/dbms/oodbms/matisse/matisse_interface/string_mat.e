indexing

    Product: EiffelStore
    Database: Matisse

class STRING_MAT inherit 

	STRING

creation -- Creation procedure

	make

feature -- Element change

	mat_get_select_name (index: INTEGER; no_descriptor: INTEGER) is
            -- Do nothing
		do
		ensure
			not_change_capacity: capacity = old capacity
			not_change_area: area = old area
		end -- mat_get_select_name

	mat_get_value (index: INTEGER; no_descriptor: INTEGER) is
 		-- Do nothing
		do
		ensure
			not_change_capacity: capacity = old capacity
			not_change_area: area = old area
		end -- mat_get_value

end -- class STRING_MAT

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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

