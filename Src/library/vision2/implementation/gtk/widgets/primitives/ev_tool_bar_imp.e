indexing
	description: "EiffelVision2 toolbar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I

	EV_PRIMITIVE_IMP
		undefine
			set_default_options
		end

	EV_ITEM_HOLDER_IMP

creation
	make,
	make_with_size

feature {NONE} -- Implementation

	make is
			-- Create the tool-bar.
		do
			widget := c_gtk_toolbar_new_horizontal
			gtk_object_ref (widget)
			
			-- Create the child list
			create ev_children.make (0)
		end

	make_with_size (w, h: INTEGER) is
			-- Create the tool-bar with `par' as parent.
		do
			check
				To_be_implemented: False
			end
		end


feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
			-- clear_ev_children
			-- clear contained gtk objects
			check
				To_be_implemented: False
			end
		end

feature -- Implementation

	add_item (item_imp: EV_TOOL_BAR_BUTTON_IMP) is
			-- Add `item' to the list
		local
			text, privtxt: ANY
			tsttxt: STRING
		do
			ev_children.extend (item_imp)
			create tsttxt.make (0)
			tsttxt := "IK TEST"
			text := tsttxt.to_c
			privtxt := tsttxt.to_c
			
			gtk_toolbar_append_widget (widget, item_imp.widget, $text, $privtxt)
		end

	gtk_toolbar_append_widget (tb, but,txt, privtxt: POINTER) is
		external
			"C (GtkTooltips *, GtkButton*, const char *, const char *) | <gtk/gtk.h>"
		end

	insert_item (item_imp: EV_TOOL_BAR_BUTTON_IMP) is
			-- insert `item_imp' at position
		do
			Check
				To_be_implemented: False
			end
		end

	remove_item (item_imp: EV_TOOL_BAR_BUTTON_IMP) is
			-- remove `item_imp' from toolbar
		do
			ev_children.prune_all (item_imp)
			-- remove from gtk toolbar
		end


feature -- Implementation
 
 	ev_children: ARRAYED_LIST [EV_TOOL_BAR_BUTTON_IMP]
 			-- List of the children.

end -- class EV_TOOL_BAR_IMP

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
