indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

class ASYNC_SHELL 

inherit

	IPC_SHARED

feature 

	send is
			-- Send request to execute shell command
			-- given by `command_name' in background.
		require
			Command_set: command_name /= Void
		local
			ext_str: ANY;
			job_nb: INTEGER
		do
			ext_str := command_name.to_c;
			job_nb := async_shell ($ext_str);
			--if (job_nb /= -1) then
				-- Future version for keeping track
				-- of processes.
				-- sent_jobs.put (command_name, job_nb.out)
			--end
		end;

	command_name: STRING;
			-- Command to be executed
			-- by background shell

	set_command_name (s: STRING) is
			-- Assign `s' to `command_name'.
		require
			Valid_command: not (s = Void)
		do
			command_name := s
		ensure
			command_name = s
		end;

	pass_address is
			-- Send the addresse of `send' and `set_command_name' to
			-- C so that C can send a request
		once
			async_shell_pass_address ($send, $set_command_name);
		end;

feature {NONE} -- External

	async_shell (cmd: POINTER): INTEGER is
		external
			"C"
		end;

	async_shell_pass_address (send_address, set_address: POINTER) is
		external
			"C"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
