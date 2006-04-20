indexing
	description: "Type Library Documentation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_DOCUMENTATION

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_doc_string: like doc_string; a_context_id: like context_id; a_help_file: like help_file) is
			-- Initialize instance
		do
			name := a_name
			if a_doc_string = Void then
				doc_string := ""
			else
				doc_string := a_doc_string
			end
			context_id := a_context_id
			if a_help_file = Void then
				help_file := ""
			else
				help_file := a_help_file
			end
		ensure
			name_set: name = a_name
			doc_string_set: (a_doc_string /= Void implies doc_string = a_doc_string) and (a_doc_string = Void implies doc_string.is_equal (""))
			context_set: context_id = a_context_id
			help_file_set: (a_help_file /= Void implies help_file = a_help_file) and (a_help_file = Void implies help_file.is_equal (""))
		end

feature -- Access

	name: STRING
			-- Name

	doc_string: STRING
			-- Documentation string

	context_id: NATURAL_32
			-- Context identifier for library help topic in help file

	help_file: STRING;
			-- Full path of help file

feature -- Element Settings

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		do
			name := a_name
		ensure
			name_set: name = a_name
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

