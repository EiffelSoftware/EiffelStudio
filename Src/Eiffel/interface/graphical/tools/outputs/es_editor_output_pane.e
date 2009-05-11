note
	description: "[
		A simple editor output pane for use with the Outputs tool ({ES_OUTPUTS_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_OUTPUT_PANE

inherit
	ES_OUTPUT_PANE [ES_EDITOR_WIDGET]
		rename
			make as make_output_pane
		redefine
			clear,
			on_locked,
			on_unlocked
		end

create
	make,
	make_with_icon

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
			-- Initialize a output editor
			--
			-- `a_name': A friendly, human readable name for the editor.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			make_with_icon (a_name, stock_pixmaps.tool_output_icon_buffer)
		ensure
			name_set: a_name.as_string_32 ~ name.as_string_32
		end

	make_with_icon (a_name: READABLE_STRING_GENERAL; a_icon: like icon)
			-- Initialize a output editor with an representation icon
			--
			-- `a_name': A friendly, human readable name for the editor.
			-- `a_icon': An icon representing the output pane.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_icon_attached: a_icon /= Void
		do
			make_output_pane
			create name.make_from_string (a_name.as_string_32)
			icon := a_icon
			is_auto_scrolled := True
		ensure
			name_set: a_name.as_string_32 ~ name.as_string_32
			icon_set: icon ~ a_icon
		end

	build_interface (a_widget: attached ES_EDITOR_WIDGET)
			-- <Precursor>
		local
			l_redirector: ES_TOOL_STONE_REDIRECT_HELPER
		do
			a_widget.editor.disable_line_numbers
			a_widget.editor.disable_editable
			a_widget.editor.disable_has_breakable_slots
			a_widget.editor.set_read_only (True)
			a_widget.editor.set_focus

				-- Set up a redirection for all dropped stones so they are forwarded to the correct
				-- default tool.
			create l_redirector.make (a_widget.editor.dev_window)
			l_redirector.bind (a_widget.editor.editor_drawing_area, Current)
			auto_recycle (l_redirector)

				-- Recieve notifications when a new line has been added to the output. This ensures the output
				-- is always scrolled to the end.
			register_action (new_line_actions, agent (ia_sender: ES_NOTIFIER_OUTPUT_WINDOW; ia_lines: NATURAL)
					-- Need to scroll the output
				local
					l_cursor: DS_HASH_TABLE_CURSOR [ES_EDITOR_WIDGET, NATURAL_32]
				do
					if is_auto_scrolled then
						if attached widget_table as l_table then
							l_cursor := l_table.new_cursor
							from l_cursor.start until l_cursor.after loop
								if attached l_cursor.item as l_widget then
									l_widget.scroll_editor_to_end (True)
								end
								l_cursor.forth
							end
						end
					end
				end)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if not is_recycled and not is_recycling then
					recycle
				end
			end
		ensure then
			is_recycled: (a_explicit and not is_recycling) implies is_recycled
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>

	name: IMMUTABLE_STRING_32
			-- <Precursor>

feature -- Status report

	is_searchable: BOOLEAN = True
			-- <Precursor>

	is_auto_scrolled: BOOLEAN assign set_is_auto_scrolled
			-- <Precursor>

feature -- Status setting

	set_is_auto_scrolled (a_auto: BOOLEAN)
			-- <Precursor>
		do
			is_auto_scrolled := a_auto
		end

feature -- Query

	text_from_window (a_window: SHELL_WINDOW_I): STRING_32
			-- <Precursor>
		local
			l_widget: like widget_from_window
		do
			l_widget := widget_from_window (a_window)
			if l_widget.is_interface_usable and then l_widget.is_initialized then
				create Result.make_from_string (l_widget.text)
			else
				create Result.make_empty
			end
		end

	formatter_from_window (a_window: SHELL_WINDOW_I): TEXT_FORMATTER
			-- <Precursor>
		local
			l_widget: ES_EDITOR_WIDGET
		do
			l_widget := widget_table.item (a_window.window_id)
			check l_widget_attached: l_widget /= Void end
			Result := formatter_from_widget (l_widget)
		end

feature {NONE} -- Query

	formatter_from_widget (a_widget: ES_EDITOR_WIDGET): TEXT_FORMATTER
			-- <Precursor>
		local
			l_result: detachable TEXT_FORMATTER
		do
			l_result := a_widget.editor.text_displayed
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature -- Basic operations

	clear
			-- <Precursor>
		local
			l_cursor: DS_HASH_TABLE_CURSOR [ES_EDITOR_WIDGET, NATURAL_32]
		do
			Precursor
			if attached widget_table as l_table then
				l_cursor := l_table.new_cursor
				from l_cursor.start until l_cursor.after loop
					if attached l_cursor.item as l_widget then
						l_widget.clear
					end
					l_cursor.forth
				end
			end
		end

	clear_window (a_window: SHELL_WINDOW_I)
			-- <Precursor>
		local
			l_widget: like widget_from_window
		do
			l_widget := widget_from_window (a_window)
			if l_widget.is_interface_usable then
				l_widget.clear
			end
		end

	search_window (a_window: SHELL_WINDOW_I)
			-- <Precursor>
		local
			l_widget: like widget_from_window
			l_editor: EB_CLICKABLE_EDITOR
		do
			l_widget := widget_from_window (a_window)
			if l_widget.is_interface_usable then
				l_editor := l_widget.editor
				if l_editor.is_interface_usable then
					l_editor.quick_search
				end
			end
		end

feature {NONE} -- Event handlers

	on_locked
			-- <Precursor>
		local
			l_cursor: DS_HASH_TABLE_CURSOR [ES_EDITOR_WIDGET, NATURAL_32]
		do
			Precursor
			if attached widget_table as l_table then
				l_cursor := l_table.new_cursor
				from l_cursor.start until l_cursor.after loop
					if attached l_cursor.item as l_widget then
						l_widget.editor.handle_before_processing (False)
					end
					l_cursor.forth
				end
			end
		end

	on_unlocked
			-- <Precursor>
		local
			l_cursor: DS_HASH_TABLE_CURSOR [ES_EDITOR_WIDGET, NATURAL_32]
		do
			Precursor
			if attached widget_table as l_table then
				l_cursor := l_table.new_cursor
				from l_cursor.start until l_cursor.after loop
					if attached l_cursor.item as l_widget then
						l_widget.editor.handle_after_processing
					end
					l_cursor.forth
				end
			end
		end

feature {NONE} -- Factory

	new_widget (a_window: SHELL_WINDOW_I): ES_EDITOR_WIDGET
			-- <Precursor>
		do
			if attached {EB_DEVELOPMENT_WINDOW} a_window as l_window then
				create {ES_EDITOR_WIDGET} Result.make (l_window)
			else
				check False end
			end
		end

invariant
	icon_attached: icon /= Void
	name_attached: name /= Void
	not_name_is_empty: not name.is_empty

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
