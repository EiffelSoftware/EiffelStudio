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
		
	EV_INVISIBLE_CONTAINER_IMP
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
		end	
	
feature -- Status setting
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		do
			gtk_notebook_set_tab_pos (widget, pos)
		end
	
	
feature -- Element change
	
	append_page (c: EV_WIDGET_IMP; label: STRING) is
		-- New page for notebook containing child 'c' with tab 
		-- label 'label
		local
			a: ANY
			p: POINTER
		do
			a ?= label.to_c
			p := gtk_label_new ($a)
			gtk_notebook_append_page (widget, 
						  c.widget, 
						  p)
		end	

feature {EV_CONTAINER} -- Element change
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into container
		do
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
