indexing

	description: 
		"Error when no license is available.";
	date: "$Date$";
	revision: "$Revision $"

class NO_LICENSE

inherit

	ERROR
		redefine
			help_file_name
		end

feature -- Status report

	application_name: STRING
			-- Name of the application for which a license is requested.

feature -- Status setting

	set_application_name (s: STRING) is
			-- Assign `s' to `application_name'
		do
			application_name := s
		end

feature -- Output

	code: STRING is 
			-- Interrupt code
		do
			Result := "NO_LICENSE"
		end;

	help_file_name: STRING is "NO_LICENSE"
			-- File name for the interrupt message

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			st.add_string ("Library: ")
			st.add_string (application_name)
			st.add_new_line
		end;

end -- class NO_LICENSE
