indexing
	description: "Document Schema."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SCHEMA

inherit
	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		end

create
	make_from_schema_file
	
feature -- Initialization
	
	make_from_schema_file (a_filename: STRING) is
			-- Make from 'a_filename'
		do
			name := a_filename
		end

feature -- Access

	name: STRING
			-- Name of schema

	validator: SCHEMA_VALIDATOR
			-- Schema validation

feature -- Query	

	is_valid_xml: BOOLEAN is True
			-- Is Current valid xml?

	is_valid: BOOLEAN is True
			-- Is Current valid schema definition according to W3C?
		
	get_element_by_name (el_name: STRING): DOCUMENT_SCHEMA_ELEMENT is
			-- Get a schema element with name `el_name', if exists.
		require
			el_name_not_void: el_name /= Void
		do
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
end -- class DOCUMENT_SCHEMA	