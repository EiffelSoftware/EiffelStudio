indexing

	description: 
		"EiffelVision notebook. Notebook is a collection of pages that overlap each other. For each page there is a tab corresponding to the page."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class EV_NOTEBOOK

inherit

	EV_INVISIBLE_CONTAINER
		redefine
			implementation,
			make
		end
	
creation
	
	make
	
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a fixed widget with, `par' as
                        -- parent
		do
			!EV_NOTEBOOK_IMP!implementation.make (par)
			Precursor (par)
		end		
	
	
feature -- Status setting
	
	set_tab_left is
			-- set position of tabs to left
		require
			exists: not destroyed		
		do
			implementation.set_tab_position (implementation.Pos_left)
		end
	
	
feature -- Element change
	
	append_page (c: EV_WIDGET; label: STRING) is
		-- New page for notebook containing child 'c' with tab 
		-- label 'label
		require
			exists: not destroyed		
			child_of_notebook: c.parent = Current
		do
			implementation.append_page (c.implementation, label)
		end
	
feature {NONE} -- Implementation
	
	implementation: EV_NOTEBOOK_I
	
end -- class EV_NOTEBOOK

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
