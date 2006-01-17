indexing
	description: 
		"Finalize precompiled eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	EWB_FINALIZE_PRECOMP
	
inherit

	EWB_PRECOMP
		rename
			make as make_precompile
		export
			{NONE} make_precompile
		undefine
			loop_action
		redefine
			name, help_message, abbreviation,
			execute, loop_action, perform_compilation,
			process_finish_freezing
		select
			save_project_again
		end;
		
	EWB_FINALIZE
		rename
			save_project_again as save_project_again_finalize,
			make as make_finalize
		export
			{NONE} save_project_again_finalize, make_finalize
		redefine
			name, help_message, abbreviation,
			execute, loop_action, perform_compilation,
			process_finish_freezing
		end;		
		
	SHARED_ERROR_HANDLER

create
	make, do_nothing

feature -- Initialization

	make (is_licensed: like licensed; keep: like keep_assertions) is
			-- Initialize Current with keep_assertions as `keep'
			-- and project `proj'.
		do
			make_precompile (is_licensed)
			make_finalize (keep)
		end;

feature -- Properties

	name: STRING is
		do
			Result := finalized_precompile_cmd_name
		end;

	help_message: STRING is
		do
			Result := finalize_precompile_help
		end;

	abbreviation: CHARACTER is
		do
			Result := finalize_precompile_abb
		end;

feature {NONE} -- Execution

	loop_action is
			-- Execute Current batch command form -loop.
		local
			answer: STRING
		do
			if not Eiffel_project.is_new then
				io.error.put_string ("The project %"");
				io.error.put_string (Eiffel_project.name);
				io.error.put_string ("%" already exists.%N%
					%It needs to be deleted before a precompilation.%N");
			elseif 
				command_line_io.confirmed 
						("Finalizing implies some C compilation and linking.%
							%%NDo you want to do it now") 
			then
				io.put_string ("--> Keep assertions (y/n): ");
				command_line_io.wait_for_return;
				answer := io.last_string;
				answer.to_lower;
				if answer.is_equal ("y") or else answer.is_equal ("yes") then
					keep_assertions := True
				else
					keep_assertions := False;
				end;
				execute
			end
		end;

	execute is
			-- Execute Current batch command.
		do
			print_header;
			if Eiffel_project.is_new then
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						print_tail;
						process_finish_freezing (True);
					end
				end;
			else
				io.error.put_string ("The project %"");
				io.error.put_string (Eiffel_project.name);
				io.error.put_string ("%" already exists.%N%
					%It needs to be deleted before a precompilation.%N");
			end
		end;

	perform_compilation is
		do
			if Workbench.system_defined and then
				System.keep_assertions /= keep_assertions
			then
					-- Force refinalization when user changed is mind since
					-- last time.
				System.set_finalize
			end

			Eiffel_project.finalize_precompile (licensed, keep_assertions)
		end

	process_finish_freezing (finalized_dir: BOOLEAN) is
			-- Perform finish_freezing step if needed or display message.
		do
			if eiffel_project.comp_system.il_generation then
				Precursor {EWB_PRECOMP} (False)
				Precursor {EWB_PRECOMP} (True)
			else
					-- for non-.net project generation always takes place in W_code
				Precursor {EWB_PRECOMP} (False)
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

end -- class EWB_FINALIZE_PRECOMP
