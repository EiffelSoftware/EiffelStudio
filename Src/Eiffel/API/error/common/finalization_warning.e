indexing
	description: "Warning object for sub-optimal finalization"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FINALIZATION_WARNING

inherit
	WARNING
		redefine
			error_string,
			print_error_message
		end

feature -- Access

	error_string: STRING_8
		do
			Result := "Sub-Optimal Finalization"
		end

feature {NONE} -- Implementation

	print_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Display error in `a_text_formatter'.
		do
			a_text_formatter.add (Error_string);
			a_text_formatter.add_new_line;
			a_text_formatter.add_new_line;
		end

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation image for current error
			-- in error_window.
		do
			a_text_formatter.add_string ("The Finalized System may not be fully optimal in terms of speed and executable size.")
			a_text_formatter.add_new_line
			a_text_formatter.add_string ("In order to produce an optimal executable, finalize from a new project without using Precompilation or Assertions.")
			a_text_formatter.add_new_line
		end

	file_name: STRING_8

	code: STRING_8 is ""
end
