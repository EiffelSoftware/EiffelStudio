indexing

	description: 
		"Finalize eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FINALIZE

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, loop_action, perform_compilation
		end;
	SHARED_ERROR_HANDLER

create

	make, do_nothing

feature -- Initialization

	make (k: BOOLEAN) is
			-- Initialize Current with keep_assertions as `k'
			-- and project `proj'.
		do
			keep_assertions := k;
		ensure
			set: keep_assertions = k
		end;

feature -- Properties

	keep_assertions: BOOLEAN;
			-- Keep assertions in finalize code generation

	name: STRING is
		do
			Result := finalize_cmd_name
		end;

	help_message: STRING is
		do
			Result := finalize_help
		end;

	abbreviation: CHARACTER is
		do
			Result := finalize_abb
		end;

feature {NONE} -- Execution

	loop_action is
			-- Execute Current batch command form -loop.
		local
			answer: STRING
		do
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
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
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
			else
				init;
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						if not Eiffel_project.is_final_code_optimal then
							io.error.put_string 
							("Warning: the finalized system might not be optimal%N%
							%%Tin size and speed. In order to produce an optimal%N%
							%%Texecutable, finalize the system from scratch and do%N%
							%%Tnot use precompilation.%N%N");
						end;
						print_tail;
						process_finish_freezing (True);
					end
				end;
			end
		end;

	perform_compilation is
		do
			if
				Workbench.system_defined and then
				System.keep_assertions /= keep_assertions
			then
					-- Force refinalization when user changed is mind since
					-- last time.
				System.set_finalize
			end

			Eiffel_project.finalize (keep_assertions)
		end

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

end -- class EWB_FINALIZE
