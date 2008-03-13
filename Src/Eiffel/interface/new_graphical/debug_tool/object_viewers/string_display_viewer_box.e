indexing
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

	SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	build_widget is
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			l_tb: SD_TOOL_BAR
			but: SD_TOOL_BAR_BUTTON
		do
			create vb
			widget := vb
			vb.set_border_width (layout_constants.small_border_size)
			vb.set_padding_width (layout_constants.tiny_padding_size)

				--| Top slices box
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			vb.extend (hb)
			vb.disable_item_expand (hb)

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

			build_tool_bar
			hb.extend (tool_bar)

				--| Editor
			create editor
			editor.set_minimum_height (100)
			editor.set_background_color (No_text_background_color)
			editor.enable_word_wrapping
			editor.disable_edit
			editor.drop_actions.extend (agent on_stone_dropped)
			editor.drop_actions.set_veto_pebble_function (agent is_valid_stone)
			vb.extend (editor)

 			set_title (name)

			slice_min_ref := 0
			slice_max_ref := default_slice_max_value
			set_slices_text (slice_min, slice_max)

		end

	default_slice_max_value: INTEGER is
		do
			Result := preferences.debug_tool_data.default_expanded_view_size
		end

	build_tool_bar is
		local
			l_tb: like tool_bar
			tbb: SD_TOOL_BAR_BUTTON
			tbtgb: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			if tool_bar = Void then
				create l_tb.make
				tool_bar := l_tb

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

				create tbb.make
				tbb.set_pixmap (pixmaps.icon_pixmaps.general_copy_icon)
				tbb.set_pixel_buffer (pixmaps.icon_pixmaps.general_copy_icon_buffer)
				tbb.select_actions.extend (agent copy_button_selected)
				tbb.set_tooltip (interface_names.l_copy_text_to_clipboard)
				l_tb.extend (tbb)

				l_tb.compute_minimum_size
			end
		end

	build_mini_tool_bar is
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

	name: STRING_GENERAL is
		do
			Result := interface_names.t_viewer_string_display
		end

	widget: EV_WIDGET

	lower_slice_field,
	upper_slice_field: EV_TEXT_FIELD

	editor: EV_RICH_TEXT

feature -- Change

	set_slices_text (a_lower, a_upper: INTEGER) is
		do
			lower_slice_field.set_text (a_lower.out)
			upper_slice_field.set_text (a_upper.out)
		end

feature -- Implementation

	Text_format: EV_CHARACTER_FORMAT is
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			Result.set_font (Preferences.editor_data.font)
		end

	Limits_format: EV_CHARACTER_FORMAT is
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			Result.set_font (Preferences.editor_data.font)
		end

	No_text_background_color: EV_COLOR is
		do
			Result := Preferences.debug_tool_data.expanded_display_bgcolor
		end

feature -- Slice limits

	set_limits (a_lower, a_upper: INTEGER) is
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

	slice_min: INTEGER is
		do
			Result := slice_min_ref.item
		end

	slice_max: INTEGER is
		do
			Result := slice_max_ref.item
		end

	slice_min_ref: INTEGER_REF
	slice_max_ref: INTEGER_REF

feature -- Access

	is_valid_stone (a_stone: ANY; is_strict: BOOLEAN): BOOLEAN is
			-- Is `st' valid stone for Current?
		do
			Result := {st: OBJECT_STONE} a_stone and then
				debugger_manager.dump_value_factory.new_object_value (st.object_address, st.dynamic_class).has_formatted_output
		end

feature -- Change

	refresh is
			-- Recompute the displayed text.
		local
			l_trunc_str: STRING_32
			l_real_str_length: INTEGER
			l_length_str: STRING_32
			l_endpos: INTEGER
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
						lower_slice_field.set_text (slice_min.out)
						upper_slice_field.set_text ((slice_min + l_trunc_str.count - 1).out)

						l_endpos := l_trunc_str.count + 1
						editor.set_text (l_trunc_str)
						editor.format_region (1, l_endpos, Text_format)

						l_real_str_length := current_dump_value.last_string_representation_length
						if slice_min > 0 then
							editor.prepend_text ("... ")
							editor.format_region (1, 5, Limits_format)
							l_endpos := l_endpos + 4
						end
						if slice_max >= 0 and then (slice_max + 1 < l_real_str_length) then
							editor.append_text (" ...")
							l_endpos := l_endpos + 4
							editor.format_region (l_endpos - 4, l_endpos, Limits_format)
						else
--							editor.format_region (l_endpos, l_endpos, Limits_format)
							fixme ("this violate assertion, but this is due to a vision2 issue of trailing %%U")
						end
						l_trunc_str := editor.text

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

	destroy is
			-- Destroy Current
		do
			reset
			if widget /= Void then
				widget.destroy
				widget := Void
			end
		end

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
		do
			Result := True
		end

	parent_window (w: EV_WIDGET): EV_WINDOW is
		local
			p: EV_WIDGET
		do
			p := w.parent
			if p /= Void then
				Result ?= p
				if Result = Void then
					Result := parent_window (p)
				end
			end
		end

	clear is
			-- Clean current data, useless if dialog closed or destroyed
		do
			editor.remove_text
			lower_slice_field.remove_text
			upper_slice_field.remove_text
		end

	text: TEXT_FORMATTER
			-- Text that is displayed in the editor.

feature {NONE} -- Event handling

	return_pressed_in_lower_slice_field is
			-- Called by `return_actions' of `lower_slice_field'.
		do
			upper_slice_field.set_focus
		end

	return_pressed_in_upper_slice_field is
			-- Called by `return_actions' of `lower_slice_field'.
		do
			set_slice_selected
		end

	set_slice_selected is
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

	auto_slice_selected is
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

	word_wrap_toggled (but: SD_TOOL_BAR_TOGGLE_BUTTON) is
			-- Called by `select_actions' of `but'.
		do
			if but.is_selected then
				editor.enable_word_wrapping
			else
				editor.disable_word_wrapping
			end
		end

--	word_wrap_buttons: LIST [EV_TOOL_BAR_TOGGLE_BUTTON]

	copy_button_selected is
			-- Called by `select_actions' of `copy_button'.
		do
			Ev_application.clipboard.set_text (editor.text)
		end

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

	close_action is
			-- Close dialog
		do
			destroy
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

