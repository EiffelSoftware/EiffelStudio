indexing
	description: "EiffelVision scrollable text area. %
				  %Mswindows implementation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_TEXT_IMP

inherit	

	EV_SCROLLABLE_TEXT_I
		rename
			make_with_text as text_make_with_text,
			make as text_make
		end
		
	EV_TEXT_IMP
		rename
			make_with_text as text_make_with_text,
			make as text_make
		redefine
			default_style
		end
				
creation
	make,
	make_with_text

feature -- Initialization

	make (hscroll, vscroll: BOOLEAN) is
			-- Create an empty text area.
			-- The area will be scrollable
		do
			make_with_text ("", hscroll, vscroll)
		end

	make_with_text (txt: STRING; hscroll, vscroll: BOOLEAN) is
			-- Create a text area with `text' as label.
			-- The area will be scrollable.
		do
			has_horizontal_scrolling := hscroll
			has_vertical_scrolling := vscroll
			wel_make (default_parent, txt, 0, 0, 0, 0, 0)
		end
		
feature -- Status Report
	
	horizontal_scroll_bar_visible: BOOLEAN is
			-- True if horizontal scroll bar visible.
		do
			if flag_set (style, Ws_hscroll) then
				Result := True
			end
		end

	vertical_scroll_bar_visible: BOOLEAN is
			-- True if vertical scroll bar visible.
		do
			if flag_set (style, Ws_vscroll) then	
				Result := True
			end
		end
	
feature {NONE}

	has_horizontal_scrolling: BOOLEAN
	
	has_vertical_scrolling: BOOLEAN

feature {NONE} -- WEL Implementation
 
	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := basic_default_style
			if has_horizontal_scrolling then
				Result := Result + Es_autohscroll
			end
			if has_vertical_scrolling then
				Result := Result + Es_autovscroll
			end
		end

	basic_default_style: INTEGER is
			-- Basic default style used to create the control.
			-- Style returned is not scrollable at all.
		do
			Result := Ws_child + Ws_visible + Ws_group 
					+ Ws_tabstop + Ws_border + Es_left
					+ Es_multiline + Es_wantreturn
		end

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
