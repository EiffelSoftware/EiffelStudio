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
	
feature -- Status report

	count: INTEGER is
			-- Number of pages in the notebook
		require
			exists: not destroyed
		deferred
		end

	current_page: INTEGER is
			-- Index of the page currently opened
		require
			exists: not destroyed
		deferred
		end

--	tab_position: STRING is
	tab_position: INTEGER is
			-- Position of the tabs
		require
			exists: not destroyed
		deferred
		ensure
			correct_pos: Result = Tab_left or Result = Tab_right 
						or Result = Tab_bottom or Result = Tab_top
		end

feature -- Status setting
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		require
			exists: not destroyed		
			correct_pos: pos = Tab_left or pos = Tab_right 
						or pos = Tab_bottom or pos = Tab_top
		deferred
		end

	set_current_page (index: INTEGER) is
			-- Make the `index'-th page the currently opened page.
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
		deferred
		end
	
feature -- Element change

	set_page_title (index: INTEGER; str: STRING) is
			-- Set the label of the `index' page of the notebook.
			-- The first page is the page number 1.
		require
			exists: not destroyed
			good_index: index <= count
		deferred
		end
	
	append_page (c: EV_WIDGET_I; label: STRING) is
			-- New page for notebook containing child 'c' with tab 
			-- label 'label
		require
			exists: not destroyed		
		deferred
		end

feature -- Miscellaneous - Constants
	
	Tab_left: INTEGER is 1
			-- Constant used to position tab on the left.

	Tab_right: INTEGER is 2
			-- Constant used to position tab on the right.

	Tab_top: INTEGER is 3
			-- Constant used to position tab at the top.

	Tab_bottom: INTEGER is 4
			-- Constant used to position tab at the bottom.

feature -- Event - command association
	
	add_switch_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- the a page is switch in the notebook.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

feature -- Event -- removing command association

	remove_switch_commands is
			-- Empty the list of commands to be executed
			-- when a page is switch in the notebook.
		require
			exists: not destroyed
		deferred
		end	

end -- class EV_NOTEBOOK_I

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
