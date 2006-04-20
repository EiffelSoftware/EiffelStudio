indexing

	description:
		"Error that interrupts a compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class INTERRUPT_ERROR

inherit

	ERROR
		redefine
			help_file_name
		end

feature -- Status report

	is_during_compilation: BOOLEAN;
			-- Was the interrupt called during an eiffel compilation?
			-- (False implies that it was interrupted during Reverse
			-- engineering)

feature -- Status setting

	set_during_compilation is
			-- Set `is_during_compilation' to `True'.
		do
			is_during_compilation := True
		ensure
			is_during_compilation: is_during_compilation
		end

feature -- Output

	code: STRING is
			-- Interrupt code
		do
			Result := "INTERRUPT"
		end;

	help_file_name: STRING is
			-- File name for the interrupt message
		do
			if is_during_compilation then
				Result := "COMP_INT"
			else
				Result := "RE_INT"
			end
		end

	file_name: STRING is
			-- No associated file name
		do

		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			a_text_formatter.add ("Interrupt was invoked");
			a_text_formatter.add_new_line
		end;

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

end -- class INTERRUPT_ERROR
