indexing	
	description: 
		"[
			Item for use in EV_LIST and EV_COMBO_BOX.
		]"
	status: "See notice at end of class"
	keywords: "list, item, combo"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM

inherit
	EV_ITEM
		redefine
			is_in_default_state,
			implementation
		end

	EV_TEXTABLE
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_DESELECTABLE
			-- These features may only be called when `Current' is parented.
			-- See `is_selectable' from EV_SELECTABLE.
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_TOOLTIPABLE
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_LIST_ITEM_ACTION_SEQUENCES
		redefine
			implementation
		end
		
create
	default_create,
	make_with_text
	
feature -- Obsolete

	align_text_left is
			-- Display text left aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end
	
	align_text_center is
			-- Display text center aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end
		
	align_text_right is
			-- Display text right aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and precursor {EV_TEXTABLE} and
				Precursor {EV_DESELECTABLE} and precursor {EV_DESELECTABLE} 
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_LIST_ITEM_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_LIST_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_LIST_ITEM

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

