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
	

create
	make,
	make_with_size,
	make_with_height

feature {NONE} -- Implementation

	make is
			-- Create the tool-bar.
		do
			tool_bar_make
			button_width := -1
			button_height := -1
		end

	make_with_size (w, h: INTEGER) is
			-- Create the tool-bar with `par' as parent.
		do
			tool_bar_make
			-- Set the width and height
			button_width := w
			button_height := h
			gtk_toolbar_set_space_size (widget, 10)
		end

	make_with_height (h: INTEGER) is
			-- Create the tool-bar with all items set to height h
		do
			tool_bar_make
			button_width := -1
			button_height := h
			gtk_container_set_border_width (widget, 2)
		end

	tool_bar_make is
			-- Abstraction from all three make routines
		do
			widget := c_gtk_toolbar_new_horizontal
			gtk_object_ref (widget)
			gtk_toolbar_set_tooltips (widget, False)

			-- Create the child list
			create ev_children.make (0)
		end


feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
			-- clear_ev_children
			-- clear contained gtk objects
		
			c_gtk_container_remove_all_children(widget)
			clear_ev_children		
		end

	append_space is
		do
			gtk_toolbar_append_space(widget)
		end

feature -- Implementation

	button_width, button_height: INTEGER
		-- User set default button dimensions.

	toolbar_size: INTEGER

	resize_button (item_imp: EV_TOOL_BAR_BUTTON_IMP) is
		-- Set the button dimensions to that set by user.
		do
			
			if item_imp.height > toolbar_size then
				toolbar_size := item_imp.height
				set_height (toolbar_size)
			end
				
			if button_width >= 0 then
				item_imp.set_minimum_width(button_width)
				item_imp.set_minimum_height(button_height)
			end

			if button_width = -1 and button_height >= 0 then
				item_imp.set_minimum_height(button_height)
			end
		end

	add_item (item_imp: EV_TOOL_BAR_BUTTON_IMP) is
			-- Add `item' to the list.
		local
			dummy: ANY
			dummy_string: STRING
			position: INTEGER
		do
			ev_children.extend (item_imp)
			position := ev_children.count

			create dummy_string.make (0)
			dummy_string := ""
			dummy := dummy_string.to_c

			resize_button (item_imp)
			gtk_toolbar_insert_widget (widget, item_imp.widget, $dummy, $dummy, position)
		end

	insert_item (item_imp: EV_TOOL_BAR_BUTTON_IMP; pos: INTEGER) is
			-- insert `item_imp' at position pos.
		local
			dummy: ANY
			dummy_string: STRING
		do     
			-- if child is already present then remove from tool bar
			if ev_children.has (item_imp) then
				gtk_object_ref (item_imp.widget)
				ev_children.prune_all (item_imp)
				gtk_container_remove (widget, item_imp.widget)
			end

			-- Set button to user-defined size (if set)
			resize_button (item_imp)

			-- Insert value in to children list
			ev_children.go_i_th (pos - 1)
			ev_children.put_right (item_imp)
			
			-- Create redundant string used to fill signature
			create dummy_string.make (0)
			dummy_string := ""
			dummy := dummy_string.to_c
						
			gtk_toolbar_insert_widget (widget, item_imp.widget, $dummy, $dummy, pos - 1)
			gtk_object_unref (item_imp.widget)
		end

	remove_item (item_imp: EV_TOOL_BAR_BUTTON_IMP) is
			-- remove `item_imp' from toolbar.
		do
			ev_children.prune_all (item_imp)
			gtk_container_remove (widget, item_imp.widget)
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
