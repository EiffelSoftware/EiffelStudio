indexing
	description:
		"[
			Displays a list of items from which the user may select.
			Each item has an associated check box.
		]"
	status: "See notice at end of class"
	keywords: "list, check, checkable"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_LIST
	
inherit
	EV_LIST
		redefine
			implementation,
			create_implementation
		end
		
	EV_CHECKABLE_LIST_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end
	
create
	default_create,
	make_with_strings

feature -- Access

	checked_items: DYNAMIC_LIST [EV_LIST_ITEM] is
			-- All items checked in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.checked_items	
		ensure
			bridge_ok: lists_equal (Result, implementation.checked_items)
		end
		
	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN is
			-- Is `list_item' currently checked?
		require
			not_destroyed: not is_destroyed
			has_an_item: has (list_item)
		do
			Result := implementation.is_item_checked (list_item)
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (list_item)
		do
			implementation.check_item (list_item)
		ensure
			item_is_checked: is_item_checked (list_item)
		end
		
	uncheck_item (list_item: EV_LIST_ITEM) is
			-- Ensure `list_item' is not checked.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (list_item)
		do
			implementation.uncheck_item (list_item)
		ensure
			item_is_not_checked: not is_item_checked (list_item)
		end
		
feature {EV_ANY_I, EV_LIST} -- Implementation

	implementation: EV_CHECKABLE_LIST_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_CHECKABLE_LIST_IMP} implementation.make (Current)
		end

invariant
	selected_items_not_void: is_usable implies selected_items /= Void
	checked_items_consistent: checked_items.for_all (agent is_item_checked)
	checked_items_valid: checked_items.count >= 0 and checked_items.count <= count
	--checked_items_ordered: checked_items.for_all (agent valid_position )

end -- class EV_CHECKABLE_LIST

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

