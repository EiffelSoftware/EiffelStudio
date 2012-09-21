note
	description	: "Command to perform C compilation of the system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_C_COMPILATION_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND

	EB_MENUABLE_COMMAND

	SHARED_EIFFEL_PROJECT

	EB_SHARED_WINDOW_MANAGER

	PROJECT_CONTEXT

	SYSTEM_CONSTANTS

create
	make_workbench,
	make_finalized

feature {NONE} -- Initialization

	make_workbench (a_target: like target)
			-- Initialize Current to invoke C compilation
			-- in workbench mode.
		do
			is_workbench := True
			make (a_target)
		end

	make_finalized (a_target: like target)
			-- Initialize Current to invoke C compilation
			-- in finalize mode.
		do
			is_workbench := False
			make (a_target)
		end

feature -- Access

	is_workbench: BOOLEAN
			-- Is Current command used for workbench C compilation

feature -- Execution

	execute
			-- Execute the C compilation.
		local
			byte_context: BYTE_CONTEXT
			makefile_sh_name: FILE_NAME_32
			file: PLAIN_TEXT_FILE_32
		do
			byte_context := (create {SHARED_BYTE_CONTEXT}).context
			if is_workbench then
				byte_context.set_workbench_mode
				create makefile_sh_name.make_from_string (project_location.workbench_path)
			else
				byte_context.set_final_mode
				create makefile_sh_name.make_from_string (project_location.final_path)
			end
			makefile_sh_name.set_file_name (Makefile_SH)
			create file.make (makefile_sh_name)
			if file.exists then
				Eiffel_project.call_finish_freezing (is_workbench)
			else
				prompts.show_error_prompt (Warning_messages.w_Makefile_does_not_exist (makefile_sh_name), Void, Void)
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			if is_workbench then
				Result := Interface_names.m_Compilation_C_Workbench
			else
				Result := Interface_names.m_Compilation_C_Final
			end
		end

note
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

end -- class C_COMPILATION_COMMAND
