indexing
	description: "Eiffel Vision tool bar item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_ITEM_IMP

inherit
	EV_ITEM_IMP
		redefine
			interface
		end
	
	EV_ID_IMP

feature -- Access

	text: STRING is
			-- Text displayed in textable.
		deferred
		end
		
	has_pixmap: BOOLEAN is
			-- Has Current a pixmap?
		deferred
		end
		
	image_index: INTEGER
			-- Index of the pixmaps in the imagelists.

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive?
		deferred
		end
		
	disable_sensitive is
			-- Enable `Current'.
		deferred
		end
		
	enable_sensitive is
			-- Disable `Current'.
		deferred
		end
		
	internal_non_sensitive: BOOLEAN is
			-- Is `Current' not sensitive to input as seen
			-- from `interface'?
		deferred
		end
		
	restore_private_pixmaps is
			-- When `Current' is parented, `private_pixmap' and
			-- `private_gray_pixmap' are assigned Void. This is to stop
			-- us keeping to many references to GDI objects. When
			-- `Current' is removed from its parent, we must then
			-- restore them. 
		deferred
		end

feature -- Status setting

	set_pixmap_in_parent is
			-- Add the pixmap to the parent by updating the 
			-- parent's image list.
		deferred
		end
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		deferred
		end
		
feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR_ITEM
		
end -- class EV_TOOL_BAR_ITEM_IMP

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

