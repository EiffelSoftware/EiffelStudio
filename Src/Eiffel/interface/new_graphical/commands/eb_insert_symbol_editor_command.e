note
	description: "Insert symbol in editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_INSERT_SYMBOL_EDITOR_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			executable,
			tooltext,
			mini_pixmap,
			mini_pixel_buffer
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		undefine
			internal_detach_entities
		redefine
			make,
			executable,
			internal_recycle
		end

	EB_EDITOR_COMMAND
		rename
			make as make_editor
		redefine
			internal_recycle,
			executable,
			mini_pixmap,
			mini_pixel_buffer,
			tooltext
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EVS_HELPERS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_target: like target)
			-- Initialization
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND} (a_target)
			make_editor
			name := "Editor_insert_symbol"
			description := Interface_names.e_Insert_symbol
			tooltext := interface_names.b_insert_symbol
			tooltip := interface_names.f_insert_symbol
			menu_name := interface_names.m_insert_symbol

--			pixel_buffer := pixmaps.icon_pixmaps.general_paste_icon_buffer -- TODO
--			pixmap := pixmaps.icon_pixmaps.general_paste_icon -- TODO

			add_agent (agent execute_command)
			set_needs_editable (True)

			l_shortcut := preferences.editor_data.shortcuts.item ("insert_symbol")
			if l_shortcut /= Void then
				create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
				accelerator.actions.extend (agent execute)
				set_referred_shortcut (l_shortcut)
			end
			enable_sensitive
		end

feature -- Execution

	execute_insert_symbol
			-- Execute the command.
		local
			l_dialog: EB_INSERT_SYMBOL_DIALOG
		do
			if
				attached target.editors_manager.current_editor as ed and then
				target.widget_has_recursive_focus (ed.widget)
			then
				l_dialog := internal_dialog
				if l_dialog = Void then
					create l_dialog.make (ed)
					l_dialog.set_size (target.scaled_size (300) , target.scaled_size (300))
					internal_dialog := l_dialog
				else
					l_dialog.update_editor (ed)
				end
				l_dialog.show_modal_to_window (target.window)
			end
		end

feature {NONE} -- Implementation

	internal_dialog: detachable EB_INSERT_SYMBOL_DIALOG

feature -- Status report

	executable: BOOLEAN
			-- Is the operation possible?
		do
			Result := is_sensitive
		end

feature -- Access

	mini_pixmap: EV_PIXMAP
			-- <Precursor>

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- <Precursor>

	tooltext: STRING_GENERAL
			-- <Precursor>

feature {NONE} -- Implementation

	execute_command
		local
			l_editor: like editor
		do
			l_editor := editor
			if l_editor /= Void and then not l_editor.is_recycled and then l_editor.number_of_lines /= 0 then
				l_editor.run_if_editable (agent execute_insert_symbol)
			end
		end

	editor: EB_EDITOR
			-- Editor corresponding to Current
		do
			Result := target.ui.current_editor
		end

	internal_recycle
			-- Internal recycle
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}
			Precursor {EB_EDITOR_COMMAND}
		end

feature {NONE} -- Implementation

	on_changed
			-- The undo/redo stack has changed.
		local
			sensitive: BOOLEAN
			operation_possible: BOOLEAN
		do
			sensitive := is_sensitive
			operation_possible := executable

			if sensitive and not operation_possible then
				disable_sensitive
			elseif not sensitive and operation_possible then
				enable_sensitive
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
