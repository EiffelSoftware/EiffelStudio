note
	description: "File names constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_FILE_NAMES

feature -- Access

	Generated_iid_file_name: STRING = "$ecom_iid_temp.c"
			-- Midl generated iid file name
	
	Generated_header_file_name: STRING = "$ecom_header_temp.h"
			-- Midl generated header file name
	
	Generated_dlldata_file_name: STRING = "$ecom_data_temp.c"
			-- Midl generated dlldata file name

	Generated_ps_file_name: STRING = "$ecom_ps_temp.c"
			-- Midl generated proxy/stub file name

	Def_file_name: STRING = "$ecom.def"
			-- Path to definition file

	Clib_name: STRING = "ecom"
			-- Libray file name

	Generated_files_file_name: STRING = "generated.txt";
			-- File including list of generated files

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
end -- class WIZARD_SHARED_FILE_NAMES

