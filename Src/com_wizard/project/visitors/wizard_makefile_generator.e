indexing
	description: "Makefile generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MAKEFILE_GENERATOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_ROUTINES

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Miscellaneous

	make_file (flags, obj_list, a_library_name: STRING): STRING is
			-- Makefile text.
		require
			non_void_obj_list: obj_list /= Void
			valid_obj_list: not obj_list.empty
		do
			create Result.make (1000)
			Result.append ("# ecom.lib - Makefile for Microsoft C%N%N%
					%CC = cl%N%
					%CFLAGS = " + flags +
					"%N%NOBJ = " + obj_list + "%N%N" +
					a_library_name + ".lib: $(OBJ)%N%
					%	if exist $@ del $@%N%
					%	lib /OUT:$@ $(OBJ)%N%
					%	del *.obj%N%
					%%N%
					%.cpp.obj:%N%
					%	$(CC) $(CFLAGS) ")
			if Shared_wizard_environment.output_level = message_output.Output_none then
				Result.append (" /nologo ")
			end
			Result.append ("$<%N")
		ensure
			non_void_make_file: Result /= Void
			valid_make_file: not Result.empty
		end

feature -- Basic operations

	generate (a_folder_name, a_library_name: STRING) is
			-- Generates `Makefile' in folder `a_folder_name'.
		require
			non_void_folder_name: a_folder_name /= Void
			valid_folder_name: is_valid_folder_name (a_folder_name)
		local
			a_directory: DIRECTORY
			a_file_list: LIST [STRING]
			a_working_directory: STRING
			obj_list: STRING
		do
			a_working_directory := clone (execution_environment.current_working_directory)
			create a_directory.make_open_read (a_folder_name)
			a_file_list := a_directory.linear_representation
			execution_environment.change_working_directory (a_folder_name)
			from
				a_file_list.start
				create obj_list.make (100)
			until
				a_file_list.after or Shared_wizard_environment.abort
			loop
				if is_c_file (a_file_list.item) then
					obj_list.append (c_to_obj (a_file_list.item) + Space)
				end
				a_file_list.forth
			end
			if not obj_list.empty then
				save_file (make_file (c_compiler_flags (workbench_c_compiler_flags_addition), obj_list, a_library_name), "Makefile")
				save_file (make_file (c_compiler_flags (finalize_c_compiler_flags_addition), obj_list, a_library_name), "Makefile_finalize")
				save_file ("nmake /f Makefile_finalize", "make_finalize.bat")
			end
			execution_environment.change_working_directory (a_working_directory)
		end

	save_file (content, a_file_name: STRING) is
			-- Save file with content `content' and file name `a_file_name'.
		local
			retried: BOOLEAN
			a_file: PLAIN_TEXT_FILE
			a_string: STRING
		do
			if not retried then
				a_string := clone (execution_environment.current_working_directory)
				a_string.append_character (Directory_separator)
				a_string.append (a_file_name)
				create a_file.make_open_write (a_string)
				a_file.put_string (content)
				a_file.close
			else
				message_output.add_error (Current, message_output.Could_not_write_makefile)
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation

	c_compiler_flags (an_addition: STRING): STRING is 
			-- C compiler options to compile generated code.
		do
			create Result.make (200)
			Result.append ("/W0 ")
			Result.append (an_addition)
			Result.append (" /D %"_WIN32_DCOM%" /c /I..\..\client\include /I..\..\server\include /I..\..\common\include /I")
			Result.append (Eiffel4_location)
			Result.append ("\bench\spec\windows\include /I")
			Result.append (Eiffel4_location)
			Result.append ("\library\com\spec\windows\include ")
		end

	workbench_c_compiler_flags_addition: STRING is "/Zi /DWORKBENCH"
			-- C compiler options.

	finalize_c_compiler_flags_addition: STRING is "/Ox"
			-- C compiler options.

end -- class WIZARD_MAKEFILE_GENERATOR

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
