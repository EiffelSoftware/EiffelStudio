indexing	
	description: 
		"EiffelVision combo-box item. Implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 

	EV_COMBO_BOX_ITEM_I

inherit

	EV_ITEM_I
	
feature {NONE} -- Initialization

	make (par: EV_COMBO_BOX) is
			-- Create a combo-box item with no label and add it
			-- to `par'.
		require
			parent_not_void: par /= Void
		deferred
		end
	
	make_with_text (par: EV_COMBO_BOX; txt: STRING) is
			-- Create a combo-box item with `txt' for  label and
			-- add it in the `par'.
		require
			parent_not_void: par /= Void
			txt_not_void: txt /= Void
		deferred
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
		deferred
		end

	toggle is
			-- Change the state of selection of the item.
		require
			exists: not destroyed
		deferred
		end

end -- class EV_COMBO_BOX_ITEM_I

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
