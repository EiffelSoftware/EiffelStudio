indexing
	description: "Text in Scrolled Window which can have tabs set";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TABBED_TEXT_WINDOWS

inherit
	TABBED_TEXT_I

	SCROLLED_TEXT_WINDOWS
		redefine
			realize
		end

creation
	make

feature -- Initialization
		
	realize is
			-- Realize current widget
		local
			fw: FONT_WINDOWS
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				default_style := Ws_child + Ws_visible + Ws_border
					   + Es_nohidesel + Es_left
					   + Es_multiline + Es_autovscroll
				if not is_word_wrap_mode then
					default_style := default_style + Es_autohscroll
				end
				if is_read_only then
					default_style := default_style + Es_readonly
				end
				if is_horizontal_scrollbar then
					default_style := default_style + Ws_hscroll
				end
				if is_vertical_scrollbar then
					default_style := default_style + Ws_vscroll
				end
				if width = 0 then
					set_width (200)
				end
				if height = 0  then 
					if private_font /= Void then
						fw ?= font.implementation
						set_height (fw.string_height (Current, "I"))
					end
				end
				resize_for_shell
				wc ?= parent
				wel_make (wc, text, x, y, width, height, id_default)
				if private_font /= Void then
					set_font (private_font)
				end
				set_text (private_text)
				if maximum_size > 0 then
					set_maximum_size (maximum_size)
				end
				set_cursor_position (private_cursor_position)
				if margin_width + margin_height > 0 then
					set_margins (margin_width, margin_height)
				end
				if tab_positions /= Void then
					if tab_positions.count = 1 then
						set_tab_position (tab_positions.item (1))
					else
						set_tab_positions (tab_positions)
					end
				end
			end
		end

feature -- Status report

	tab_positions: ARRAY [INTEGER]
			-- Positions of tabs.

feature -- Status setting

	set_no_tabs is
			-- Turn off tabulation
		do
			if exists then
				set_default_tab_stops
				invalidate
			end
			tab_positions := Void
		end
	
	set_tab_position (tab_position: INTEGER) is
			-- Set tabs at every `tab_position'
		local
			arr: ARRAY [INTEGER]
		do
			if exists then
				set_tab_stops (tab_position * 4)
				invalidate
			end
			!! tab_positions.make (1,1)
			tab_positions.put (tab_position, 1)
		end

	set_tab_positions (tab_position_array: ARRAY [INTEGER]) is
			-- Set tabs at positions specified in `tab_position_array'
		local
			la: ARRAY [INTEGER]
			i: INTEGER
		do
			tab_positions := clone (tab_position_array)
			if exists then
				from 
					la := clone (tab_position_array)
					i := la.lower
				until
					i > la.upper
				loop
					la.put (la.item (i) * 4, i)
					i := i + 1
				end
				set_tab_stops_array (la)
				invalidate
			end
		end

end -- class TABBED_TEXT_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
