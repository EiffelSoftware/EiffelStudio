indexing
	description: "EiffelVision list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_IMP

inherit
	EV_LIST_I

	EV_PRIMITIVE_IMP
		undefine
			initialize_colors
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			widget := gtk_list_new
			gtk_widget_show (widget)
		end

feature -- Access

	get_item (index: INTEGER): EV_LIST_ITEM is
			-- Give the item of the list at the one-base
			-- index.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status report

	count: INTEGER is
		 	-- Number of lines
		do
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		do
		end

feature -- Status setting

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			gtk_list_set_selection_mode (widget, GTK_SELECTION_MULTIPLE)
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			gtk_list_set_selection_mode (widget, GTK_SELECTION_SINGLE)
		end

feature {EV_LIST_ITEM} -- Implementation

	add_item (item: EV_LIST_ITEM) is
			-- Add `item' to the list
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= item.implementation
			check
				correct_imp: item_imp /= Void
			end
			c_gtk_add_list_item (widget, item_imp.widget)
		end

end -- class EV_LIST_IMP

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
