indexing
	description: 
		"Dump loop"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EWB_DUMP_LOOP

inherit

	EWB_CMD
		rename
			name as externals_cmd_name,
			help_message as externals_help,
			abbreviation as externals_abb
		end

	SHARED_WORKBENCH

create
	default_create

feature

	execute is
			-- Dump class information.
		local
			done: BOOLEAN
			input: FILE
			cmd: STRING
			arg: STRING
			i: INTEGER
			f_dump: EWB_DUMP_FEATURES
		do
			from
				input := io.input
				print ("ready%N")
			until
				done
			loop
				io.output.flush
				io.input.flush
				input.read_line
				cmd := input.last_string
				i := cmd.substring_index (" ", 1)
				if i > 0 then
					arg := cmd.substring (
						i + 1,
						cmd.count
					)
					cmd := cmd.substring (1, i - 1)
				else
					arg := ""
				end
				if cmd.is_equal ("features") and not arg.is_empty then
					create f_dump.make_verbose (arg)
					f_dump.execute
					print ("%N")
				end
				if
					cmd.is_empty or
					cmd.is_equal ("done") or
					cmd.is_equal ("quit") or
					cmd.is_equal ("exit") or
					cmd.is_equal ("bye")
				then
					done := True
				end
			end

		end

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

end -- class EWB_DUMP_CLASSES
