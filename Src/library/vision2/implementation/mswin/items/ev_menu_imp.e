indexing

	description: 
		"EiffelVision menu box. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_IMP
	
inherit
	EV_MENU_I

	EV_MENU_ITEM_CONTAINER_IMP

	WEL_MENU
		rename
			make as wel_make
		end

creation
	make_with_text

feature {NONE} -- Initialization
	
	make_with_text (par: EV_MENU_CONTAINER; label: STRING) is
			-- Create the control window and the menu inside. 
		local
			par_imp: EV_MENU_CONTAINER_IMP
		do
			wel_make
			par_imp ?= par.implementation
			check
				valid_container: par_imp /= Void
			end
			ev_children := par_imp.ev_children
			set_text (label)
		end	

feature -- Status report
	
	container: EV_MENU_CONTAINER_IMP

	text: STRING

	set_text (str:STRING) is
			-- Set `text' to `str'
		do
			text := str
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	add_item (an_item: EV_MENU_ITEM) is
			-- Add `an_item' into container.
		local
			item_imp: EV_MENU_ITEM_IMP
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			ev_children.extend (item_imp)
			append_string (name_item, ev_children.count)
			item_imp.set_id (ev_children.count)
			item_imp.set_position (count - 1)
		end

	insert_item (wel_menu: WEL_MENU; pos: INTEGER; label: STRING) is
				-- Insert an item which contains other items in
				-- the menu.
		do
			insert_popup (wel_menu, pos, label)
		end

	remove_item (an_id: INTEGER) is
			-- Remove the item with `id' as identification
		do
			delete_item (an_id)
			ev_children.go_i_th (an_id)
			ev_children.remove
			from
			until
				ev_children.after
			loop
				ev_children.item.set_id (ev_children.index)
				ev_children.forth
			end
		end

	uncheck_radio_items is
			-- Uncheck all the radio-items of the container.
		local
			item_test: EV_RADIO_MENU_ITEM_IMP
		do
			from
				ev_children.start
			until
				ev_children.after
			loop
				item_test ?= ev_children.item
				if item_test /= Void then
					item_test.set_state (false)
				end
				ev_children.forth
			end
		end

end -- class EV_MENU_IMP

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
