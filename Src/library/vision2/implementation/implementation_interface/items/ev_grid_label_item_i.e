indexing
	description: "Cell consisting of only of a text label. Implementation Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ITEM_I
	
inherit
	EV_GRID_ITEM_I
		undefine
			background_color,
			set_background_color
		redefine
			interface
		end
		
	EV_FONTABLE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end
		
	EV_COLORIZABLE_I
		redefine
			interface
		end

create
	make

feature -- Access

	text: STRING is
			-- Text displayed in textable.
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.text")
		end
		
	background_color: EV_COLOR is
			-- Color used for the background of `Current'.
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.background_color")
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of `Current'.
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.foreground_color")
		end
		
	font: EV_FONT is
			-- Font used in `Current'.
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.font")
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.set_text")
		end
		
	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.set_background_color")
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.set_foreground_color")
		end
		
	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.set_font")
		end
		
feature {NONE} -- Implementation

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			to_implement ("EV_GRID_LABEL_ITEM_I.set_default_colors")
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
