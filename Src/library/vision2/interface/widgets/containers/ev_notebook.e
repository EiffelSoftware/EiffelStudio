indexing
	description: 
		"EiffelVision notebook. Notebook is a collection of pages%
		% that overlap each other. For each page there is a tab%
		% corresponding to the page."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_NOTEBOOK

inherit
	EV_CONTAINER
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
			!EV_NOTEBOOK_IMP!implementation.make
			widget_make (par)
		end		

feature -- Status report

	count: INTEGER is
			-- Number of pages in the notebook
		do
			Result := implementation.count
		end

	current_page: INTEGER is
			-- Index of the page currently opened
		do
			Result := implementation.current_page
		end

feature -- Status setting
	
	set_tab_top is
			-- Put the tabs at the top of the notebook.
			-- default.
		require
			exists: not destroyed		
		do
			implementation.set_tab_position (implementation.Pos_top)
		end

	set_tab_bottom is
			-- Put the tabs at the bottom of the notebook.
		require
			exists: not destroyed		
		do
			implementation.set_tab_position (implementation.Pos_bottom)
		end

	set_tab_left is
			-- Put the tabs at the left of the notebook.
		require
			exists: not destroyed		
		do
			implementation.set_tab_position (implementation.Pos_left)
		end

	set_tab_right is
			-- Put the tabs at the right of the notebook.
		require
			exists: not destroyed		
		do
			implementation.set_tab_position (implementation.Pos_right)
		end

	set_current_page (index: INTEGER) is
			-- Make the `index'-th page the currently opened page.
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
		do
			implementation.set_current_page (index)
		end

feature -- Element change

	set_page_title (index: INTEGER; str: STRING) is
			-- Set the label of the `index' page of the notebook.
			-- The first page is the page number 1.
		require
			exists: not destroyed
			good_index: index <= count
		do
			implementation.set_page_title (index, str)
		end
	
	append_page (c: EV_WIDGET; label: STRING) is
		-- New page for notebook containing child 'c' with tab 
		-- label 'label
		require
			exists: not destroyed		
			child_of_notebook: c.parent = Current
		do
			implementation.append_page (c.implementation, label)
		end

feature -- Event - command association
	
	add_switch_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- the a page is switch in the notebook.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_switch_command (cmd, arg)
		end	

feature -- Event -- removing command association

	remove_switch_commands is
			-- Empty the list of commands to be executed
			-- when a page is switch in the notebook.
		require
			exists: not destroyed
		do
			implementation.remove_switch_commands
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
