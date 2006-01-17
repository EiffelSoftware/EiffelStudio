indexing

	description: 
		"Command to build a precomplie eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_PRECOMP

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, perform_compilation,
			save_project_again
		end

create
	make

feature -- Initialization

	make (license_check: BOOLEAN) is
			-- Set `licensed' to `license_check'
		do
			licensed := license_check
		end

feature -- Properties

	name: STRING is
		do
			Result := precompile_cmd_name
		end;

	help_message: STRING is
		do
			Result := precompile_help
		end;

	abbreviation: CHARACTER is
		do
			Result := precompile_abb
		end;

	licensed: BOOLEAN
			-- Is this precompilation protected by a license?

feature {NONE} -- Execution

	execute is
		do
			print_header;
			if Eiffel_project.is_new and then Eiffel_project.able_to_compile then
				compile;
				if Eiffel_project.successful then
					print_tail;
					process_finish_freezing (False)
				end
			else
				io.error.put_string ("The project %"");
				io.error.put_string (Eiffel_project.name);
				io.error.put_string ("%" already exists.%N%
					%It needs to be deleted before a precompilation.%N");
			end
		end;

	perform_compilation is
		do
			Eiffel_project.precompile (licensed)
		end;

	save_project_again is
			-- Try to save the project again.
		local
			finished: BOOLEAN;
			temp: STRING
		do
			from
			until
				finished
			loop
				if Eiffel_project.precomp_save_error then
					create temp.make (0);
					temp.append ("Error: could not write to ");
					temp.append (Precompilation_file_name);
					temp.append ("%NPlease check permissions and disk space");
					io.error.put_string (temp);
					io.error.put_new_line;
					finished := stop_on_error or else
						command_line_io.termination_requested;
					if finished then
						lic_die (-1)
					else
						Eiffel_project.save_precomp (licensed)
					end;
				else
					Precursor {EWB_COMP} 
				end
			end
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

end -- class EWB_PRECOMP
