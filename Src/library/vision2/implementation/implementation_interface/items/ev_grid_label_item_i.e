indexing
	description: "Cell consisting of only of a text label. Implementation Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ITEM_I
	
inherit
	EV_GRID_ITEM_I
		redefine
			interface,
			redraw,
			initialize
		end

create
	make
	
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_GRID_ITEM_I}
			interface.set_text ("")
		end

feature {EV_GRID_DRAWER_I} -- Implementation
		
	internal_default_font: EV_FONT is
			-- Default font used for `Current'.
		once
			create Result
		end
		
	redraw (an_x, a_y, a_width, a_height: INTEGER; drawable: EV_DRAWABLE) is
			-- Redraw `Current'.
		local
			back_color: EV_COLOR
		do
			fixme ("Correctly handle selection colors and inversion")
			
			
			back_color := internal_background_color
			if back_color = Void then
				back_color := parent_i.background_color
			end
			drawable.set_foreground_color (back_color)
			drawable.fill_rectangle (an_x, a_y, a_width, a_height)
			if is_selected then
				drawable.set_foreground_color (parent_i.selection_color)
				drawable.set_and_mode
				drawable.fill_rectangle (an_x, a_y, a_width, a_height)
				drawable.set_foreground_color ((create {EV_STOCK_COLORS}).white)
			else
				drawable.set_foreground_color (foreground_color)
			end
			
			drawable.set_copy_mode
			if interface.font /= Void then
				drawable.set_font (interface.font)
			else
				drawable.set_font (internal_default_font)
			end
			if interface.text /= Void then
				drawable.draw_ellipsed_text_top_left (an_x, a_y, interface.text, a_width)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID_LABEL_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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
