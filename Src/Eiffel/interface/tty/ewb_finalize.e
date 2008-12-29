note

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
	make

feature -- Initialization

	make (k: BOOLEAN)
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

	name: STRING
		do
			Result := finalize_cmd_name
		end;

	help_message: STRING_32
		do
			Result := finalize_help
		end;

	abbreviation: CHARACTER
		do
			Result := finalize_abb
		end;

feature {NONE} -- Execution

	loop_action
			-- Execute Current batch command form -loop.
		local
			answer: STRING
		do
			if Eiffel_project.is_read_only then
				localized_print_error (ewb_names.read_only_project_cannot_compile)
			elseif
				command_line_io.confirmed
						(ewb_names.finalizing_implies_some_c_compilation)
			then
				localized_print (ewb_names.arrow_keep_assertions.as_string_32 + ewb_names.yes_or_no + ": ")
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

	execute
			-- Execute Current batch command.
		do
			if Eiffel_project.is_read_only then
				localized_print_error (ewb_names.read_only_project_cannot_compile)
			else
				init;
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						print_tail;
						process_finish_freezing (True);
					end
				end;
			end
		end;

	perform_compilation
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

end -- class EWB_FINALIZE
