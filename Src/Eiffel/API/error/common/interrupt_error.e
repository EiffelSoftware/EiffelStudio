indexing

	description:
		"Error that interrupts a compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class INTERRUPT_ERROR

inherit
	COMPILER_ERROR
		redefine
			help_file_name
		end

create
	make

feature -- Initialization

	make (a_during: like is_during_compilation) is
			-- Initialize current with `a_during'.
		do
			is_during_compilation := a_during
		ensure
			is_during_compilation_set: is_during_compilation = a_during
		end

feature -- Status report

	is_during_compilation: BOOLEAN;
			-- Was the interrupt called during an eiffel compilation?
			-- (False implies that it was interrupted during Reverse
			-- engineering)

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

end
