note
	description: "[
		An ESF widget hosting an editor and optional tool bar.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_WIDGET

inherit
	ES_TOOL_BAR_WIDGET [EV_WIDGET]
		redefine
			internal_detach_entities,
			is_tool_bar_separated
		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	build_tool_bar_widget_interface (a_widget: attached EV_WIDGET)
			-- <Precursor>
		local
			l_editor: like editor
		do
			l_editor := editor
			check l_editor_attached: l_editor /= Void end
			build_editor_interface (l_editor)
		end

	build_editor_interface (a_editor: attached like editor)
			-- Build the editor's interface
		require
			a_editor_is_interface_usable: a_editor.is_interface_usable
		do
			a_editor.disable_editable
			a_editor.disable_line_numbers
			a_editor.disable_has_breakable_slots
			a_editor.set_auto_scroll (True)

				-- Fake processing, to ensure the scroll to end works correctly
			a_editor.handle_before_processing (False)
			a_editor.handle_after_processing
		end

feature {NONE} -- Clean up

	internal_detach_entities
			-- <Precursor>
		do
			Precursor

			internal_editor := Void
		ensure then
			internal_editor_detached: internal_editor = Void
		end

feature -- Access

	text: STRING_32
			-- Editor text
		do
			Result := editor.wide_text
		ensure
			result_attached: Result /= Void
		end

	editor: attached EB_CLICKABLE_EDITOR
			-- Actual editor
		local
			l_result: like internal_editor
		do
			l_result := internal_editor
			if l_result = Void then
				Result := new_editor
				auto_recycle (Result)
				internal_editor := Result
			else
				Result := l_result
			end
		ensure
			result_is_consistent: Result = editor
		end

feature {NONE} -- Status report

	is_tool_bar_separated: BOOLEAN = True
			-- <Precursor>

feature -- Basic operations

	clear
			-- Clears the editor.
		require
			is_interface_usable: is_interface_usable
		do
			editor.clear_window
		ensure
			editor_is_empty: editor.is_empty
		end

	scroll_editor_to_end (a_force: BOOLEAN)
			-- Scrolls the editor to the end, if the caret is placed at the end of the text.
			--
			-- `a_force': True to force the editor to scroll regardless of the caret position.
		require
			is_interface_usable: is_interface_usable
		local
			l_editor: like editor
			l_text: CLICKABLE_TEXT
		do
			l_editor := editor
			if l_editor.is_interface_usable then
				if (attached l_editor.text_displayed as l_text_displayed) and then l_text_displayed.cursor /= Void then
					l_text := l_editor.text_displayed
					if a_force or else l_text.last_line = l_text.current_line then
						l_editor.scroll_to_end_when_ready
					end
				elseif a_force then
					l_editor.scroll_to_end_when_ready
				end
			end
		end

feature {NONE} -- Factory

	new_editor: attached EB_CLICKABLE_EDITOR
			-- Creates a new editor
		require
			is_interface_usable: is_interface_usable
			is_initializing: is_initializing
		do
			create Result.make (develop_window)
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

	new_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
		end

	frozen new_widget: attached EV_WIDGET
			-- <Precursor>
		do
			Result := editor.widget.as_attached
		ensure then
			editor_attached: editor /= Void
		end

feature {NONE} -- Implementation: Internal cache

	internal_editor: detachable like editor
			-- Cached version of `editor'.
			-- Note: Do not use directly!

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
