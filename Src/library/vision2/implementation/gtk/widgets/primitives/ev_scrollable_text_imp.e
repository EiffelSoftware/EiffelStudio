--| FIXME Not for release
indexing
	description: "EiffelVision scrollable text area. %
				  %Gtk implementation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_TEXT_IMP

inherit	

	EV_SCROLLABLE_TEXT_I

	EV_TEXT_IMP
		export
			{None} make, make_with_text
		end
				
creation
	make_with_properties

feature -- Initialization

	make_with_properties (txt: STRING; hscroll, vscroll: BOOLEAN) is
			-- Create an empty text area.
			-- The area will be scrollable
		do
			make
			has_horizontal_scrolling := hscroll
			has_vertical_scrolling := vscroll
			set_text (txt)
			--| FIXME IEK Add scrollable features to widget
		end

feature -- Implementation

	hide_horizontal_scroll_bar is
			-- Hide the horizontal scroll bar.
		do
			check
				to_be_implemented: False
			end
		end

	hide_vertical_scroll_bar is
			-- Hide the vertical scroll bar.
		do
			check
				to_be_implemented: False
			end
		end

	show_horizontal_scroll_bar is
			-- Show the horizontal scroll bar.
		do
			check
				to_be_implemented: False
			end
		end

	show_vertical_scroll_bar is
			-- Show the vertical scroll bar.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Status Report
	
	horizontal_scroll_bar_visible: BOOLEAN is
			-- True if horizontal scroll bar visible.
		do
			check
				to_be_implemented: False
			end
		end

	vertical_scroll_bar_visible: BOOLEAN is
			-- True if vertical scroll bar visible.
		do
			check
				to_be_implemented: False
			end
		end

feature {NONE} -- Access

	has_horizontal_scrolling: BOOLEAN

	has_vertical_scrolling: BOOLEAN

	
end -- class EV_SCROLLABLE_TEXT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
