indexing	
	description: 
		"EiffelVision item. Top class of menu_item, list_item%
		% and tree_item. This item isn't a widget, because most%
		% of the features of the widgets are inapplicable  here."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_SIMPLE_ITEM

inherit
	EV_ITEM
		redefine
			implementation
		end

	EV_PIXMAPABLE
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make_with_text (par: like parent; txt: STRING) is
			-- Create a row with text in it.
		require
			valid_text: txt /= Void
		deferred
		ensure
			text_set: text.is_equal (txt)
		end

	make_with_all (par: like parent; txt: STRING; pos: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		require
			valid_parent: par /= Void
			valid_text: txt /= Void
			valid_index: pos > 0 and pos <= par.count + 1
		do
			-- create {?} implementation.make_with_text (txt)
			check
				valid_implementation: implementation /= Void
			end
			implementation.set_interface (Current)
			set_parent_with_index (par, pos)
		ensure
			parent_set: parent.is_equal (par)
			text_set: text.is_equal (txt)
			index_set: index = pos
		end

feature -- Access

	text: STRING is
			-- Current label of the item
		require
			exists: not destroyed
		do
			Result := implementation.text
		ensure
			valid_result: Result /= Void
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		require
			exists: not destroyed
			valid_text: txt /= Void
		do
			implementation.set_text (txt)
		ensure
			text_set: text.is_equal (txt)
		end

feature -- Implementation

	implementation: EV_SIMPLE_ITEM_I
			-- Platform dependent access.

end -- class EV_ITEM

--!----------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
