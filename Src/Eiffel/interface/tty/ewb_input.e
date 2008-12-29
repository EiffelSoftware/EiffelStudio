note

	description:
			"Specification of the inputfile for the query"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	default:	"First run: *.profile_information, Subsequential: last_output OR some file";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_INPUT

inherit
	EWB_CMD
		rename
			name as input_cmd_name,
			abbreviation as input_abb
		redefine
			loop_action
		end;
	SHARED_QUERY_VALUES

create
	make_loop

feature -- Creation

	make_loop
		do
			first_run := true;
			filenames.force ("*.pfi", filenames.count + 1);
		end;

feature {NONE} -- Help message

	help_message: STRING_32
		local
			i: INTEGER
			l_str: STRING_32
		do
			l_str := input_help.twin
			l_str.append ("%N%T%T%T%T");
			if filenames.count = 0 then
				l_str.append ("[last_output]");
			else
				from
					i := 1;
					l_str.extend ('[');
				until
					i > filenames.count
				loop
					l_str.append (filenames.item (i));
					i := i + 1
					if i <= filenames.count then
						l_str.extend (' ');
					end;
				end;
				l_str.extend (']');
			end;
			Result := l_str
		end;

feature {NONE} -- Execute

	loop_action
		local
			command_arguments: EWB_ARGUMENTS;
			i: INTEGER;
			empty_array: ARRAY [STRING];
		do
			create empty_array.make (1, 0);
			command_arguments := command_line_io.command_arguments;
			if first_run and command_arguments.argument_count = 1 then
				filenames.copy (empty_array);
				filenames.force ("*.pfi", filenames.count + 1);
			else
				if command_arguments.argument_count = 1 then
					if filenames.count = 1 then
						command_arguments.force ("last_output", 1);
					else
						localized_print (ewb_names.arrow_filenames)
						command_line_io.get_name;
					end;
					i := 1;
				else
					i := 2;
				end;
				filenames.copy (empty_array);
				from
				until
					i > command_arguments.argument_count
				loop
					filenames.force (command_arguments.item (i), filenames.count + 1);
					i := i + 1;
				end;
			end;
			execute;
		end;

	-- don't know exactly how, but that comes.
	-- IDEA: wipe_out current and replace with user's.
	execute
		do
			first_run := false;
		end;

feature {NONE} -- Attributes

	first_run: BOOLEAN;

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

end -- class EWB_INPUT
