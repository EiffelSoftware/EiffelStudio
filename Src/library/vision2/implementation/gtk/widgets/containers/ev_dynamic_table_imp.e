indexing

	description:
		"EiffelVision dynamic table, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_DYNAMIC_TABLE_IMP

inherit
	EV_DYNAMIC_TABLE_I

	EV_TABLE_IMP
		undefine
			add_child
		redefine
			make
		end

creation
	make

feature {NONE} -- Implementation

	make (par: EV_CONTAINER) is
			-- Create an empty dynamic table.
		do
			{EV_TABLE_IMP} Precursor (par)
			finite_dimension := 1
		end

end -- class EV_DYNAMIC_TABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
