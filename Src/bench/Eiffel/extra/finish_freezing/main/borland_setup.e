indexing
	description: "Setup environment variables for Borland C compiler"
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
			eiffel_dir := env.get ("ISE_EIFFEL")
			create l_file_name.make_from_string (eiffel_dir)
			l_file_name.extend ("BCC55")
			l_file_name.extend ("BIN")
			if (create {DIRECTORY}.make (l_file_name)).exists then
				l_file_name.set_file_name ("bcc32.cfg")
				create l_config_file.make (l_file_name)
				if not l_config_file.exists then
					l_arg_string := "-D_WIN_32_WINDOWS=0x0410 %
										%-DWINVER=0x400 %
										%-I$(ISE_EIFFEL)\BCC55\include %
										%-L$(ISE_EIFFEL)\BCC55\lib %
										%-L$(ISE_EIFFEL)\BCC55\lib\PSDK"
					l_arg_string.replace_substring_all ("$(ISE_EIFFEL)", short_path)
					l_config_file.make_open_write (l_file_name)
					l_config_file.put_string (l_arg_string)
					l_config_file.close
				end
				
			end
		end		

end -- class BORLAND_SETUP
