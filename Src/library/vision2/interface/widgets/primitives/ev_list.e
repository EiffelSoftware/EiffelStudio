indexing

	description: 
		"EiffelVision list. Contains a list of strings from %
		% which the user can select."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class EV_LIST

inherit

	EV_PRIMITIVE
		redefine
			implementation
		end

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a list widget with `par' as
			-- parent.
			-- By default, a list allow only one selection.
		do
			!EV_LIST_IMP!implementation.make (par)
			widget_make (par)
		end

feature -- Status report

	count: INTEGER is
			-- Number of lines
		require
			exists: not destroyed
		do
			Result := implementation.count
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
			exists: not destroyed
		do
			Result := implementation.selected
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
			exist: not destroyed
		do
			Result := implementation.is_multiple_selection
		end

feature -- Status setting

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
			exists: not destroyed
		do
			implementation.set_multiple_selection	
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
			exists: not destroyed
		do
			implementation.set_single_selection
		end
	
feature {EV_LIST_ITEM_IMP, EV_LIST_ITEM} -- Implementation
	
	implementation: EV_LIST_I	

end -- class EV_LIST

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
--|---------------------------------------------------------------
