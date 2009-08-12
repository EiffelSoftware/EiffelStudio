note

	description:
		"Freeze eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FREEZE

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, loop_action, perform_compilation
		end

feature -- Properties

	name: STRING
		do
			Result := freeze_cmd_name
		end;

	help_message: STRING_32
		do
			Result := freeze_help
		end;

	abbreviation: CHARACTER
		do
			Result := freeze_abb
		end;

feature {NONE} -- Execution

	loop_action
		do
			if Eiffel_project.is_read_only then
				localized_print_error (ewb_names.read_only_project_cannot_compile)
			elseif
				command_line_io.confirmed
					(ewb_names.freezing_implies_some_c_compilation)
			then
				execute
			end
		end;

	execute
		do
			if Eiffel_project.is_read_only then
				localized_print_error (ewb_names.read_only_project_cannot_compile)
			else
				init;
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						print_tail;
						process_finish_freezing (False);
					end
				end;
			end;
		end;

feature {NONE} -- Implementation

    perform_compilation
            -- Melt eiffel project.
        do
            Eiffel_project.freeze;
        end;

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EWB_FREEZE
