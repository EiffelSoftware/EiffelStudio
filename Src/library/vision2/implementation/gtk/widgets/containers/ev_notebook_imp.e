indexing

	description: 
		"EiffelVision notebook, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_NOTEBOOK_IMP
	
inherit
	
	EV_NOTEBOOK_I
		
	EV_CONTAINER_IMP
		undefine
			add_child_ok
		redefine
			add_child
		end
	  
creation
	
	make

feature {NONE} -- Initialization
	
        make (par: EV_CONTAINER) is
                        -- Create a fixed widget. 
		do
			widget := gtk_notebook_new ()
			show
		end	

feature -- Status report

	count: INTEGER is
			-- Number of pages in the notebook
		do
		end

	current_page: INTEGER is
			-- Index of the page currently opened
		do
			check
				not_yet_implemented: False
			end
		end
	
feature -- Status setting
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		local
			gtk_pos: INTEGER
		do
			inspect pos
			when Pos_left then
				gtk_pos := 0
			when Pos_right then
				gtk_pos := 1
			when Pos_top then
				gtk_pos := 2
			when Pos_bottom then
				gtk_pos := 3
			end
			gtk_notebook_set_tab_pos (widget, gtk_pos)
		end
	
	
feature -- Element change

	set_page_title (index: INTEGER; str: STRING) is
			-- Set the label of the `index' page of the notebook.
			-- The first page is the page number 1.
		do
		end
	
	append_page (c: EV_WIDGET_IMP; label: STRING) is
		-- New page for notebook containing child 'c' with tab 
		-- label 'label
		local
			a: ANY
			p: POINTER
		do
			a ?= label.to_c
			p := gtk_label_new ($a)
			--c.show
			gtk_notebook_append_page (widget, 
						  c.widget, 
						  p)
		end	

feature -- Event - command association
	
	add_switch_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- the a page is switch in the notebook.
		do
			add_command ("switch_page", cmd, arg)
		end

feature -- Event -- removing command association

	remove_switch_commands is
			-- Empty the list of commands to be executed
			-- when a page is switch in the notebook.
		do
			check False end
		end	

feature {EV_CONTAINER} -- Element change
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into container
		do
			child := child_imp
			--gtk_container_add (widget, child_imp.widget)
		end

end

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
