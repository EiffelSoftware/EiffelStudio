indexing
	description: "Generated file cleaner, delete non necessary files"

class
	WIZARD_CLEANER

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_ROUTINES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_EXECUTION_ENVIRONMENT

feature -- Basic Operations

	clean_all is
			-- Delete temporary generated files.
		local
			a_directory_name: STRING
		do
			delete_file (Generated_iid_file_name)
			delete_file (Generated_header_file_name)
			delete_file (Generated_dlldata_file_name)
			delete_file (Generated_ps_file_name)
			delete_file (c_to_obj (Generated_iid_file_name))
			delete_file (c_to_obj (Generated_dlldata_file_name))
			delete_file (c_to_obj (Generated_ps_file_name))
			delete_file (Temporary_input_file_name)
			delete_file (Def_file_name)
			a_directory_name := clone (Shared_wizard_environment.destination_folder)
			a_directory_name.append (Client)
			a_directory_name.append_character (Directory_separator)
			a_directory_name.append (Clib)
			delete_object_files (a_directory_name)
			a_directory_name := clone (Shared_wizard_environment.destination_folder)
			a_directory_name.append (Server)
			a_directory_name.append_character (Directory_separator)
			a_directory_name.append (Clib)
			delete_object_files (a_directory_name)
			a_directory_name := clone (Shared_wizard_environment.destination_folder)
			a_directory_name.append (Common)
			a_directory_name.append_character (Directory_separator)
			a_directory_name.append (Clib)
			delete_object_files (a_directory_name)

			a_directory_name := clone (Shared_wizard_environment.destination_folder)
			a_directory_name.append ("idl")
			a_directory_name.append_character (Directory_separator)
			a_directory_name.append ("e2idl.output")
			delete_file (a_directory_name)
		end

	clean_directory (a_directory_name: STRING) is
			-- Delete all files and subdirectories from directory `a_directory_name'
		require
			non_void_directory_name: a_directory_name /= Void
			valid_directory_name: not a_directory_name.is_empty
		local
			a_directory: DIRECTORY
			a_file: RAW_FILE
			a_working_directory, a_file_name: STRING
			a_file_list: LIST [STRING]
		do
			create a_directory.make (a_directory_name)
			if a_directory.exists then
				a_working_directory := execution_environment.current_working_directory
				execution_environment.change_working_directory (a_directory_name)
				a_file_list := a_directory.linear_representation
				from
					a_file_list.start
				until
					a_file_list.after
				loop
					if 
						not a_file_list.item.is_equal (".") or
						not a_file_list.item.is_equal ("..")
					then
						a_file_name := clone (a_directory_name)
						a_file_name.append_character (Directory_separator)
						a_file_name.append (a_file_list.item)
						create a_file.make (a_file_name)
						if a_file.exists then
							if a_file.is_directory then
								clean_directory (a_file_name)
							end
							delete_file (a_file_name)
						end
					end
					a_file_list.forth
				end
				execution_environment.change_working_directory (a_working_directory)
				check
					directory_empty: a_directory.empty
				end
			end
		end
		
	delete_object_files (a_directory_name: STRING) is
			-- Delete all object files in directory `a_directory_name'.
		require
			non_void_directory_name: a_directory_name /= Void
			valid_directory_name: not a_directory_name.is_empty
		local	
			a_file_list: LIST [STRING]
			a_directory: DIRECTORY
			a_working_directory, a_file_name: STRING
		do
			create a_directory.make (a_directory_name)
			if a_directory.exists then
				a_working_directory := execution_environment.current_working_directory
				execution_environment.change_working_directory (a_directory_name)
				a_file_list := a_directory.linear_representation
				from
					a_file_list.start
				until
					a_file_list.after
				loop
					if is_object_file (a_file_list.item) then
						a_file_name := clone (a_directory_name)
						a_file_name.append_character (Directory_separator)
						a_file_name.append (a_file_list.item)
						delete_file (a_file_name)
					end
					a_file_list.forth
				end
				execution_environment.change_working_directory (a_working_directory)
			end
		end

	delete_file (a_file_name: STRING) is
			-- Delete file `a_file_name'.
		local
			a_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				if a_file_name /= Void and then not a_file_name.is_empty then
					create a_file.make (a_file_name)
					if a_file.exists then
						a_file.delete
					end
				end
			end
		rescue
			retried := True
			retry
		end

end -- class WIZARD_CLEANER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
