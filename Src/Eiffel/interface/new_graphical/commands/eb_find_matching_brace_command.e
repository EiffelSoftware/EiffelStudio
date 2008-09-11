indexing
	description: "[
			The command used to locate a matching brace in the editor.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FIND_MATCHING_BRACE_COMMAND

inherit
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
			executable,
			internal_recycle
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target)
			-- <Precursor>
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_target)
			make_editor

			menu_name := Interface_names.m_find_matching_brace
			l_shortcut := preferences.editor_data.shortcuts.item ("find_matching_brace")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			execute_agents.extend (agent execute_command)
			set_referred_shortcut (l_shortcut)
			set_is_for_main_editors (True)
			enable_sensitive
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}
			Precursor {EB_EDITOR_COMMAND}
		end

feature {NONE} -- Access

	editor: ?EB_SMART_EDITOR
			-- Editor corresponding to Current
		do
			Result ?= target.ui.current_editor
		end

feature -- Status report

	executable: BOOLEAN
			-- Is the operation possible?
		do
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			Result := is_sensitive
		end

feature {NONE} -- Basic operations

	execute_command
			-- Execute the finding of the matching brace
		local
			l_editor: like editor
		do
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			l_editor := editor
			if l_editor /= Void and then l_editor.is_interface_usable and then not l_editor.is_empty and then l_editor.text_is_fully_loaded then
				l_editor.find_matching_brace
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
