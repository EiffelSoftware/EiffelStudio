indexing
	description: "Component client generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_CLIENT_GENERATOR

feature -- Access

	ccom_last_error_code_name: STRING is "ccom_last_error_code"
			-- Name of last error code external feature.

	ccom_last_source_of_exception_name: STRING is "ccom_last_source_of_exception"
			-- Name of last source of exception external feature.

	ccom_last_error_description_name: STRING is "ccom_last_error_description"
			-- Name of last error description external feature.

	ccom_last_error_help_file_name: STRING is "ccom_last_error_help_file"
			-- Name of last error help file external feature.

	last_error_code_name: STRING is "last_error_code"
			-- Name of last error code  feature.

	last_source_of_exception_name: STRING is "last_source_of_exception"
			-- Name of last source of exception  feature.

	last_error_description_name: STRING is "last_error_description"
			-- Name of last error description  feature.

	last_error_help_file_name: STRING is "last_error_help_file";
			-- Name of last error help file  feature.


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
end -- class WIZARD_COMPONENT_CLIENT_GENERATOR

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

