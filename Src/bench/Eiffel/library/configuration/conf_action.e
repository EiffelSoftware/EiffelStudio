indexing
	description: "Actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ACTION

inherit
	CONF_CONDITIONED

create
	make

feature {NONE} -- Initialization

	make (a_command: like command; a_must_succeed: like must_succeed; a_working_directory: like working_directory) is
			-- Create with `a_command'.
		require
			a_command_ok: a_command /= Void and then not a_command.is_empty
			a_working_directory_ok: a_working_directory /= Void
		do
			command := a_command
			must_succeed := a_must_succeed
			working_directory := a_working_directory
		ensure
			command_set: command = a_command
			must_succeed_set: must_succeed = a_must_succeed
			working_directory_set: working_directory = a_working_directory
		end


feature -- Access, stored in configuration file

	command: STRING
			-- The command to execute.

	working_directory: CONF_LOCATION
			-- Working directory to execute action.

	must_succeed: BOOLEAN
			-- Does the command have to be successful to continue?

	description: STRING
			-- A description about the command.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_command (a_command: like command) is
			-- Set `command' to `a_command'.
		require
			a_command_ok: a_command /= Void and then not a_command.is_empty
		do
			command := a_command
		ensure
			command_set: command = a_command
		end

	set_working_directory (a_directory: like working_directory) is
			-- Set `working_directory' to `a_directory'.
		require
			a_directory_not_void: a_directory /= Void
		do
			working_directory := a_directory
		ensure
			working_directory_set: working_directory = a_directory
		end

	enable_must_succeed is
			-- Command has to succeed.
		do
			must_succeed := True
		ensure
			must_succeed: must_succeed
		end

	disable_must_succeed is
			-- Command doesn't have to succeed.
		do
			must_succeed := False
		ensure
			must_succeed: not must_succeed
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

invariant
	command_ok: command /= Void and then not command.is_empty
	working_directory_ok: working_directory /= Void

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
end
