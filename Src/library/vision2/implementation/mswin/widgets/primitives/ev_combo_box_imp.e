indexing 
	description: "EiffelVision Combo-box. Implementation interface"
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMBO_BOX_IMP

inherit

	EV_COMBO_BOX_I

	EV_ITEM_CONTAINER_IMP
		redefine
			ev_children
		end

	EV_TEXT_COMPONENT_IMP
		rename
			wel_make as old_wel_make
		end	
	
	EV_BAR_ITEM_IMP

	WEL_DROP_DOWN_COMBO_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
			remove_command,
			set_width,
			set_height,
			destroy,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		end

creation

	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a combo-box with `par' as parent.
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			wel_make (par_imp, 0, 0, 0, 0, 0)
			initialize
		end

feature -- Access

	read_element (index: INTEGER): STRING is
			-- Text at the zero-based `index'
		do
		end

feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		do
		end

feature -- Element change

	add_element (a_string: STRING) is
			-- Add an element with the text `a_string' 
			-- to the combo-box.
			-- If string is `Void', it add an element with 
			-- an empty string "".
		do
		end

	insert_element (a_string: STRING; index: INTEGER) is
			-- Insert an element with the text `a_string'
			-- at the zero-based `index' position of the 
			-- combo box.
			-- If string is `Void', it add an element with 
			-- an empty string "".
		do
		end				

	remove_element (index: INTEGER) is
			-- Remove the element at the zero-based
			-- `index' position of the combo-box.
		do
		end

	remove_all_elements is
			-- Remove all the elements of the combo-box.
		do
		end

feature -- Event : command association

	add_activate_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
		do
		end

feature {EV_COMBO_BOX_ITEM_IMP} -- Implementation

	ev_children: LINKED_LIST [EV_COMBO_BOX_ITEM_IMP]

	add_item (an_item: EV_COMBO_BOX_ITEM) is
			-- Add an item to the list of the combo-box
		local
			item_imp: EV_COMBO_BOX_ITEM_IMP
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			ev_children.extend (item_imp)
			add_string (name_item)
			item_imp.set_id (ev_children.count - 1)
		end

feature {EV_COMBO_BOX_ITEM_IMP} -- Implementation

	remove_item (an_id: INTEGER) is
			-- Remove the child whose id is `id'.
		do
			delete_string (an_id)
			ev_children.go_i_th (an_id + 1)
			ev_children.remove
			from
			until
				ev_children.after
			loop
				ev_children.item.set_id (ev_children.index - 1)
				ev_children.forth
			end
		end

end -- class EV_COMBO_BOX_IMP

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
