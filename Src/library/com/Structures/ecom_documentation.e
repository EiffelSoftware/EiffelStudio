indexing
	description: "Type Library Documentation"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_DOCUMENTATION

feature -- Access

	name: STRING
			-- Name

	doc_string: STRING
			-- Documentation string

	context_id: INTEGER 
			-- Context identifier for library help topic in help file

	help_file: STRING
			-- Full path of help file

feature -- Element change

	set_name (a_name: string) is
			-- Set `name' with `a_name'
		require
			a_name /= Void
		do
			name := a_name
		ensure
			name /= Void and then name.is_equal (a_name)
		end

	set_doc_string (a_doc_string: STRING) is
			-- Set `doc_string' with `a_doc_string'
		require
			a_doc_string /= Void
		do
			doc_string := a_doc_string
		ensure
			doc_string /= Void and then doc_string.is_equal (a_doc_string)
		end

	set_context_id (id: INTEGER) is
			-- Sset `cintext_id' with `id'
		do
			context_id := id
		ensure
			context_id = id
		end

	set_help_file (a_help_file: STRING) is
			-- Set `help_file' with `a_help_file'
		require
			a_help_file /= Void
		do
			help_file := a_help_file
		ensure
			help_file /= Void and then help_file.is_equal (a_help_file)
		end

end -- class ECOM_DOCUMENTATION

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

