indexing
	description:
		"Base Eiffel Vision action sequence."
	status: "See notice at end of file."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ACTION_SEQUENCE [EVENT_DATA -> TUPLE create default_create end]

inherit
	ACTION_SEQUENCE [EVENT_DATA]
		undefine
			new_filled_list
		end

feature -- Element change

	force_extend (an_item: PROCEDURE [ANY, TUPLE]) is
			-- Extend without checking type of `an_item'.
		deferred
		end

	extend_kamikaze (an_item: like item) is
			-- Extend `an_item' and remove it again after it is called.
		do
			extend (an_item)
			prune_when_called (an_item)
		end

end -- class EV_ACTION_SEQUENCE

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

