indexing
	description: "Action sequence for EV_CHECKABLE_LIST check events."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_ITEM_CHECK_ACTION_SEQUENCE
	
inherit
	EV_ACTION_SEQUENCE [TUPLE [EV_LIST_ITEM]]

-- EV_ACTION_SEQUENCE [TUPLE [a_list_item: EV_LIST_ITEM]]
	-- (ETL3 TUPLE with named parameters)
	
create
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (agent wrapper (?, action))
		end

	wrapper (a_list_item: EV_LIST_ITEM; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_list_item])
		end
end

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
