indexing
	description:
		"[
			Base class for all items that may be held in EV_ITEM_LISTs.
		]"
	status: "See notice at end of class."
	keywords: "item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM

inherit
	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_PIXMAPABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_CONTAINABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end
	
	EV_ITEM_ACTION_SEQUENCES
		redefine
			implementation
		end

feature -- Access

	parent: EV_ITEM_LIST [EV_ITEM] is
			-- Item list containing `Current'.
		do
			Result := implementation.parent
		ensure then
			bridge_ok: Result = implementation.parent
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CONTAINABLE} and Precursor {EV_PIXMAPABLE} and
				Precursor {EV_PICK_AND_DROPABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_ITEM

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

