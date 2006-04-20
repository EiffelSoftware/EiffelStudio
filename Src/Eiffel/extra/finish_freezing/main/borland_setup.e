indexing
	description: "Setup environment variables for Borland C compiler"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BORLAND_SETUP

inherit
	PATH_CONVERTER

create 
	make

feature -- Initialization

	make is
			-- Create and setup environment variables for Borland compiler.
		do
			initialize_env_vars
		end

	initialize_env_vars is
			-- Create bcc32.cfg file needed by Borland compiler.
		local
			l_config_file: RAW_FILE
			l_arg_string: STRING
			l_file_name: FILE_NAME
		do
			eiffel_dir := (create {EXECUTION_ENVIRONMENT}).get ("ISE_EIFFEL")
			create l_file_name.make_from_string (eiffel_dir)
			l_file_name.extend ("BCC55")
			l_file_name.extend ("BIN")
			if (create {DIRECTORY}.make (l_file_name)).exists then
				l_file_name.set_file_name ("bcc32.cfg")
				create l_config_file.make (l_file_name)
				if not l_config_file.exists then
					l_arg_string := "-D_WIN32_WINDOWS=0x0410 %
										%-DWINVER=0x400 %
										%-I$(ISE_EIFFEL)\BCC55\include %
										%-L$(ISE_EIFFEL)\BCC55\lib %
										%-L$(ISE_EIFFEL)\BCC55\lib\PSDK"
					l_arg_string.replace_substring_all ("$(ISE_EIFFEL)", short_path (eiffel_dir))
					l_config_file.make_open_write (l_file_name)
					l_config_file.put_string (l_arg_string)
					l_config_file.close
				end
				
			end
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

end -- class BORLAND_SETUP
