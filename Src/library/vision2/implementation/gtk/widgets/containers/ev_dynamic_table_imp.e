--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
		redefine
			make,
			add_child
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty dynamic table.
		do
			{EV_TABLE_IMP} Precursor
			finite_dimension := 1
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		local
			wid: EV_WIDGET
		do
			{EV_TABLE_IMP} Precursor (child_imp)
			wid ?= child_imp.interface
			set_child_position (wid, row_index, column_index, row_index + 1, column_index + 1)
			if is_row_layout then
				if column_index + 1 >= finite_dimension then
					row_index := row_index + 1
					column_index := 0
				else
					column_index := column_index + 1
				end
			else
				if row_index + 1 >= finite_dimension then
					column_index := column_index + 1
					row_index := 0
				else
					row_index := row_index + 1
				end
			end			
		end

end -- class EV_DYNAMIC_TABLE_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.2  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
