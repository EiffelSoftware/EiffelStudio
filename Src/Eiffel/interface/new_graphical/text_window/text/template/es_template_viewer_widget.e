note
	description: "A widget for viewing the code of a particular template."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEMPLATE_VIEWER_WIDGET

inherit
	ES_WIDGET [EV_VERTICAL_BOX]

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	build_widget_interface (a_widget: attached EV_VERTICAL_BOX)
			-- Builds widget's interface.
			-- `a_widget': The widget to initialize of build upon.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT
			l_auto_show_check: attached EV_CHECK_BUTTON
			l_preference: BOOLEAN_PREFERENCE
		do
			a_widget.set_border_width (2)

			create template_grid
			template_grid.hide_header
			template_grid.set_column_count_to (1)
			template_grid.enable_auto_size_best_fit_column (1)
			template_grid.disable_row_height_fixed
			template_grid.disable_selection_on_click

			create l_grid_support.make_with_grid (template_grid)
			l_grid_support.enable_ctrl_right_click_to_open_new_window
			l_grid_support.enable_grid_item_pnd_support
			auto_recycle (l_grid_support)

			a_widget.extend (template_grid)

			create l_hbox

				-- `auto_show_check'
			l_preference := preferences.editor_data.auto_show_feature_contract_tooltips_preference
			if l_preference /= Void then
				create auto_show_check.make (l_preference)
				l_auto_show_check := auto_show_check.widget
				l_auto_show_check.set_foreground_color (preferences.editor_data.normal_text_color)
				l_hbox.extend (l_auto_show_check)
				l_hbox.disable_item_expand (l_auto_show_check)
				auto_recycle (auto_show_check)
			end
		end

feature {NONE} -- Access

	context_feature: E_FEATURE
			-- Last viewed feature.

	context_class: CLASS_C
			-- Last viewed class.

	content: STRING_32
			-- Content to display.

	maximum_widget_width: INTEGER
			-- Max widget width.

feature -- Element change

	set_content (a_content: STRING_32)
			-- Set's the content widget's view context with `a_content'.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			content := a_content
			update_context
		ensure
			content_set: content = a_content
		end

feature -- Status report

	has_content: BOOLEAN
			-- Was there any content generated?

feature -- Status setting


	set_maximum_widget_width (a_w: INTEGER)
			-- Set `maximum_widget_width' to `a_w'.
		require
			a_w_not_negative: a_w >= 0
		do
			maximum_widget_width := a_w
			if is_shown and then has_content then
				update_context
			end
		ensure
			maximum_widget_width_set: maximum_widget_width = a_w
		end

feature {NONE} -- Basic operation

	update_context
			-- Updates the contract view based on a previously set context.
			-- Note: Context can be set using `set_context'
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_grid: like template_grid
			l_row: EV_GRID_ROW
			l_height: INTEGER
			l_width: INTEGER
			l_grid_width: INTEGER
		do
				-- Clear the template grid
			l_grid := template_grid
			l_grid.lock_update
			l_grid.wipe_out


			if attached content as l_text then

				create l_editor_item
				l_grid.set_row_count_to (l_grid.row_count + 1)
				l_row := l_grid.row (l_grid.row_count)
				l_row.set_item (1, l_editor_item)
				l_row.hide

				create l_editor_item
				l_editor_item.set_text_with_tokens (template_tokens (l_text))

					-- Set row
				l_grid.set_row_count_to (l_grid.row_count + 1)

				l_row := l_grid.row (l_grid.row_count)
				l_row.set_item (1, l_editor_item)
				l_row.set_height (l_editor_item.required_height_for_text_and_component)

					-- Grid dimension adjustments
				l_height := l_height + l_row.height
				l_width := l_width.max (l_editor_item.required_width)
				has_content := True

				if maximum_widget_width > 0 then
					l_grid_width := (l_width + 20).min (maximum_widget_width)
				else
					l_grid_width := l_width + 20
				end

				l_grid.set_minimum_size (l_grid_width, l_height + 6)
				l_grid.column (1).set_width ((l_grid_width - 18).max (0))
			end
			l_grid.unlock_update
		end

feature -- User interface elements

	template_grid: attached ES_GRID
			-- The grid used to show the contracts

	template_label: attached EV_LINK_LABEL
			-- Label used to edit contracts

	auto_show_check: attached ES_CHECK_BUTTON_PREFERENCED_WIDGET
			-- Option to automatially show the view widget.


feature {NONE} -- Factory

	create_widget: attached EV_VERTICAL_BOX
			-- Creates a new widget, which will be initialized when `build_interface' is called.
		do
			create Result
		end

feature {NONE} -- Tokens

	template_tokens (a_code: STRING): LIST [EDITOR_TOKEN]
			-- Generate tokens for the given code `a_code'
			-- normalize whitespces based on the next line
			-- to the first line indentation.
		local
			l_scanner: EDITOR_EIFFEL_SCANNER
			l_token: EDITOR_TOKEN
			l_new_line: BOOLEAN
			l_first_new_line: BOOLEAN
			i: INTEGER
			l_token_space: EDITOR_TOKEN_SPACE
			l_token_tabulation: EDITOR_TOKEN_TABULATION
		do
			create {ARRAYED_LIST [EDITOR_TOKEN]}Result.make (0)
			create l_scanner.make
			from
				l_scanner.execute (a_code)
				l_token := l_scanner.first_token
				l_new_line := False
				l_first_new_line := True
			until
				l_token = Void
			loop
				if attached {EDITOR_TOKEN_EOL} l_token then
					l_new_line := True
				end
				if
					l_new_line and then
					attached {EDITOR_TOKEN_SPACE} l_token and then
					l_first_new_line
				then
					i := l_token.wide_image.count
					if attached {EDITOR_TOKEN_KEYWORD} l_token.previous.previous then
						create l_token_space.make (l_token.wide_image.count - (i - 4) )
					else
						create l_token_space.make (l_token.wide_image.count - i )
					end
					Result.force (l_token_space)
					l_new_line := False
					l_first_new_line := False
				elseif
					l_new_line and then
					attached {EDITOR_TOKEN_SPACE} l_token
				then
					l_new_line := False
					if i > l_token.wide_image.count then
						create l_token_space.make (0)
					else
						create l_token_space.make (l_token.wide_image.count - i )
					end
					Result.force (l_token_space)
				elseif
					l_new_line and then attached {EDITOR_TOKEN_TABULATION} l_token
				then
					l_new_line := False
					if l_token.length > 2 then
						create l_token_tabulation.make (l_token.length - 2)
						Result.force (l_token_tabulation)
					else
						Result.force (l_token)
					end
				else
					Result.force (l_token)
				end
				l_token := l_token.next
			end
		end

invariant
	template_grid_set: template_grid /= Void
	template_label_set: template_label /= Void

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
