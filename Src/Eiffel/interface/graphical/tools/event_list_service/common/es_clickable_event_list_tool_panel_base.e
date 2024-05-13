note
	description: "[
		A specialized event list service-based {EVENT_LIST_SERVICE_I} tool that support clickable items and tools tips.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE

inherit
	ES_EVENT_LIST_TOOL_PANEL_BASE
		rename
			show_context_menu as request_show_context_menu
		redefine
			row_item_text,
			request_show_context_menu,
			internal_recycle,
			internal_detach_entities
		end

feature {NONE} -- Initialization

	build_tool_interface (a_widget: ES_GRID)
			-- <Precursor>
		do
			grid_token_support.synchronize_color_or_font_change_with_editor
			grid_token_support.enable_grid_item_pnd_support
			grid_token_support.enable_ctrl_right_click_to_open_new_window
			grid_token_support.set_context_menu_factory_function (agent (develop_window.menus).context_menu_factory)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if is_initialized then
				grid_token_support.desynchronize_color_or_font_change_with_editor
			end
			Precursor {ES_EVENT_LIST_TOOL_PANEL_BASE}
		end

	internal_detach_entities
			-- <Precursor>
		do
			internal_grid_token_support := Void
			Precursor {ES_EVENT_LIST_TOOL_PANEL_BASE}
		ensure then
			internal_grid_token_support_detached: internal_grid_token_support = Void
		end

feature {NONE} -- Query

	row_item_text (a_item: EV_GRID_ITEM): STRING_32
			-- <Precursor>
		do
			if attached {EB_GRID_EDITOR_TOKEN_ITEM} a_item as l_editor_item then
				Result := l_editor_item.text
			else
				Result := Precursor {ES_EVENT_LIST_TOOL_PANEL_BASE} (a_item)
			end
		end

	tokens_list_from_lines (a_lines: LIST [EIFFEL_EDITOR_LINE]): ARRAYED_LIST [EDITOR_TOKEN]
			-- Create a list of editor tokens from lines `a_lines'
			--
			-- `a_lines': Lines to create a token list from
		require
			a_lines_attached: a_lines /= Void
			not_a_lines_is_empty: not a_lines.is_empty
		local
			l_cursor: CURSOR
			l_eol: EDITOR_TOKEN_EOL
			l_start: BOOLEAN
		do
			create Result.make (a_lines.count)
			l_cursor := a_lines.cursor
			from a_lines.start until a_lines.after loop
				if not l_start then
					l_start := a_lines.item.count > 0
				end
				if l_start then
						-- Ensures no blank lines at the beginning of the text
					Result.append (a_lines.item.content)
					if not a_lines.islast then
						Result.extend (create {EDITOR_TOKEN_EOL}.make_unix_style)
					end
				end
				a_lines.forth
			end
			a_lines.go_to (l_cursor)

			if not Result.is_empty then
					-- Ensures no blank lines at the end of the text
				l_eol := {EDITOR_TOKEN_EOL} / Result.last
				from Result.finish until Result.before or l_eol = Void loop
					l_eol := {EDITOR_TOKEN_EOL} / Result.item
					if l_eol /= Void then
						Result.remove
					end
					if not Result.before then
						Result.back
					end
				end
			end
		ensure
			result_attached: Result /= Void
			a_lines_unmoved: a_lines.cursor.is_equal (old a_lines.cursor)
		end

feature {NONE} -- Helpers

	token_generator: EB_EDITOR_TOKEN_GENERATOR
			-- An editor token generator for generating editor token on grid items
		once
			Result := (create {EB_SHARED_WRITER}).token_writer
		end

	frozen grid_token_support: EB_EDITOR_TOKEN_GRID_SUPPORT
			-- Support for using `grid_events' with editor token-based items
		do
			Result := internal_grid_token_support
			if Result = Void then
				create Result.make_with_grid (grid_events)
				internal_grid_token_support := Result
				auto_recycle (internal_grid_token_support)
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = grid_token_support
		end

feature {NONE} -- Basic operations

	frozen request_show_context_menu (a_item: EV_GRID_ITEM; a_x: INTEGER; a_y: INTEGER)
			-- <Precursor>
		do
			if attached {EB_GRID_EDITOR_TOKEN_ITEM} a_item as l_item then
				if grid_token_support.stone_at_position (a_x, a_y) = Void then
						-- Only show the menu if a pick operation was not performed.
					show_context_menu (a_item, a_x, a_y)
				end
			else
				show_context_menu (a_item, a_x, a_y)
			end
		end

	show_context_menu (a_item: EV_GRID_ITEM; a_x: INTEGER; a_y: INTEGER)
			-- Called to show a context menu at the relative X/Y coordinates to `grid_events'
			--
			-- `a_item': The grid item to display a context menu for.
			-- `a_x': The relative X position on `grid_events'.
			-- `a_t': The relative Y position on `grid_events'.
		require
			is_interface_usable: is_interface_usable
			a_item_attached: a_item /= Void
			a_item_parented: a_item.row /= Void
			a_item_parented_to_grid_events: a_item.row.parent = grid_events
			a_x_positive: a_x > 0
			a_y_positive: a_y > 0
		do
		end

feature {NONE} -- Factory

	create_clickable_grid_item (a_line: EIFFEL_EDITOR_LINE; a_allow_selection: BOOLEAN): EB_GRID_EDITOR_TOKEN_ITEM
			-- Create a new grid item to host the context of `a_lines'.
			--
			-- `a_line': The editor line containing tokens to render on the resulting grid item.
			-- `a_allow_selection': True to allow the contents to be selected; False otherwise.
			-- `Result': A grid item with the tokens set.
		require
			a_line_attached: a_line /= Void
		local
			l_lines: ARRAYED_LIST [EIFFEL_EDITOR_LINE]
		do
			create l_lines.make (1)
			l_lines.extend (a_line)
			Result := create_multiline_clickable_grid_item (l_lines, a_allow_selection, False)
		ensure
			result_attached: Result /= Void
		end

	create_multiline_clickable_grid_item (a_lines: LIST [EIFFEL_EDITOR_LINE]; a_allow_selection: BOOLEAN; a_use_text_wrapping: BOOLEAN): EB_GRID_EDITOR_TOKEN_ITEM
			-- Create a new grid item to host the context of `a_lines'.
			-- Caution: It is the responsibility of the caller to call `try_call_setting_change_actions' when Result has been fully initialized.
			--
			-- `a_lines': The editor lines containing tokens to render on the resulting grid item.
			-- `a_allow_selection': True to allow the contents to be selected; False otherwise.
			-- `a_use_text_wrapping': True to perform automatic text-wrapping; False otherwise.
			-- `Result': A grid item with the tokens set.
		require
			a_lines_attached: a_lines /= Void
		local
			l_tokens: like tokens_list_from_lines
			l_shared_writer: EB_SHARED_WRITER
		do
			if a_allow_selection then
				create {EB_GRID_EDITOR_ITEM} Result
			else
				create Result
			end
				-- Lock update so that the sizing calculation only occurs once everything has been set.
			Result.lock_update

			Result.set_text_wrap (a_use_text_wrapping)
			l_tokens := tokens_list_from_lines (a_lines)
			if not l_tokens.is_empty then
				create l_shared_writer

				Result.set_left_border (4)
				Result.set_text_with_tokens (tokens_list_from_lines (a_lines))
				Result.set_overriden_fonts (l_shared_writer.label_font_table, l_shared_writer.label_font_height)
			end
			Result.unlock_update
		ensure
			result_attached: Result /= Void
		end

	create_clickable_tooltip (a_lines: FUNCTION [LIST [EIFFEL_EDITOR_LINE]]; a_item: EV_GRID_ITEM; a_row: EV_GRID_ROW): EB_EDITOR_TOKEN_TOOLTIP
			-- Creates a new clickable tool tip with the context of `a_lines' and attaches itself it `a_item'
			--
			-- Note: If `a_item' already had a tool tip created for it, no new tool tip will be created but the same
			--       one will be returned.
			--
			-- `a_lines': The editor lines containing tokens to render on the resulting tool tip.
			-- `a_item': The tool tip to attached to the item.
			-- `a_row': The row where the item is to be places
			-- `Result': A tool tip attached to `a_item'
		require
			a_lines_attached: a_lines /= Void
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.is_parented
			a_item_data_unattached_or_is_tool_tip: a_item.data = Void or else attached {EB_EDITOR_TOKEN_TOOLTIP} a_item.data
		local
			l_select_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			Result := {EB_EDITOR_TOKEN_TOOLTIP} / a_item.data
			if Result = Void then
				if grid_events.is_single_item_selection_enabled or grid_events.is_multiple_row_selection_enabled then
					l_select_actions := a_item.row.select_actions
				else
					l_select_actions := a_item.select_actions
				end
				create Result.make (a_item.pointer_enter_actions, a_item.pointer_leave_actions, l_select_actions, agent a_item.is_destroyed)
					-- The following settings do not refresh GUI.
					-- Otherwise, lock_update should be called.
				Result.enable_pointer_on_tooltip
				Result.enable_tooltip
				Result.before_display_actions.extend (agent (a_tooltip: EB_EDITOR_TOKEN_TOOLTIP; a_lines_func: FUNCTION [LIST [EIFFEL_EDITOR_LINE]])
					local
						l_tokens: like tokens_list_from_lines
					do
						l_tokens := tokens_list_from_lines (a_lines_func.item (Void))
						a_tooltip.set_tooltip_text (l_tokens)
						if not l_tokens.is_empty then
							a_tooltip.enable_tooltip
						else
							a_tooltip.disable_tooltip
						end
					end (Result, a_lines))
				a_item.set_data (Result)
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation: Internal cache

	internal_grid_token_support: like grid_token_support
			-- Cached version of `grid_token_support'
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
