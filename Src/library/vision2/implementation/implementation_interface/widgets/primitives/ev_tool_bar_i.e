indexing
	description: "EiffelVision toolbar. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
		
	EV_DOCKABLE_TARGET_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_TOOL_BAR_ITEM]
		redefine
			interface
		end
		
feature -- Status report

	has_vertical_button_style: BOOLEAN is
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.
		deferred
		end
		
feature -- Status setting

	enable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `True'.
		deferred
		ensure
			vertical_button_style_assigned: has_vertical_button_style
		end
		
	disable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `False'.
		deferred
		ensure
			vertical_button_style_not_assigned: not has_vertical_button_style
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	insertion_position: INTEGER is
			-- `Result' is index to left of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button. i.e if over button 1, `Result' is 0.
		deferred
		end
		
	block_selection_for_docking is
			-- Ensure that a tool bar button is not selected as a
			-- result of the transport ending.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_I

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

