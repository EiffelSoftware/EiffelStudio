indexing
	description: 
		"EiffelVision notebook, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_NOTEBOOK_I
	
inherit
	EV_CONTAINER_I
		redefine
			add_child_ok
		end
	
feature -- Constants
	
	Pos_left, Pos_right, Pos_top, Pos_bottom: INTEGER is unique
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
                        -- Create a fixed widget with, `par' as
                        -- parent
		deferred
		end		

feature -- Status report

	count: INTEGER is
			-- Number of pages in the notebook
		deferred
		end
	
feature -- Status setting
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		require
			exists: not destroyed		
			correct_pos: pos = Pos_left or pos = Pos_right or pos = Pos_top or pos = Pos_bottom
		deferred
		end
	
feature -- Element change

	set_page_title (index: INTEGER; str: STRING) is
			-- Set the label of the `index' page of the notebook.
			-- The first page is the page number 1.
		deferred
		end

	append_page (c: EV_WIDGET_I; label: STRING) is
		-- New page for notebook containing child 'c' with tab 
		-- label 'label
		require
			exists: not destroyed		
		deferred
		end

feature {NONE} -- Implementation

		add_child_ok: BOOLEAN is
   			-- Used in the precondition of
   			-- 'add_child'. True, if it is ok to add a
   			-- child to container. Normal container have
   			-- only one child, but this feature can be
   			-- redefined in decendants.
   		do
 			Result := True
 		end

end -- class EV_NOTEBOOK_I

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
