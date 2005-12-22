indexing
	description: "Common routines for building text messages for system information, errors and warnings."
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

	display_error_error (st: STRUCTURED_TEXT) is
			-- Message telling that an error occurred while displaying the errors.
		do
			st.add_string ("Exception occurred while displaying error message.")
			st.add_new_line
			st.add_string ("Please contact ISE to report this bug.")
			st.add_new_line
		end

	display_error_list (st: STRUCTURED_TEXT; error_list: LINKED_LIST [ERROR]) is
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

	display_warning_list (st: STRUCTURED_TEXT; warning_list: LINKED_LIST [WARNING]) is
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

	display_separation_line (st: STRUCTURED_TEXT) is
		do
			st.add_string ("-------------------------------------------------------------------------------")
			st.add_new_line
		end

	display_additional_info (st: STRUCTURED_TEXT) is
			-- Additional system information.
		local
			degree_nbr: INTEGER
			to_go: INTEGER
		do
			degree_nbr := Degree_output.current_degree
			if degree_nbr > 0 then
					-- Case has degree_number equal to 0
				st.add_string ("Degree: ")
				st.add_string (degree_nbr.out)
			end;
			st.add_string (" Processed: ")
			st.add_string (Degree_output.processed.out)
			st.add_string (" To go: ")
			to_go := Degree_output.total_number - Degree_output.processed
			st.add_string (to_go.out)
			st.add_string (" Total: ")
			st.add_string (Degree_output.total_number.out)
			st.add_new_line
		end



	welcome_info: STRUCTURED_TEXT is
			-- Information text on how to launch $EiffelGraphicalCompiler$.
		do
			create Result.make
			Result.add_new_line
			Result.add_string ("To create or open a project using")
			Result.add_new_line
			Result.add_string (Interface_names.WorkBench_name + ": On the File menu,")
			Result.add_new_line
			Result.add_string ("click %"New...%" or %"Open...%".")
			Result.add_new_line
		ensure
			st_not_void: Result /= Void
		end

	structured_system_info: STRUCTURED_TEXT is
			-- Information text about current project.
		do
			if Eiffel_project.system /= Void then
				create Result.make
				append_system_info (Result)
			end
		end

	error_summary (error_count: INTEGER): STRUCTURED_TEXT is
			-- Message telling error summary.
		local
			l_conjunctive,
			l_plurality: STRING
		do
			create Result.make
			if error_count > 1 then
				l_conjunctive := " were "
				l_plurality := " errors "
			else
				l_conjunctive := " was "
				l_plurality := " error "
			end
			Result.add_string ("%TThere" + l_conjunctive + error_count.out + l_plurality + "during compilation.")
			Result.add_new_line
		end

	warning_summary (warning_count: INTEGER): STRUCTURED_TEXT is
			-- Message telling warning summary.
		local
			l_conjunctive,
			l_plurality: STRING
		do
			create Result.make
			if warning_count > 1 then
				l_conjunctive := " were "
				l_plurality := " warnings "
			else
				l_conjunctive := " was "
				l_plurality := " warning "
			end
			Result.add_string ("(There" + l_conjunctive + warning_count.out + l_plurality + "during compilation)")
			Result.add_new_line
		end

end
