note
	description: "String representation expanded viewer  ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_DISPLAY_VIEWER_BOX

inherit

	EB_OBJECT_VIEWER
		redefine
			build_mini_tool_bar,
			build_tool_bar
		end

	EV_SHARED_APPLICATION

	EB_CONSTANTS

	ES_SHARED_FONTS_AND_COLORS

	SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	build_widget
		local
			vb: EV_VERTICAL_BOX
		do
			slice_min_ref := 0
			slice_max_ref := default_slice_max_value

			create vb
			widget := vb
			if not is_associated_with_tool then
				vb.set_border_width (layout_constants.small_border_size)
			else
				vb.set_border_width (layout_constants.small_border_size)
			end
			vb.set_padding_width (layout_constants.tiny_padding_size)

				--| Top slices box
			build_slices_box
			if is_associated_with_tool then
				build_tool_bar
				if attached {EV_WIDGET} tool_bar as lt_widget then
					vb.extend (lt_widget)
					vb.disable_item_expand (lt_widget)
				else
					check not_possible: False end
				end
			end

				--| Editor
			create editor
			editor.set_minimum_height (100)
			editor.set_background_color (No_text_background_color)
			editor.set_font (preferences.editor_data.font)

			editor.enable_word_wrapping
			editor.disable_edit
			editor.drop_actions.extend (agent on_stone_dropped)
			editor.drop_actions.set_veto_pebble_function (agent is_valid_stone)
			editor.caret_move_actions.extend (agent on_caret_moved)

			vb.extend (editor)

				-- By default, make a tab be the width of 8 spaces.
			editor.set_tab_width (text_format.font.string_width ("        "))

 			set_title (name)
		end

	default_slice_max_value: INTEGER
		do
			Result := preferences.debug_tool_data.default_expanded_view_size
		end

	build_slices_box
			-- Build slices box
		local
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			l_tb: SD_TOOL_BAR
			but: SD_TOOL_BAR_BUTTON
		do
			if slices_box = Void then
				create hb
				hb.set_padding_width (layout_constants.tiny_padding_size)

				create lab.make_with_text (Interface_names.l_slice_limits)
				hb.extend (lab)
				hb.disable_item_expand (lab)

				create lower_slice_field
				lower_slice_field.return_actions.extend (agent return_pressed_in_lower_slice_field)
				lower_slice_field.set_minimum_width_in_characters (7)

				hb.extend (lower_slice_field)
				hb.disable_item_expand (lower_slice_field)

				create lab.make_with_text (Interface_names.l_to)
				hb.extend (lab)
				hb.disable_item_expand (lab)

				create upper_slice_field
				upper_slice_field.return_actions.extend (agent return_pressed_in_upper_slice_field)
				upper_slice_field.set_minimum_width_in_characters (7)
				hb.extend (upper_slice_field)
				hb.disable_item_expand (upper_slice_field)

				create l_tb.make
				create but.make
				but.set_pixmap (pixmaps.icon_pixmaps.general_tick_icon)
				but.set_pixel_buffer (pixmaps.icon_pixmaps.general_tick_icon_buffer)
				but.select_actions.extend (agent set_slice_selected)
				but.set_tooltip (Interface_names.l_set_slice_values)
				l_tb.extend (but)
				l_tb.compute_minimum_size
				hb.extend (l_tb)
				hb.disable_item_expand (l_tb)

				slices_box := hb
				set_slices_text (slice_min, slice_max)
			end
		end

	build_tool_bar
			-- <Precursor>
		local
			l_tb: SD_GENERIC_TOOL_BAR
			l_tbw: SD_WIDGET_TOOL_BAR
			tbb: SD_TOOL_BAR_BUTTON
			tbtgb: SD_TOOL_BAR_TOGGLE_BUTTON
			tbw: SD_TOOL_BAR_WIDGET_ITEM
			lab: EV_LABEL
			l_pos_txt: EV_LABEL
			l_char_txt: EV_LABEL
		do
			if tool_bar = Void then
				create l_tbw.make (create {SD_TOOL_BAR}.make)
				l_tb := l_tbw
				tool_bar := l_tb

				build_slices_box
				create tbw.make (slices_box)
				tbw.set_name ("slices")
				l_tb.extend (tbw)
				l_tb.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				create tbb.make
				tbb.set_pixmap (pixmaps.icon_pixmaps.debugger_object_expand_icon)
				tbb.set_pixel_buffer (pixmaps.icon_pixmaps.debugger_object_expand_icon_buffer)
				tbb.select_actions.extend (agent auto_slice_selected)
				tbb.set_tooltip (interface_names.l_viewer_display_auto_upper_limit)
				l_tb.extend (tbb)

				l_tb.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				create tbtgb.make
				tbtgb.set_pixmap (pixmaps.icon_pixmaps.general_word_wrap_icon)
				tbtgb.set_pixel_buffer (pixmaps.icon_pixmaps.general_word_wrap_icon_buffer)
				tbtgb.enable_select
				tbtgb.select_actions.extend (agent word_wrap_toggled (tbtgb))
				tbtgb.set_tooltip (interface_names.l_viewer_enable_word_wrapping)
				l_tb.extend (tbtgb)
				register_word_wrap_button (tbtgb)

				create tbb.make
				tbb.set_pixmap (pixmaps.icon_pixmaps.general_copy_icon)
				tbb.set_pixel_buffer (pixmaps.icon_pixmaps.general_copy_icon_buffer)
				tbb.select_actions.extend (agent copy_button_selected)
				tbb.set_tooltip (interface_names.l_copy_text_to_clipboard)
				l_tb.extend (tbb)

				l_tb.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				create lab.make_with_text ("Character: ")
				lab.set_minimum_width (lab.font.string_width (lab.text))
				lab.align_text_left
				lab.align_text_vertical_center
				create tbw.make (lab)
				l_tb.extend (tbw)

				create l_char_txt
				l_char_txt.set_foreground_color (colors.stock_colors.blue)
				l_char_txt.set_minimum_width (l_char_txt.font.string_width ("U+12345 %%/12345/ '##'"))
				l_char_txt.align_text_left
				l_char_txt.align_text_vertical_center

				character_text := l_char_txt
				create tbw.make (l_char_txt)
				tbw.set_name ("character")
				l_tb.extend (tbw)

				create lab.make_with_text (" at index ")
				lab.set_minimum_width (lab.font.string_width (lab.text))
				lab.align_text_left
				lab.align_text_vertical_center
				create tbw.make (lab)
				l_tb.extend (tbw)

				create l_pos_txt
				l_pos_txt.set_foreground_color (colors.stock_colors.blue)
				l_pos_txt.set_minimum_width (l_pos_txt.font.string_width ("123456"))
				l_pos_txt.align_text_left
				l_pos_txt.align_text_vertical_center

				position_text := l_pos_txt
				create tbw.make (l_pos_txt)
				tbw.set_name ("index")
				l_tb.extend (tbw)

				l_tb.compute_minimum_size
			end
		end

	build_mini_tool_bar
		local
			l_tb: like mini_tool_bar
			tbb: SD_TOOL_BAR_BUTTON
			tbtgb: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			if mini_tool_bar = Void then
				create l_tb.make
				mini_tool_bar := l_tb

				create tbb.make
				tbb.set_pixmap (pixmaps.mini_pixmaps.viewer_expand_icon)
				tbb.set_pixel_buffer (pixmaps.mini_pixmaps.viewer_expand_icon_buffer)
				tbb.select_actions.extend (agent auto_slice_selected)
				tbb.set_tooltip (Interface_names.l_viewer_display_complete_object)
				l_tb.extend (tbb)

				l_tb.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				create tbtgb.make
				tbtgb.set_pixmap (pixmaps.mini_pixmaps.viewer_wrap_icon)
				tbtgb.set_pixel_buffer (pixmaps.mini_pixmaps.viewer_wrap_icon_buffer)
				tbtgb.enable_select
				tbtgb.select_actions.extend (agent word_wrap_toggled (tbtgb))
				tbtgb.set_tooltip (Interface_names.l_viewer_enable_word_wrapping)
				l_tb.extend (tbtgb)
				register_word_wrap_button (tbtgb)

				create tbb.make
				tbb.set_pixmap (pixmaps.mini_pixmaps.general_copy_icon)
				tbb.set_pixel_buffer (pixmaps.mini_pixmaps.general_copy_icon_buffer)
				tbb.select_actions.extend (agent copy_button_selected)
				tbb.set_tooltip (interface_names.l_copy_text_to_clipboard)
				l_tb.extend (tbb)

				l_tb.compute_minimum_size
			end
		end

feature -- Access

	name: STRING_GENERAL
		do
			Result := interface_names.t_viewer_string_display
		end

	widget: EV_WIDGET

	position_text: EV_TEXTABLE
			-- Label to display position information if any.

	character_text: EV_TEXTABLE
			-- Label to display current character information if any.

	slices_box: EV_WIDGET
			-- Slices box

	lower_slice_field,
	upper_slice_field: EV_TEXT_FIELD

	editor: EV_RICH_TEXT

feature -- Change

	set_slices_text (a_lower, a_upper: INTEGER)
		require
			slices_box_attached: slices_box /= Void
		do
			lower_slice_field.set_text (a_lower.out)
			upper_slice_field.set_text (a_upper.out)
			set_limits (a_lower, a_upper)
		end

feature {NONE} -- Implementation

	word_wrap_buttons: ARRAYED_LIST [SD_TOOL_BAR_TOGGLE_BUTTON]
			-- list of word wrap button
			--| to update all of them when needed


	update_word_wrap_buttons (a_selected: BOOLEAN)
			-- Update all word wrap button to `a_selected' state
		do
			if attached word_wrap_buttons as lst and then lst.count > 1 then
				from
					lst.start
				until
					lst.after
				loop
					if attached {SD_TOOL_BAR_TOGGLE_BUTTON} lst.item as bt then
						bt.select_actions.block
						if a_selected then
							bt.enable_select
						else
							bt.disable_select
						end
						bt.select_actions.resume
					end
					lst.forth
				end
			end
		end

	register_word_wrap_button (but: SD_TOOL_BAR_TOGGLE_BUTTON)
			-- Register word wrap button `but'
		local
			lst: like word_wrap_buttons
		do
			lst := word_wrap_buttons
			if lst = Void then
				create lst.make (2)
				word_wrap_buttons := lst
			end
			lst.extend (but)
		end

	Text_format: EV_CHARACTER_FORMAT
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			Result.set_font (Preferences.editor_data.font)
		end

	Escape_format: EV_CHARACTER_FORMAT
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 210, 96))
			Result.set_font (Preferences.editor_data.font)
		end

	Limits_format: EV_CHARACTER_FORMAT
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			Result.set_font (Preferences.editor_data.font)
		end

	No_text_background_color: EV_COLOR
		do
			Result := Preferences.debug_tool_data.expanded_display_bgcolor
		end

feature -- Slice limits

	set_limits (a_lower, a_upper: INTEGER)
			-- Change limits to `a_lower, a_upper' values.
		local
			nmin, nmax: INTEGER
		do
			nmin := a_lower
			nmax := a_upper

			nmin := nmin.max (0)
			nmax := nmax.max (nmin)

			slice_min_ref.set_item (nmin)
			slice_max_ref.set_item (nmax)
		end

	slice_min: INTEGER
		do
			Result := slice_min_ref.item
		end

	slice_max: INTEGER
		do
			Result := slice_max_ref.item
		end

	slice_min_ref: INTEGER_REF
	slice_max_ref: INTEGER_REF

feature -- Access

	is_valid_stone (a_stone: ANY; is_strict: BOOLEAN): BOOLEAN
			-- Is `st' valid stone for Current?
		do
			Result := attached {OBJECT_STONE} a_stone as st and then
				debugger_manager.dump_value_factory.new_object_value (st.object_address, st.dynamic_class, 0).has_formatted_output
				-- CHECKME: use 0 for scp_pid since we don't really care about the scoop pid here.
		end

feature -- Change

	refresh
			-- Recompute the displayed text.
		local
			l_trunc_str: STRING_32
			l_real_str_length: INTEGER
			l_length_str: STRING_32
			l_endpos: INTEGER
			n: INTEGER
			lst: like escaped_characters_positions
		do
			editor.remove_text
			editor.enable_edit
			if
				Debugger_manager.application_is_executing
				and then Debugger_manager.application_is_stopped
			then
				if has_object then
					retrieve_dump_value
					if current_dump_value /= Void then
						l_trunc_str := current_dump_value.formatted_truncated_string_representation (slice_min, slice_max)
--						format_string_for_unicode_output (l_trunc_str)
						search_for_escaped_characters (l_trunc_str)
						lst := escaped_characters_positions
						if lst /= Void then
							n := lst.count
						else
							n := 0
						end
						set_slices_text (slice_min, slice_min + l_trunc_str.count - n - 1)

						l_endpos := l_trunc_str.count + 1
						editor.set_text (l_trunc_str)
						editor.format_region (1, l_endpos, Text_format)

						l_real_str_length := current_dump_value.last_string_representation_length
						if slice_min > 0 then
							editor.prepend_text (lower_slice_marker)
							editor.format_region (1, 1 + lower_slice_marker.count, Limits_format)
							l_endpos := l_endpos + lower_slice_marker.count
						end
						if slice_max >= 0 and then (slice_max + 1 < l_real_str_length) then
							editor.append_text (upper_slice_marker)
							l_endpos := l_endpos + upper_slice_marker.count
							editor.format_region (l_endpos - upper_slice_marker.count, l_endpos, Limits_format)
						else
--							editor.format_region (l_endpos, l_endpos, Limits_format)
							debug ("refactor_fixme")
								fixme ("this violate assertion, but this is due to a vision2 issue of trailing %%U")
							end
						end

						if lst /= Void then
							across
								lst as ic
							loop
								editor.format_region (ic.item, ic.item + 2, Escape_format)
							end
						end

						editor.set_background_color (No_text_background_color)
						l_length_str := Interface_names.l_viewer_string_display_full_string_length (l_real_str_length)
						set_title (l_length_str)
						upper_slice_field.set_tooltip (l_length_str)
					else
						prompts.show_error_prompt (Interface_names.l_dbg_unable_to_get_value_message, parent_window (widget), Void)
					end
				end
			end
			editor.disable_edit
			viewers_manager.refresh_current_viewer
		end

	destroy
			-- Destroy Current
		do
			reset
			if attached widget as w then
				w.destroy
				widget := Void
			end
		end

feature {NONE} -- Implementation: escaped character in the formatted content.

	escaped_characters_positions: detachable ARRAYED_LIST [INTEGER]

	search_for_escaped_characters (s: READABLE_STRING_GENERAL)
		local
			lst: like escaped_characters_positions
			i: INTEGER
		do
			lst := escaped_characters_positions
			if lst /= Void then
				lst.wipe_out
			end
			from
				i := 1
			until
				i > s.count
			loop
				inspect s[i]
				when '%%' then
					if lst = Void then
						create lst.make (1)
					end
					lst.extend (i)
					i := i + 1
				else
				end
				i := i + 1
			end
			escaped_characters_positions := lst
		end

	extra_escape_characters_count_until (pos: INTEGER): INTEGER
		do
			if attached escaped_characters_positions as lst then
				across
					lst as ic
				until
					ic.item >= pos
				loop
					Result := Result + 1
				end
			end
		end

feature {NONE} -- Implementation

	lower_slice_marker: STRING_32
		once
			Result := {STRING_32} "%/8230/"
		end

	upper_slice_marker: STRING_32
		once
			Result := {STRING_32} "%/8230/"
		end

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

	parent_window (a_widget: detachable EV_WIDGET): detachable EV_WINDOW
			-- Locates parent window of `a_widget', if the widget has been parented.
			--
			-- `a_widget': A widget to locate a top level window for.
		local
			l_parent: detachable EV_WIDGET
		do
			if a_widget /= Void and then not a_widget.is_destroyed then
					-- Perform a loop rather than recursion that is much slower.
				from
					l_parent := a_widget
				until
					l_parent = Void or else Result /= Void
				loop
					if attached {EV_WINDOW} l_parent as l_window then
						Result := l_window
					else
							-- Go one level up
						l_parent := l_parent.parent
					end
				end
			end
		end

	clear
			-- Clean current data, useless if dialog closed or destroyed
		do
			editor.remove_text
			if lower_slice_field /= Void then
				lower_slice_field.remove_text
			end
			if upper_slice_field /= Void then
				upper_slice_field.remove_text
			end
		end

	text: TEXT_FORMATTER
			-- Text that is displayed in the editor.

feature {NONE} -- Event handling

	return_pressed_in_lower_slice_field
			-- Called by `return_actions' of `lower_slice_field'.
		do
			upper_slice_field.set_focus
		end

	return_pressed_in_upper_slice_field
			-- Called by `return_actions' of `lower_slice_field'.
		do
			set_slice_selected
		end

	on_caret_moved (pos: INTEGER)
		local
			idx, n: INTEGER
			txt: READABLE_STRING_32
			s,hex: STRING_32
			c: CHARACTER_32
			l_is_escaped: BOOLEAN
			l_is_out_of_range: BOOLEAN
			l_pos_text: like position_text
			l_char_text: like character_text
		do
			txt := editor.text
			idx := slice_min + pos - extra_escape_characters_count_until (pos)
			if slice_min > 0 then
				n := lower_slice_marker.count
				l_is_out_of_range := pos <= lower_slice_marker.count
				idx := idx - n
			end
			if not l_is_out_of_range then
				l_is_out_of_range := pos > slice_max - slice_min + 1 + n
			end
			l_pos_text := position_text
			l_char_text := character_text
			if l_is_out_of_range then
				if l_pos_text /= Void then
					l_pos_text.remove_text
				end
				if l_char_text /= Void then
					l_char_text.remove_text
				end
			else
				if l_pos_text /= Void then
					l_pos_text.set_text (idx.out)
				end
				if
					txt.valid_index (pos)
				then
					c := txt[pos]
					if pos > 1 and then txt[pos - 1] = '%%' then
						l_is_escaped := True
					end
					if c = '%%' and not l_is_escaped then
						if txt.valid_index (pos + 1) then
							c := txt[pos + 1]
							l_is_escaped := True
						end
					end
					if l_is_escaped then
						inspect c
						when 'R' then
							c := '%R'
						when 'U' then
							c := '%U'
						when '%%' then
							c := '%%'
						else
						end
					end
					create s.make_from_string ("U+")
					hex := c.natural_32_code.to_hex_string
					from until hex.count <= 4 or hex[1] /= '0' loop
						hex.remove_head (1)
					end
					s.append (hex)
					s.append_string_general (" %%/")
					s.append_natural_32 (c.natural_32_code)
					s.append ("/")
					if not c.is_control then
						s.append_string_general (" '")
						inspect
							c
						when '%T' then
							s.append_string_general ("%%T")
						when '%N' then
							s.append_string_general ("%%N")
						else
							s.append_character (c)
						end
						s.append_string_general ("'")
					end
					if l_char_text /= Void then
						l_char_text.set_text (s)
					end
				else
					if l_char_text /= Void then
						l_char_text.remove_text
					end
				end
			end
		end

	set_slice_selected
			-- Called by `select_actions' of `set_slice_button'.
		local
			l_lower, l_upper: INTEGER
			valid: BOOLEAN
		do
			valid := True
			if lower_slice_field.text.is_integer then
				l_lower := lower_slice_field.text.to_integer
			else
				prompts.show_error_prompt (warning_messages.w_not_an_integer, Void, Void)
				valid := False
				if lower_slice_field.text_length /= 0 then
					lower_slice_field.select_all
				end
				lower_slice_field.set_focus
			end
			if upper_slice_field.text.is_integer then
				l_upper := upper_slice_field.text.to_integer
			elseif valid then
				prompts.show_error_prompt (warning_messages.w_not_an_integer, Void, Void)
				valid := False
				if upper_slice_field.text_length /= 0 then
					upper_slice_field.select_all
				end
				upper_slice_field.set_focus
			end
			if valid then
				set_limits (l_lower, l_upper)
--				if l_upper > 0 then
--					application.set_displayed_string_size (upper)
						--| FIXME JFIAT: 2004-01-30 : linking displayed_string_size between pretty and object browser ??
						--| do we really want this to be set ?
						--| prob is the size for the pretty print dialog and
						--| the size of the displayed string in object browser are linked ...			
--				end
				refresh
			end
		end

	auto_slice_selected
			-- Called by `select_actions' of `auto_set_slice_button'.
		do
			if has_object then
				upper_slice_field.set_text ((-1).out)
				slice_max_ref.set_item (-1)
				refresh
				set_limits (slice_min, current_dump_value.last_string_representation_length - 1)
				upper_slice_field.set_text (slice_max.out)
			end
		end

	word_wrap_toggled (but: SD_TOOL_BAR_TOGGLE_BUTTON)
			-- Called by `select_actions' of `but'.
		local
			a_word_wrapping_enabled: BOOLEAN
		do
			if but.is_selected then
				editor.enable_word_wrapping
				a_word_wrapping_enabled := True
			else
				editor.disable_word_wrapping
			end
			update_word_wrap_buttons (a_word_wrapping_enabled)
		end

	copy_button_selected
			-- Called by `select_actions' of `copy_button'.
		do
			Ev_application.clipboard.set_text (editor.text)
		end

	on_stone_dropped (st: OBJECT_STONE)
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

	close_action
			-- Close dialog
		do
			destroy
		end

--feature -- Display

--	format_string_for_unicode_output (s32: STRING_32)
--		local
--			i: INTEGER
--		do
--			from
--				i := 1
--			until
--				i > s32.count
--			loop
--				inspect s32[i]
----				when '%U' then
----					s32.put ('U', i)
----					s32.insert_character ('%%', i)
----					i := i + 2
--				when '%R' then
--					s32.put ('%/9229/', i) -- U+240D   CR symbol replacement.
--					i := i + 1
----				when '%%' then
----					if i + 1 <= s32.count and then s32.item (i + 1) = 'R' then
----						s32.insert_character ('%%', i)
----						i := i + 1
----					end
----					i := i + 1
--				else
--					i := i + 1
--				end
--			end
--		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

