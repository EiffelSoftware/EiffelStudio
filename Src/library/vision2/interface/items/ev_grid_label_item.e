indexing
	description: "Cell consisting of a text label with optional pixmap"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ITEM

inherit
	EV_GRID_ITEM
		redefine
			is_in_default_state,
			implementation,
			create_implementation
		end
	
create
	default_create,
	make_with_text
	
feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current' and assign `a_text' to `text'
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		ensure
			text_assigned: text = a_text
		end
		
feature -- Status Setting
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		do
			text := a_text
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			text_set: text = a_text
		end

	remove_text is
			-- Make `text' `is_empty'.
		require
			not_destroyed: not is_destroyed
		do
			set_text ("")
		ensure
			text_empty: text.is_empty
		end
		
	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			not_destroyed: not is_destroyed
			a_font_not_void: a_font /= Void
		do
			font := a_font
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			font_assigned: font = a_font
		end
		
	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Display image of `a_pixmap' on `Current'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap is
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			pixmap := Void
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			pixmap_removed: pixmap = Void
		end

feature -- Status report

	text: STRING
		-- Text displayed in `Current'.
		
	font: EV_FONT
		-- Typeface appearance for `Current'.
			
	pixmap: EV_PIXMAP
		-- Image displayed to left of `text'.
	
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_GRID_ITEM} and text.is_empty and pixmap = Void
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_LABEL_ITEM_I} implementation.make (Current)
		end

end

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
