indexing
	description: "FIXME"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			initialize,
			make
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
			set_c_object (C.gtk_list_item_new)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create list item box to hold label and pixmap.
		local
			item_box: POINTER
		do
			{EV_ITEM_IMP} Precursor
			textable_imp_initialize
			pixmapable_imp_initialize
			item_box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, item_box)
			C.gtk_widget_show (item_box)
				-- Add the pixmap box to the item but hide it so it
				-- takes up no space in the item.
			C.gtk_box_pack_start (item_box, pixmap_box, False, False, 2)
				-- Padding of 2 pixels used for pixmap
			C.gtk_box_pack_start (item_box, text_label, True, True, 0)

			--C.gtk_widget_hide (pixmap_box)	
			is_initialized := True
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				Result := 1 + C.gtk_list_child_position (par, c_object)
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				Result := C.g_list_find (
					C.gtk_list_struct_selection (par),
					c_object
				) /= NULL
			end
		end

feature -- Status setting

	enable_select is
			-- Select the item.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				C.gtk_list_select_child (par, c_object);
--| FIXME hack to ensure the element is selected.				
				if
					C.g_list_find (
						C.gtk_list_struct_selection (par),
						c_object
					) = NULL
				then
					C.gtk_list_select_child (par, c_object);
				end
			end
		end

	disable_select is
			-- Deselect the item.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				C.gtk_list_unselect_child (par, c_object);
			end
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			combo_par: EV_COMBO_BOX_IMP
			a_text: ANY
		do
			Precursor (txt)
			a_text := txt.to_c
			-- the gtk part if the parent is a combo_box
			combo_par ?= parent_imp
			if (combo_par /= Void) then
				C.gtk_combo_set_item_string (
					combo_par.c_object,
					c_object, $a_text
				)
			end
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

	interface: EV_LIST_ITEM

end -- class EV_LIST_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

