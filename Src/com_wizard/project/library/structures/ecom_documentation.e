indexing
	description: "Type Library Documentation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

