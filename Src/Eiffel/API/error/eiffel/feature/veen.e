indexing
	description: "Error for undeclared identifier."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VEEN

inherit
	FEATURE_ERROR
		redefine
			print_single_line_error_message, build_explain
		end

feature -- Access

	identifier: STRING
			-- Undeclared identifier

	parameter_count: INTEGER
			-- Number of expected arguments.

	code: STRING is "VEEN"
			-- Error code

feature -- Settings

	set_identifier (s: STRING) is
			-- Assign `s' to `identifier'.
		require
			s_not_void: s /= Void
		do
			identifier := s
		ensure
			identifier_set: identifier = s
		end

	set_parameter_count (i: INTEGER) is
			-- Assign `i to `parameter_count'.
		require
			i_positive: i >= 0
		do
			parameter_count := i
			is_parameter_count_set := True
		ensure
			parameter_countt_set: parameter_count = i
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Identifier: ")
			a_text_formatter.add (identifier)
			a_text_formatter.add_new_line
			if is_parameter_count_set then
				a_text_formatter.add ("Taking ")
				if parameter_count = 0 then
					a_text_formatter.add ("no argument")
				else
					if parameter_count = 1 then
						a_text_formatter.add ("1 argument")
					else
						a_text_formatter.add_int (parameter_count)
						a_text_formatter.add (" arguments")
					end
				end
				a_text_formatter.add_new_line
			end
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Displays single line help in `a_text_formatter'.
		local
			l_text: STRING_32
		do
			Precursor (a_text_formatter)
			create l_text.make (50)
			l_text.append (" `")
			if {l_id: !like identifier} identifier then
				l_text.append (l_id)
			end
			l_text.append ("' taking ")
			if parameter_count > 0 then
				l_text.append_integer (parameter_count)
			else
				l_text.append ("no")
			end
			l_text.append (" arguments.")
			a_text_formatter.add (l_text)
		end

feature {NONE} -- Implementation

	is_parameter_count_set: BOOLEAN;
			-- Did we call `set_parameter_count'?

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

end -- class VEEN
