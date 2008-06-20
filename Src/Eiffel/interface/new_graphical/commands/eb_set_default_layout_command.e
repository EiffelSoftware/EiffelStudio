indexing
	description	: "Command to set default docking layout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SET_DEFAULT_LAYOUT_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as develop_window
		redefine
			make
		end

	EB_CONSTANTS

	EB_SHARED_DEBUGGER_MANAGER

-- inherit {NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initlization

	make (a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_develop_window)
			enable_sensitive
		end

feature -- Command

	execute is
			-- Set current layout as default docking layout
		local
			l_graphical_debugger: EB_DEBUGGER_MANAGER
			l_fn: FILE_NAME
		do
			l_graphical_debugger ?= debugger_manager
			if l_graphical_debugger /= Void then
				if not l_graphical_debugger.raised then
					l_fn := eiffel_layout.user_docking_standard_file_name (develop_window.window_id)
				else
					l_fn := eiffel_layout.user_docking_debug_file_name (develop_window.window_id)
				end
				develop_window.docking_manager.save_tools_config (l_fn)
			end
		end

	execute_if_not_setted is
			-- Save default debug layout file if the file not exists.
		local
			l_graphical_debugger: EB_DEBUGGER_MANAGER
			l_file: RAW_FILE
			l_fn: STRING_8
		do
			l_graphical_debugger ?= debugger_manager
			if l_graphical_debugger /= Void then
				if l_graphical_debugger.raised then
					l_fn := eiffel_layout.user_docking_standard_file_name (develop_window.window_id)
					create l_file.make (l_fn)
					if not l_file.exists then
						execute
					end
				end
			end
		end

feature -- Query

	menu_name: STRING_GENERAL is
			-- Menu name
		do
			Result := interface_names.m_set_default_layout
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

end -- class EB_SET_DEFAULT_LAYOUT_COMMAND
