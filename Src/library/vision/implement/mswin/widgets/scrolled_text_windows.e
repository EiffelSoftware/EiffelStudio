indexing

	description: "This class represents a MS_WINDOWS multi-line text editor with scrollbar";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	SCROLLED_TEXT_WINDOWS

inherit

	TEXT_WINDOWS
		redefine
			make,
			realize,
			set_single_line_mode,
			set_multi_line_mode,
			default_style,
			form_height,
			form_width
		end

	SCROLLED_T_I

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation

	make

feature -- Initialization

	make (a_scrolled_text: SCROLLED_T; man: BOOLEAN; oui_parent: COMPOSITE) is
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
			managed := man
			a_scrolled_text.set_font_imp (Current)
			set_maximum_size (131072)	-- 131072 = 128 * 1024
		end

	realize is
			-- Realize current widget
		local
			fw: FONT_WINDOWS
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				if width = 0 then
					set_width (200)
				end

				if height = 0  then 
					fw ?= font.implementation
					set_height (fw.string_height (Current, "I") * 7 // 4 + 2)
 				end

				resize_for_shell
				wc ?= parent
				wel_make (wc, text, x, y, width, height, id_default)
				set_control_options
				enable_standard_notifications

				if private_background_color /= Void then
					set_background_color (private_background_color)
				end

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

				if is_horizontal_scrollbar then
					show_horizontal_scrollbar
				end

				if is_multi_line_mode then
					if is_vertical_scrollbar then
						show_vertical_scrollbar
					end
				end

				if not managed then
					wel_hide
				elseif parent.shown then
					shown := true
				end

				if is_multi_line_mode then
					set_top_character_position (private_top_character_position)
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

feature {NONE} -- Inapplicable

	action_target: POINTER is
			-- Inapplicable for Windows
		do
		end

feature {NONE} -- Implementation

	set_control_options is
			-- Set options to control.
		local
			options: INTEGER
		do
			options := Eco_autovscroll + Eco_nohidesel + eco_savesel + Eco_selectionbar 
			if not is_word_wrap_mode then
				options := options + Eco_autohscroll
			end
			set_options (Ecoop_set, options)
		end

	default_style: INTEGER is
			-- Default style for creation.
		do
			Result := {TEXT_WINDOWS} precursor - Ws_hscroll - Ws_vscroll

			if is_read_only then
				Result := Result + Es_readonly
			end

			if is_horizontal_scrollbar then
				Result := Result + Ws_hscroll
			end

			if is_vertical_scrollbar then
				Result := Result + Ws_vscroll
			end
		end

end -- SCROLLED_TEXT_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
