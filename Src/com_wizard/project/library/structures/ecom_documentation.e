indexing
	description: "Type Library Documentation"
	status: "See notice at end of class"
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
			name := a_name.twin
		ensure
			name /= Void and then name.is_equal (a_name)
		end

	set_doc_string (a_doc_string: STRING) is
			-- Set `doc_string' with `a_doc_string'
		require
			a_doc_string /= Void
		do
			doc_string := a_doc_string.twin
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
			help_file := a_help_file.twin
		ensure
			help_file /= Void and then help_file.is_equal (a_help_file)
		end

end -- class ECOM_DOCUMENTATION

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

