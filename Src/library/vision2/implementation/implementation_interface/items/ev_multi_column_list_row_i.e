indexing
	description:
		"EiffelVision multi-column list row, implementation interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_ROW_I

feature -- Initialization

	make (par: EV_MULTI_COLUMN_LIST) is
		-- Create an empty row.
		require
			parent_not_void: par /= Void
		deferred
		end

feature -- Access

	parent: EV_MULTI_COLUMN_LIST is
			-- List that container this row
		deferred
		end

	columns: INTEGER is
			-- Number of columns in the row
		require
--			exists: not destroyed
		deferred
		end

	interface: EV_MULTI_COLUMN_LIST_ROW
			-- Interface of current implementation.

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		require
--			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
--			exists: not destroyed
		deferred
		end

	toggle is
			-- Change the state of selection of the item.
		require
--			exists: not destroyed
		do
			set_selected (not is_selected)
		end

feature -- Element Change

	set_cell_text (column: INTEGER; a_text: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		require
--			exists: not destroyed
			column_exists: column >= 1 and column <= columns
			text_not_void: a_text /= Void
		deferred
		end

	set_text (a_text: ARRAY[STRING]) is
		require
--			exists: not destroyed
			text_not_void: a_text /= Void
			text_length_ok: a_text.count <= columns
		local
			i: INTEGER
			list_i: INTEGER
		do
			from
				i := a_text.lower
				list_i := 1
			until
				i = a_text.upper + 1
			loop
				set_cell_text (list_i, a_text @ i)
				i := i + 1
				list_i := list_i + 1
			end
		end

	set_interface (list: EV_MULTI_COLUMN_LIST_ROW) is
			-- Make `list' the new interface.
		require
			list_not_void: list /= Void
		do
			interface := list
		end

invariant
--	parent_not_void: parent /= Void
--	parent_exists: not parent.destroyed

end -- class EV_MULTI_COLUMN_LIST_ROW_I

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
