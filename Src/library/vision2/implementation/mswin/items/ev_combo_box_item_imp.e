indexing	
	description: 
		"EiffelVision combo-box item. Implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class 

	EV_COMBO_BOX_ITEM_IMP

inherit

	EV_COMBO_BOX_ITEM_I

	EV_ITEM_IMP
		export {EV_COMBO_BOX_IMP}
			id,
			set_id
		redefine
			parent_imp
		end

creation

	make, make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_COMBO_BOX) is
			-- Create a combo-box item with no label and add it
			-- to `par'.
		do
			parent_imp ?= par.implementation
			check
				parent_not_void: parent_imp /= Void
			end
			parent_imp.set_name ("")
		end
	
	make_with_text (par: EV_COMBO_BOX; txt: STRING) is
			-- Create a combo-box item with `txt' for  label and
			-- add it in the `par'.
		do
			parent_imp ?= par.implementation
			check
				parent_not_void: parent_imp /= Void
			end
			parent_imp.set_name (txt)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := parent_imp.wel_selected_item = id
		end

	text: STRING is
			-- Current label of the item
		do
			Result := parent_imp.i_th_text (id)
		end

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the list.
		do
			Result := not parent_imp.ev_children.has (Current)
		end

feature -- Status setting

	set_text (str: STRING) is
			-- Set `text' to `str'.
		do
			parent_imp.delete_string (id)
			parent_imp.insert_string_at (str, id)
		end

	destroy is
			-- Destroy the actual item.
		do
			parent_imp.remove_item (id)
			interface.remove_implementation
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			parent_imp.select_item (id)
		end

	toggle is
			-- Change the state of selection of the item.
		do
			set_selected (not is_selected)
		end

feature {NONE} -- Access for implementation
	
	parent_imp: EV_COMBO_BOX_IMP
		-- list that contains the current item.
	
end -- class EV_COMBO_BOX_ITEM_IMP

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
