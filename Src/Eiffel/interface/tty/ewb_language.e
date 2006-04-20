indexing

	description:
			"Specification of the output-language for the query"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	default:	"eiffel";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_LANGUAGE

inherit
	EWB_CMD
		rename
			name as language_cmd_name,
			abbreviation as language_abb
		redefine
			loop_action
		end;
	SHARED_QUERY_VALUES

create
	make_loop

feature -- Creation

	make_loop is
		do
			language_names.force ("eiffel", language_names.count + 1);
		end;

feature {NONE} -- Help message

	help_message: STRING is
		local
			i: INTEGER
		do
			Result := language_help.twin
			Result.append ("%N%T%T%T%T");
			from
				i := 1;
				Result.extend ('[');
			until
				i > language_names.count
			loop
				Result.append (language_names.item (i));
				i := i + 1;
				if i <= language_names.count then
					Result.extend (',');
				end;
			end;
			Result.extend (']');
		end;

feature {NONE} -- Execute

	loop_action is
		local
			command_arguments: EWB_ARGUMENTS;
			i: INTEGER;
			empty_array: ARRAY [STRING];
			argument: STRING;
		do
			create empty_array.make (1, 0);
			command_arguments := command_line_io.command_arguments;
			language_names.copy (empty_array);
			if command_arguments.argument_count = 1 then
				language_names.force ("eiffel", language_names.count + 1);
			else
				from
					i := 2;
				until
					i > command_arguments.argument_count
				loop
					argument := command_arguments.item (i);
					argument.to_lower;
					if argument.is_equal ("eiffel") or else
					    argument.is_equal ("c") or else
					    argument.is_equal ("cycle") then
						language_names.force (argument, language_names.count + 1);
					end;
					i := i + 1;
				end;
			end;
			execute;
		end;

	-- don't know exactly how, but that comes.
	-- IDEA: Wipe out current one and replace with user's.
	execute is do end;

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

end -- class EWB_LANGUAGE
