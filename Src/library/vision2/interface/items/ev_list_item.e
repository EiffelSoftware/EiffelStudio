indexing	
	description: 
		"Item for use in EV_LIST and EV_COMBO_BOX."
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
		-- These features may only be called when list item is in parent.
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

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and precursor {EV_TEXTABLE} and
				Precursor {EV_DESELECTABLE} and precursor {EV_DESELECTABLE} 
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_LIST_ITEM_I
			-- Responsible for interaction with the native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_LIST_ITEM_IMP} implementation.make (Current)
		end

feature -- Obsolete

	is_first: BOOLEAN is
			-- Is `Current' first in list?
		obsolete
			"use my_list.first = Current"
		require
			parent_not_void: parent /= Void
		do
			Result := parent.first = Current
		end

	is_last: BOOLEAN is
			-- Is `Current' last in list?
		obsolete
			"use my_list.last = Current"
		require
			parent_not_void: parent /= Void
		do
			Result := parent.last = Current
		end

end -- class EV_LIST_ITEM

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
