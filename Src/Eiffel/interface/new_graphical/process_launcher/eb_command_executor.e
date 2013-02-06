note
	description: "Call commands outside the eiffel environment. Version for EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMMAND_EXECUTOR

inherit
	COMMAND_EXECUTOR
		redefine
			invoke_finish_freezing,
			terminate_c_compilation
		end

	EB_SHARED_MANAGERS

feature -- Command execution

	invoke_finish_freezing (c_code_dir: PATH; freeze_command: STRING_32; asynchronous: BOOLEAN; workbench_mode: BOOLEAN)
			-- Invoke the `finish_freezing' script.
		local
			l_launcher: EB_C_COMPILER_LAUNCHER
		do
			if is_gui then
				if workbench_mode then
					l_launcher := freezing_launcher
				else
					l_launcher := finalizing_launcher
				end
				l_launcher.prepare_command_line (freeze_command, Void, c_code_dir)
				l_launcher.set_hidden (True)
				l_launcher.launch (is_gui, False)
				if not asynchronous then
					l_launcher.wait_for_exit
				end
			else
				Precursor (c_code_dir, freeze_command, asynchronous, workbench_mode)
			end
		end

	terminate_c_compilation
			-- Terminate running c compilation, if any.
		do
			process_manager.terminate_freezing
			process_manager.terminate_finalizing
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
