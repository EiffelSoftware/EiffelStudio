indexing
	description: "Action sequences for EV_CHECKABLE_LIST."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHECKABLE_LIST_ACTION_SEQUENCES
	
inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end
		
feature {NONE} -- Implementation

	implementation: EV_CHECKABLE_LIST_ACTION_SEQUENCES_I

feature -- Event handling

	check_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Actions to be performed when item is checked.
		do
			Result := implementation.check_actions
		ensure
			not_void: Result /= Void
		end
		
	uncheck_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Actions to be performed when item is unchecked.
		do
			Result := implementation.uncheck_actions
		ensure
			not_void: Result /= Void
		end

end -- class EV_CHECKABLE_LIST_ACTION_SEQUENCES

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

