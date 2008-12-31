note
	description: "XSL transformation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XSL_TRANSFORM
	
inherit	
	SHARED_OBJECTS
		
	EXECUTION_ENVIRONMENT

	UTILITY_FUNCTIONS
	
	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		end

create
	make_from_xsl_file

feature	-- Facade

	make_from_xsl_file (a_filename: STRING)
			-- Make from existing `xsl' file
		do
		end

	name: STRING = "XSL is not supported in non .NET mode"
			-- Name

	is_valid_xml: BOOLEAN = True
			-- Is Current valid xml?

	is_valid_xsl: BOOLEAN = True
			-- Is Current a valid Xslt file

	load_error_message: STRING = "XSL is not supported in non .NET mode";
			-- Load error message		

note
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
end -- class XSL_TRANSFORM
