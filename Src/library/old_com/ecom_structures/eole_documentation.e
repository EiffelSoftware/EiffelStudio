indexing

	description: "Documentation for a specified type description"
	note: "The attributes in the 'Implementation' part may seem to%
			%be useless but are needed for implementation reasons";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_DOCUMENTATION
		
feature -- Access

	name: EOLE_BSTR is
			-- Name
		do
			Result := current_name
		end
		
	doc_string: EOLE_BSTR is
			-- Documentation string
		do
			Result := documentation_string
		end
		
	help_file: EOLE_BSTR is
			-- Help file path and name
		do
			Result := help_file_path_and_name
		end

feature -- Element change

	set_name (n: EOLE_BSTR) is
			-- Set `current_name' with `n'
		do
			current_name := n
		end
		
	set_doc_string (dstring: EOLE_BSTR) is
			-- Set `documentation_string' with `dstring'
		do
			documentation_string := dstring
		end
		
	set_help_file (hfile: EOLE_BSTR) is
			-- Set `help_file_path_and_name' with `hfile'
		do
			help_file_path_and_name := hfile
		end
		
feature {NONE} -- Implementation

	current_name: EOLE_BSTR

	documentation_string: EOLE_BSTR

	help_file_path_and_name: EOLE_BSTR
		
end -- class EOLE_DOCUMENTATION

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


