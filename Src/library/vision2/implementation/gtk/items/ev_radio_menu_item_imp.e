indexing

	description:
		"EiffelVision radio menu item. gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$";
	revision: "$Revision$"

class EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		redefine
			parent_imp
		end

	EV_CHECK_MENU_ITEM_IMP
		redefine
			make_with_text,
			parent_imp
		end

creation
	make,
	make_with_text
--	make_with_pixmap,
--	make_with_all

feature {NONE} -- Initialization
	
	make_with_text (txt: STRING) is
			-- Create a radio menu item with`txt' as label.
		do
			dummy_item := gtk_radio_menu_item_new (Default_pointer)
			widget := gtk_radio_menu_item_new (Default_pointer)
			gtk_radio_menu_item_set_group (widget,
				gtk_radio_menu_item_group (dummy_item));
			set_state (False)
			gtk_check_menu_item_set_show_toggle (widget, True)
			initialize
			create_text_label (txt)
			gtk_misc_set_alignment (label_widget, 0.0, 0.5)
			gtk_misc_set_padding (label_widget, 21, 0)
		end		

feature -- Access

	parent_imp: EV_MENU_ITEM_HOLDER_IMP
			-- Parent of the item

feature -- Status report

	is_peer (peer: EV_RADIO_MENU_ITEM): BOOLEAN is
			-- Is this item in same group as peer
		local
			peer_imp: EV_RADIO_MENU_ITEM_IMP
		do
			peer_imp ?= peer.implementation
			check
				valid_peer_implementation: peer_imp /= Void
			end
			Result := group /= Default_pointer and group = peer_imp.group
		end


feature -- Status Setting

	set_peer (peer: EV_RADIO_MENU_ITEM) is
			-- Put in same group as peer
		local
			peer_imp: EV_RADIO_MENU_ITEM_IMP
		do
			peer_imp ?= peer.implementation
			check
				valid_peer_implementation: peer_imp /= Void
			end
			gtk_radio_menu_item_set_group (widget, peer_imp.group)
		end

feature {EV_RADIO_MENU_ITEM_IMP} -- Implementation

	group: POINTER is
			-- GSList* that represents group
		require
			exists: not destroyed
		do
			Result := gtk_radio_menu_item_group (widget)
		ensure
			valid_group: Result /= Default_pointer
		end

	dummy_item: POINTER

end -- class EV_RADIO_MENU_ITEM_IMP

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
--|----------------------------------------------------------------
