indexing
	description:
		"Press button for use with EV_TOOL_BAR"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON

inherit
	EV_TOOL_BAR_ITEM
		redefine
			implementation,
			is_in_default_state,
			parent
		end

	EV_ITEM
		redefine
			implementation,
			is_in_default_state,
			parent
		end

	EV_PICK_AND_DROPABLE
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

	EV_TOOLTIPABLE
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES
		redefine
			implementation
		end

	EV_SENSITIVE
		redefine
			is_in_default_state,
			implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	parent: EV_TOOL_BAR is
			-- Parent of the current item.
		do
			Result ?= Precursor {EV_ITEM}
		end

	gray_pixmap: EV_PIXMAP is
			-- Gray image displayed when the button is not hot
			-- i.e. when the mouse cursor is not over it.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.gray_pixmap
		ensure
			bridge_ok: (Result = Void and implementation.gray_pixmap = Void) or
				Result.is_equal (implementation.gray_pixmap)
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		require
			not_destroyed: not is_destroyed
			gray_pixmap_not_void: a_gray_pixmap /= Void
		do
			implementation.set_gray_pixmap (a_gray_pixmap)
		ensure
			pixmap_assigned: a_gray_pixmap.is_equal (gray_pixmap) and 
							 gray_pixmap /= a_gray_pixmap
		end

	remove_gray_pixmap is
			-- Make `gray_pixmap' `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_gray_pixmap
		ensure
			gray_pixmap_remove: gray_pixmap = Void
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TOOL_BAR_ITEM} and Precursor {EV_ITEM} and
				Precursor {EV_PICK_AND_DROPABLE} and Precursor {EV_TEXTABLE} and
				Precursor {EV_TOOLTIPABLE} and Precursor {EV_SENSITIVE}
		end
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_BUTTON_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TOOL_BAR_BUTTON_IMP} implementation.make (Current)
		end

feature -- Obsolete

	press_actions: EV_NOTIFY_ACTION_SEQUENCE is
		obsolete
			"use select_actions"
		do
			Result := select_actions
		end

end -- class EV_TOOL_BAR_BUTTON

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
