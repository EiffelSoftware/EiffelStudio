indexing
	description:
		"Eiffel Vision tool bar separator. Mswindows implemenatation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		undefine
			parent
		redefine
			interface
		end
		
	EV_TOOL_BAR_ITEM_IMP
		redefine
			interface
		end

creation
	make
	
feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			make_id
		end

	initialize is
			-- Do post creation initialization.
		do
			is_initialized := True
		end

feature {NONE} -- Implementation
		
	parent_imp: EV_TOOL_BAR_IMP
		-- The parent of `Current'.

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Make `a_parent_imp' the new parent of `Current'.
			-- `a_parent_imp' can be Void then the parent is the screen.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
				parent_imp.auto_size
			else
				parent_imp := Void
			end
		end
		
	text: STRING is
			-- Text displayed in textable.
			-- For seperators, it must always be empty.
		do
			Result := ""
		end
		
	has_pixmap: BOOLEAN is False
			-- Has Current a pixmap?
		
	set_pixmap_in_parent is
			-- Add the pixmap to the parent by updating the 
			-- parent's image list.
		do
			check
				not_called: False
			end
		end
		
	image_index: INTEGER is 0
			-- Index of the pixmaps in the imagelists.
			-- A separator does not have an image.
		
	is_sensitive: BOOLEAN is True
			-- Is `Current' sensitive?
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Nothing to do here.
		end
		
	disable_sensitive is
			-- Enable `Current'.
		do
			-- Nothing to do here.
		end
		
	enable_sensitive is
			-- Disable `Current'.
		do
			-- Nothing to do here.
		end
		
	internal_non_sensitive: BOOLEAN is True
			-- Is `Current' not sensitive to input as seen
			-- from `interface'?
		
	restore_private_pixmaps is
			-- When `Current' is parented, `private_pixmap' and
			-- `private_gray_pixmap' are assigned Void. This is to stop
			-- us keeping to many references to GDI objects. When
			-- `Current' is removed from its parent, we must then
			-- restore them.
		do
			-- Nothing to do here.
		end


feature {EV_ANY_I} -- Interface
	
	interface: EV_TOOL_BAR_SEPARATOR
	
invariant
	no_pixmap: has_pixmap = False
	image_index_zero: image_index = 0

end -- class EV_TOOL_BAR_SEPARATOR_IMP

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

