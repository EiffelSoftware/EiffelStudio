indexing
	description: "This class represents a MS_WINDOWS multi-line text editor with scrollbar";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	SCROLLED_T_IMP

inherit
	SCROLLED_T_I

	TEXT_IMP
		redefine
			make, make_word_wrapped,
			realize,
			set_single_line_mode,
			set_multi_line_mode,
			default_style,
			form_height,
			form_width
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation

	make, make_word_wrapped

feature -- Initialization

	make, make_word_wrapped (a_scrolled_text: SCROLLED_T; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a scrolled text
		do
			init_common_controls_dll
			init_rich_edit_dll
			!! private_attributes
			is_multi_line_mode := True
			is_horizontal_scrollbar := True
			is_vertical_scrollbar := True
			parent ?= oui_parent.implementation
			private_text := ""
			tab_length := 6
			managed := man
			a_scrolled_text.set_font_imp (Current)
			set_maximum_size (256 * 1024)	-- 131072 = 128 * 1024
		end

	realize is
			-- Realize current widget
		local
			fw: FONT_IMP
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				if width = 0 then
					set_width (200)
				end

				if height = 0  then 
					fw ?= font.implementation
					set_height (fw.string_height (Current, "I"))
 				end

				resize_for_shell

				wc ?= parent
				wel_make (wc, text, x, y, width, height, id_default)

				set_control_options
				set_maximum_size (maximum_size)
				set_tab_length (tab_length)

				if private_background_color /= Void then
					set_background_color (private_background_color)
				end

				enable_standard_notifications

				if private_font /= Void then
					set_font (private_font)
				end

				set_text (private_text)

				if private_foreground_color /= Void then
					set_foreground_color (private_foreground_color)
				end

				if maximum_size > 0 then
					set_maximum_size (maximum_size)
				end

				set_cursor_position (private_cursor_position)
				if margin_width + margin_height > 0 then
					set_margins (margin_width, margin_height)
				end

				if is_horizontal_scrollbar then
					show_horizontal_scrollbar
				else
					hide_horizontal_scrollbar
				end

				if is_multi_line_mode then
					set_top_character_position (private_top_character_position)
					if is_vertical_scrollbar then
						show_vertical_scrollbar
					else
						hide_vertical_scrollbar
					end
				end

				if not managed then
					wel_hide
				elseif parent.shown then
					shown := true
				end

				if private_is_read_only then
					set_read_only
				end
			end
		end

feature -- Status report

	is_horizontal_scrollbar: BOOLEAN
			-- Is horizontal scrollbar visible ?

	is_vertical_scrollbar: BOOLEAN 
			-- Is vertical scrollbar visible ?

	form_height: integer is
		do
			Result := height
		end

	form_width: integer is
		do
			Result := width
		end

	tab_length: INTEGER
			-- Size for each tabulation

feature -- Status setting

	hide_horizontal_scrollbar is
			-- Make horizontal scrollbar invisible.
		do
			if exists then
				hide_horizontal_scroll_bar
			end
			is_horizontal_scrollbar := False
		ensure then
			no_horizontal_scrollbar: not is_horizontal_scrollbar
		end

	hide_vertical_scrollbar is
			-- Make vertical scrollbar invisible.
		do
			if exists then
				hide_vertical_scroll_bar
			end
			is_vertical_scrollbar := False
		ensure then
			no_vertical_scrollbar: not is_vertical_scrollbar
		end

	set_multi_line_mode is
			-- Set editing for multiline text.
		do
			is_multi_line_mode := true
			show_vertical_scrollbar
		end

	set_single_line_mode is
			-- Set editing for single line text.
		do
			is_multi_line_mode := false
			show_horizontal_scrollbar
		end

	show_horizontal_scrollbar is
			-- Make horizontal scrollbar visible.
		do
			if exists then
				show_horizontal_scroll_bar
			end
			is_horizontal_scrollbar := True
		ensure then
			horizontal_scrollbar: is_horizontal_scrollbar
		end

	show_vertical_scrollbar is
			-- Make vertical scrollbar visible.
		do
			if exists then
				show_vertical_scroll_bar
			end
			is_vertical_scrollbar := True
		ensure then
			vertical_scrollbar: is_vertical_scrollbar
		end

	set_tab_length (new_length: INTEGER) is
			-- Set `tab_length' to `new_length'.
		local
			fw: FONT_IMP
			pos: INTEGER
		do
			tab_length := new_length
			if exists then
				fw ?= font.implementation
				pos := top_character_position
				hide_selection
				set_selection (0, count)
				set_tab_stops (tab_length * fw.average_width * 10)
				set_caret_position (pos)
				show_selection
				invalidate
			end
		end

feature {NONE} -- Inapplicable

	action_target: POINTER is
			-- Inapplicable for Windows
		do
		end

feature {NONE} -- Implementation

	set_control_options is
			-- Set options to control.
		local
			new_options: INTEGER
		do
				--| Automatic scroll when the cursor moves
				--| Always show the selection even if it is not active
				--| Add a small white left part to select lines
			new_options := Eco_autohscroll + Eco_autovscroll + Eco_nohidesel + Eco_savesel + Eco_selectionbar

				--| Overwrite the previous options
			set_options (Ecoop_set, new_options)
		end

	default_style: INTEGER is
			-- Default style for creation.
		do
			Result := {TEXT_IMP} Precursor

			if is_read_only then
				Result := Result + Es_readonly
			end

			if is_multi_line_mode then
				if not is_horizontal_scrollbar then
					Result := Result - Ws_hscroll
				end
	
				if not is_vertical_scrollbar then
					Result := Result - Ws_vscroll
				end
			else
				if is_horizontal_scrollbar then
					Result := Result + Ws_hscroll
				end 
	
				if is_vertical_scrollbar then
					Result := Result + Ws_vscroll
				end
			end
		end

end -- SCROLLED_T_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

