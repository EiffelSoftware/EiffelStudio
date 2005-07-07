indexing
	description: "Eiffel Vision checkable list. Gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"


class
	EV_CHECKABLE_LIST_IMP
	
inherit
	EV_CHECKABLE_LIST_I
		undefine
			wipe_out,
			selected_items
		redefine
			interface
		end
	
	EV_LIST_IMP
		redefine
			interface,
			add_to_container
		end
		
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_IMP
	
create
	make

feature -- Implementation

	add_to_container (v: like item; v_imp: EV_LIST_ITEM_IMP) is
			-- Add `v' to end of list.
			-- (from EV_ITEM_LIST_IMP)
			-- (export status {NONE})
		do
			Precursor {EV_LIST_IMP} (v, v_imp)
			{EV_GTK_EXTERNALS}.gtk_widget_show (v_imp.check_box)
		end
		
feature -- Access

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN is
			--
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (item_imp.check_box)
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation
			{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (item_imp.check_box, True)
		end

	uncheck_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation
			{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (item_imp.check_box, False)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_LIST
	
end -- class EV_CHECKABLE_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

