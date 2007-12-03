indexing
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
		redefine
			build_tool_interface,
			row_item_text,
			internal_recycle
		end

feature {NONE} -- Initialization

	build_tool_interface (a_widget: ES_GRID)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		do
			grid_token_support.synchronize_color_or_font_change_with_editor
			grid_token_support.enable_grid_item_pnd_support
			grid_token_support.enable_ctrl_right_click_to_open_new_window
			grid_token_support.set_context_menu_factory_function (agent (develop_window.menus).context_menu_factory)
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Recycle tool.
		do
			if is_initialized then
				grid_token_support.desynchronize_color_or_font_change_with_editor
			end
			internal_grid_token_support := Void
			Precursor {ES_EVENT_LIST_TOOL_PANEL_BASE}
		ensure then
			internal_grid_token_support_detached: internal_grid_token_support = Void
		end

feature {NONE} -- Access

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

	token_generator: EB_EDITOR_TOKEN_GENERATOR
			-- An editor token generator for generating editor token on grid items
		once
			Result := (create {EB_SHARED_WRITER}).token_writer
		end

feature {NONE} -- Query

	row_item_text (a_item: EV_GRID_ITEM): STRING_32
			-- Extracts a string representation of a grid row's cell item.
			--
			-- `a_item': Grid item to retrieve string representation for.
			-- `Result': A string representation of the item or Void if not string representation could be created.
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_editor_item ?= a_item
			if l_editor_item /= Void then
				Result := l_editor_item.text
			else
				Result := Precursor {ES_EVENT_LIST_TOOL_PANEL_BASE} (a_item)
			end
		end

feature {NONE} -- Factory

	create_clickable_grid_item (a_line: EIFFEL_EDITOR_LINE): EB_GRID_EDITOR_TOKEN_ITEM
			-- Create a new grid item to host the context of `a_lines'.
			--
			-- `a_line': The editor line containing tokens to render on the resulting grid item.
			-- `Result': A grid item with the tokens set.
		require
			a_line_attached: a_line /= Void
		local
			l_lines: ARRAYED_LIST [EIFFEL_EDITOR_LINE]
		do
			create l_lines.make (1)
			l_lines.extend (a_line)
			Result := create_multiline_clickable_grid_item (l_lines, False)
		ensure
			result_attached: Result /= Void
		end

	create_multiline_clickable_grid_item (a_lines: LIST [EIFFEL_EDITOR_LINE]; a_use_text_wrapping: BOOLEAN): EB_GRID_EDITOR_TOKEN_ITEM
			-- Create a new grid item to host the context of `a_lines'.
			--
			-- `a_lines': The editor lines containing tokens to render on the resulting grid item.
			-- `Result': A grid item with the tokens set.
		require
			a_lines_attached: a_lines /= Void
		local
			l_tokens: like tokens_list_from_lines
			l_shared_writer: EB_SHARED_WRITER
		do
			create Result
			Result.set_text_wrap (a_use_text_wrapping)
			l_tokens := tokens_list_from_lines (a_lines)
			if not l_tokens.is_empty then
				create l_shared_writer
				Result.set_left_border (4)
				Result.set_text_with_tokens (tokens_list_from_lines (a_lines))
				Result.set_overriden_fonts (l_shared_writer.label_font_table, l_shared_writer.label_font_height)
			end
		ensure
			result_attached: Result /= Void
		end

	create_clickable_tooltip (a_lines: LIST [EIFFEL_EDITOR_LINE]; a_item: EV_GRID_ITEM; a_row: EV_GRID_ROW): EB_EDITOR_TOKEN_TOOLTIP is
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
			a_item_data_unattached_or_is_tool_tip: a_item.data = Void or else (({EB_EDITOR_TOKEN_TOOLTIP}) #? a_item.data) /= Void
		local
			l_tokens: like tokens_list_from_lines
			l_select_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			Result ?= a_item.data
			if Result = Void then
				if grid_events.is_single_item_selection_enabled or grid_events.is_multiple_row_selection_enabled then
					l_select_actions := a_item.row.select_actions
				else
					l_select_actions := a_item.select_actions
				end
				create Result.make (a_item.pointer_enter_actions, a_item.pointer_leave_actions, l_select_actions, agent a_item.is_destroyed)
				Result.enable_pointer_on_tooltip
				a_item.set_data (Result)
			end

			l_tokens := tokens_list_from_lines (a_lines)
			Result.set_tooltip_text (l_tokens)
			if not l_tokens.is_empty then
				Result.enable_tooltip
			else
				Result.disable_tooltip
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Basic operations

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
			create Result.make (20)
			l_cursor := a_lines.cursor
			from a_lines.start until a_lines.after loop
				if not l_start then
					l_start := a_lines.item.count > 0
				end
				if l_start then
						-- Ensures no blank lines at the beginning of the text
					Result.append (a_lines.item.content)
					if not a_lines.islast then
						Result.extend (create {EDITOR_TOKEN_EOL}.make)
					end
				end
				a_lines.forth
			end
			a_lines.go_to (l_cursor)

			if not Result.is_empty then
					-- Ensures no blank lines at the end of the text
				l_eol ?= Result.last
				from Result.finish until Result.before or l_eol = Void loop
					l_eol ?= Result.item
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

feature {NONE} -- Internal implementation cache

	internal_grid_token_support: like grid_token_support
			-- Cached version of `grid_token_support'
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
