indexing
	description: "Tuple notion of argument."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TUPLE_ARGUMENT

inherit
	EV_ARGUMENT

creation
	make

feature {NONE} -- Initialization

	make (tpl: TUPLE) is
			-- Create the argument corresponding to `tpl'.
		do
			tuple := tpl
		end

feature -- Access

	tuple: TUPLE
			-- Tuple that keep the arguments.

	item (i: INTEGER): ANY is
			-- Return the `i'-th data of the argument.
		do
			Result := tuple.item (i)
		end

	first: ANY is
			-- Return the first data of the argument.
		do
			Result := tuple.item (1)
		end

	last: ANY is
			-- Return the last data of the argument.
		do
			Result := tuple.item (count)
		end

feature -- Status report

	count: INTEGER is
			-- Number of datas in the argument.
		do
			Result := tuple.count
		end

feature -- Element change

	put (an_item: ANY; i: INTEGER) is
			-- Put `an_item' at the `i'-th position of the
			-- argument.
		do
			tuple.put (an_item, i)
		end

end -- class EV_TUPLE_ARGUMENT

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
