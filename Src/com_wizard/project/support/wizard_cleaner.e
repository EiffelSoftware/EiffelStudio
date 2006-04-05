indexing
	description: "Generated file cleaner, delete non necessary files"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_CLEANER

inherit
	WIZARD_SHARED_FILE_NAMES
		export
			{NONE} all
		end

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
			a_directory_name := environment.destination_folder.twin
			a_directory_name.append (Client)
			a_directory_name.append_character (Directory_separator)
			a_directory_name.append (Clib)
			delete_object_files (a_directory_name)
			a_directory_name := environment.destination_folder.twin
			a_directory_name.append (Server)
			a_directory_name.append_character (Directory_separator)
			a_directory_name.append (Clib)
			delete_object_files (a_directory_name)
			a_directory_name := environment.destination_folder.twin
			a_directory_name.append (Common)
			a_directory_name.append_character (Directory_separator)
			a_directory_name.append (Clib)
			delete_object_files (a_directory_name)

			a_directory_name := environment.destination_folder.twin
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
				a_working_directory := Env.current_working_directory
				Env.change_working_directory (a_directory_name)
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
						a_file_name := a_directory_name.twin
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
				Env.change_working_directory (a_working_directory)
				check
					directory_empty: a_directory.is_empty
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
				a_working_directory := Env.current_working_directory
				Env.change_working_directory (a_directory_name)
				a_file_list := a_directory.linear_representation
				from
					a_file_list.start
				until
					a_file_list.after
				loop
					if is_object_file (a_file_list.item) then
						a_file_name := a_directory_name.twin
						a_file_name.append_character (Directory_separator)
						a_file_name.append (a_file_list.item)
						delete_file (a_file_name)
					end
					a_file_list.forth
				end
				Env.change_working_directory (a_working_directory)
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
end -- class WIZARD_CLEANER

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
