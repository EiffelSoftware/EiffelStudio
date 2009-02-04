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

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	build_tool_bar_widget_interface (a_widget: !EV_WIDGET)
			-- <Precursor>
		local
			l_editor: like editor
		do
			l_editor := editor
			check l_editor_attached: l_editor /= Void end
			build_editor_interface (l_editor)
		end

	build_editor_interface (a_editor: !like editor)
			-- Build the editor's interface
		require
			a_editor_is_interface_usable: a_editor.is_interface_usable
		do
			a_editor.disable_editable
			a_editor.disable_line_numbers
			a_editor.disable_has_breakable_slots
		end

feature -- Access

	editor: ?EB_CLICKABLE_EDITOR
			-- Editor

feature {NONE} -- Factory

	frozen create_widget: !EV_WIDGET
			-- <Precursor>
		do
			editor := create_editor
			Result := editor.widget.as_attached
		ensure then
			editor_attached: editor /= Void
		end

	create_editor: !EB_CLICKABLE_EDITOR
			-- Creates a new editor
		require
			is_interface_usable: is_interface_usable
			is_initializing: is_initializing
		do
			create Result.make (develop_window)
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

	create_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
		end

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
