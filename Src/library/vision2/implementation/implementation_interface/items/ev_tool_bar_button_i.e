indexing
	description:
		" EiffelVision Toolbar button, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_BUTTON_I

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_SENSITIVE_I
		redefine
			interface
		end
		
	EV_DOCKABLE_SOURCE_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_I

feature -- Access

	gray_pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		require
			gray_pixmap_not_void: a_gray_pixmap /= Void
		deferred
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		deferred
		end

feature {NONE} -- Implementation

	enable_sensitive is
			-- Enable sensitivity to user input events.
		deferred
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		deferred
		end

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive?
		deferred
		end

	parent_is_sensitive: BOOLEAN is
			-- Is `parent' sensitive?
		deferred
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		deferred
		end

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_I

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

