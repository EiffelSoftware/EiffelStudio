indexing
	description: "Common routines for building text messages for system information, errors and warnings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_OUTPUT_FACTORY

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

	OUTPUT_ROUTINES
		export
			{NONE} all
		end

feature -- Access

	display_error_error (st: TEXT_FORMATTER) is
			-- Message telling that an error occurred while displaying the errors.
		do
			st.add ("Exception occurred while displaying error message.")
			st.add_new_line
			st.add ("Please contact ISE to report this bug.")
			st.add_new_line
		end

	display_error_list (st: TEXT_FORMATTER; error_list: LINKED_LIST [ERROR]) is
			-- Display the content of `error_list' in `st'.
		do
			from
				error_list.start
			until
				error_list.after
			loop
				display_separation_line (st)
				st.add_new_line
				error_list.item.trace (st)
				st.add_new_line

					-- prepare next iterations.
				error_list.forth
			end
		end

	display_warning_list (st: TEXT_FORMATTER; warning_list: LINKED_LIST [WARNING]) is
			-- Display the content of `warning_list' in `st'.
		do
			from
				warning_list.start
			until
				warning_list.after
			loop
				display_separation_line (st)
				st.add_new_line
				warning_list.item.trace (st)
				st.add_new_line

					-- prepare next iterations.
				warning_list.forth
			end
		end

	display_separation_line (st: TEXT_FORMATTER) is
		do
			st.add ("-------------------------------------------------------------------------------")
			st.add_new_line
		end

	display_additional_info (st: TEXT_FORMATTER) is
			-- Additional system information.
		local
			degree_nbr: INTEGER
			to_go: INTEGER
		do
			degree_nbr := Degree_output.current_degree
			if degree_nbr > 0 then
					-- Case has degree_number equal to 0
				st.add ("Degree: ")
				st.add (degree_nbr.out)
			end;
			st.add (" Processed: ")
			st.add (Degree_output.processed.out)
			st.add (" To go: ")
			to_go := Degree_output.total_number - Degree_output.processed
			st.add (to_go.out)
			st.add (" Total: ")
			st.add (Degree_output.total_number.out)
			st.add_new_line
		end

	welcome_info (a_formatter: TEXT_FORMATTER) is
			-- Information text on how to launch $EiffelGraphicalCompiler$.
		do
			a_formatter.add_new_line
			a_formatter.add ("To create or open a project using")
			a_formatter.add_new_line
			a_formatter.add (Interface_names.WorkBench_name + ": On the File menu,")
			a_formatter.add_new_line
			a_formatter.add ("click %"New...%" or %"Open...%".")
			a_formatter.add_new_line
		end

	structured_system_info (a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Information text about current project.
		do
			if Eiffel_project.system /= Void then
				append_system_info (a_formatter)
				Result := false
			else
				Result := true
			end
		end

	error_summary (error_count: INTEGER; a_formatter: TEXT_FORMATTER) is
			-- Message telling error summary.
		local
			l_conjunctive,
			l_plurality: STRING
		do
			if error_count > 1 then
				l_conjunctive := " were "
				l_plurality := " errors "
			else
				l_conjunctive := " was "
				l_plurality := " error "
			end
			a_formatter.add ("%TThere" + l_conjunctive + error_count.out + l_plurality + "during compilation.")
			a_formatter.add_new_line
		end

	warning_summary (warning_count: INTEGER; a_formatter: TEXT_FORMATTER) is
			-- Message telling warning summary.
		local
			l_conjunctive,
			l_plurality: STRING
		do
			if warning_count > 1 then
				l_conjunctive := " were "
				l_plurality := " warnings "
			else
				l_conjunctive := " was "
				l_plurality := " warning "
			end
			a_formatter.add ("%TThere" + l_conjunctive + warning_count.out + l_plurality + "during compilation.")
			a_formatter.add_new_line
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

end
