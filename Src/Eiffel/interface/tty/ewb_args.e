note

	description:
		"Records arguments for application execution."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ARGS

inherit

	EWB_CMD
		rename
			name as arguments_cmd_name,
			help_message as arguments_help,
			abbreviation as arguments_abb
		redefine
			loop_action
		end

feature {NONE} -- Execution

	loop_action
			-- Execute Current batch command
		local
			args, new_args, cmd: STRING;
		do
			args := arguments;
				-- Display previous value
			if args.is_empty then
				localized_print (ewb_names.no_previous_value)
			else
				localized_print (ewb_names.previous_value (args));
			end;
				-- Get the arguments
			localized_print (ewb_names.arrow_arguments);
			command_line_io.wait_for_return;
			new_args := io.last_string.twin
			if new_args.is_empty then
				if not args.is_empty then
					localized_print (ewb_names.no_value_entered);
					io.read_line;
					cmd := io.last_string;
					if cmd.count = 1 and then cmd.item (1).lower = 'd' then
						arguments.wipe_out;
					end;
				end;
			else
				arguments.copy (new_args);
			end;
		end;

	execute
			-- This command is available only for the `loop' mode.
		do
		end;

note
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

end -- class EWB_ARGS
