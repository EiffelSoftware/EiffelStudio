indexing
	description: "Action sequences for EV_CHECKABLE_LIST_I"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_I

feature -- Event handling

	check_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Actions to be performed when an item is checked.
		do
			if check_actions_internal = Void then
				check_actions_internal :=
					 create_check_actions
			end
			Result := check_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_check_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Create a check action sequence.
		deferred
		end

	check_actions_internal: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE
			-- Implementation of once per object `check_actions'.

feature -- Event handling

	uncheck_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Actions to be performed when an item is unchecked.
		do
			if uncheck_actions_internal = Void then
				uncheck_actions_internal :=
					 create_uncheck_actions
			end
			Result := uncheck_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_uncheck_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Create a uncheck action sequence.
		deferred
		end

	uncheck_actions_internal: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE
			-- Implementation of once per object `uncheck_actions'.

end -- class EV_CHECKABLE_LIST_ACTION_SEQUENCES_I

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
