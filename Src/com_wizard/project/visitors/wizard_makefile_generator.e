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

	WIZARD_SHARED_MAPPER_HELPERS
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

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

feature -- Miscellaneous

	makefile_macros_msc: STRING is
			-- Makefile macros for msc compiler
		"CC = cl%N%
		%OUTPUT_CMD = -Fo%N"

	makefile_macros_bcb: STRING is
			-- Makefile macros for msc compiler
		"CC = $(ISE_EIFFEL)\Bcc55\Bin\bcc32.exe%N OUTPUT_CMD = -o%N"

	lib_generation (a_library_name, obj_name, c_compiler: STRING): STRING is
			-- lib generation part of Makefile
		require
			non_void_library_name: a_library_name /= Void
			valid_library_name: not a_library_name.is_empty
			non_void_obj_name: obj_name /= Void
			valid_obj_name: not obj_name.is_empty
			non_void_c_compiler: c_compiler /= Void
			valid_c_compiler: c_compiler.is_equal ("msc") or
						c_compiler.is_equal ("bcb")
		do
			create Result.make (200)
			Result.append (a_library_name + ".lib: $(" + obj_name+ ")%N%
					%	if exist $@ del $@%N")
			if c_compiler.is_equal ("msc") then
				Result.append ("	lib -OUT:$@ $(" + obj_name+ ")%N")
			else
				check
					c_compiler.is_equal ("bcb")
				end
				Result.append ("	&$(ISE_EIFFEL)\Bcc55\Bin\tlib.exe /p256 $@ +-$**%N")
			end

			Result.append ("	del *.obj%N%
					%	if not exist " + c_compiler + " mkdir " + c_compiler + "%N%
					%	$(MV) $@ " + c_compiler + "%N%
					%	del $@%N%N")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	make_file (obj_list, wobj_list, a_library_name, wobj_generation, c_compiler: STRING): STRING is
			-- Makefile text.
		require
			non_void_obj_list: obj_list /= Void
			valid_obj_list: not obj_list.is_empty
		do
			create Result.make (1000)
			Result.append ("# ecom.lib - Makefile for EiffelCOM Generated C/C++ Object File%N%NMV = copy%N")
			if c_compiler.is_equal ("msc") then
				Result.append (makefile_macros_msc)
			else
				check
					c_compiler.is_equal ("bcb")
				end
				Result.append (makefile_macros_bcb)
			end
			Result.append (	"CFLAGS = ")
			if c_compiler.is_equal ("msc") then
				Result.append ("-MT -W0 -Ox ")
				Result.append ("-YX")
				Result.append (Ecom_generated_rt_globals_header_file_name)
				Result.append_character (' ')
			else
				Result.append (bcb_compiler_flags)
			end
			Result.append (c_compiler_flags)
			Result.append ("%N%NOBJ = " + obj_list + "%N%NWOBJ = ")
			Result.append (wobj_list)
			Result.append ("%N%Nall:: ")
			Result.append (a_library_name)
			Result.append (".lib ")
			Result.append (a_library_name)
			Result.append ("_final.lib%N%N")
			Result.append (lib_generation (a_library_name, "WOBJ", c_compiler))
			Result.append (lib_generation (a_library_name + "_final", "OBJ", c_compiler))
			Result.append (".cpp.obj:")
			if c_compiler.is_equal ("msc") then
				Result.append (":")
			end
			Result.append ("%N	$(CC) $(CFLAGS) ")
			if c_compiler.is_equal ("msc") then
				Result.append (" /nologo ")
			end
			Result.append ("$<%N%N")
			Result.append (wobj_generation)
		ensure
			non_void_make_file: Result /= Void
			valid_make_file: not Result.is_empty
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
			wobj_list, wobj_generation: STRING
		do
			a_working_directory := Env.current_working_directory.twin
			create a_directory.make_open_read (a_folder_name)
			a_file_list := a_directory.linear_representation
			Env.change_working_directory (a_folder_name)
			from
				a_file_list.start
				create obj_list.make (100)
				create wobj_list.make (100)
				create wobj_generation.make (1000)
			until
				a_file_list.after or environment.abort
			loop
				if is_c_file (a_file_list.item) then
					obj_list.append (c_to_obj (a_file_list.item) + Space + "\%N")
					wobj_list.append ("w" + c_to_obj (a_file_list.item) + Space + "\%N")
					wobj_generation.append (wobj_string (a_file_list.item))
				end
				a_file_list.forth
			end
			if not obj_list.is_empty then
				save_file (make_file (obj_list, wobj_list, a_library_name, wobj_generation, "msc"), "Makefile.msc")
				save_file (make_file (obj_list, wobj_list, a_library_name, wobj_generation, "bcb"), "Makefile.bcb")
				save_file ("set ISE_EIFFEL=" + Eiffel_installation_dir_name + "%Nnmake /f Makefile.msc", "make_msc.bat")
				save_file ("set ISE_EIFFEL=" + Eiffel_installation_dir_name + "%N%%ISE_EIFFEL%%\BCC55\bin\make /f Makefile.bcb", "make_bcb.bat")
			end
			Env.change_working_directory (a_working_directory)
		end

	wobj_string (c_file_name: STRING): STRING is
			-- String to generate wobj file.
		require
			nonvoid_name: c_file_name /= Void
			nonempty_name: not c_file_name.is_empty
			valid_name: is_c_file (c_file_name)
		do
			create Result.make (100)
			Result.append ("w" + c_to_obj (c_file_name) +
							": " + c_file_name + "%N%
							%	$(CC) $(CFLAGS) -DWORKBENCH	")
			if not use_bcb then
				Result.append (" -nologo ")
			end
			Result.append ("$(OUTPUT_CMD)$@ $?%N%N")
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	save_file (content, a_file_name: STRING) is
			-- Save file with content `content' and file name `a_file_name'.
		local
			retried: BOOLEAN
			a_file: PLAIN_TEXT_FILE
			a_string: STRING
		do
			if not retried then
				a_string := Env.current_working_directory.twin
				a_string.append_character (Directory_separator)
				a_string.append (a_file_name)
				create a_file.make_open_write (a_string)
				a_file.put_string (content)
				a_file.close
			else
				environment.set_abort (Makefile_write_error)
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation

	c_compiler_flags: STRING is
			-- C compiler options to compile generated code.
			"-D_WIN32_DCOM %
			%-c -I..\..\client\include -I..\..\server\include -I..\..\common\include %
			%-I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include %
			%-I%D(ISE_EIFFEL)\library\com\spec\windows\include "

	bcb_compiler_flags: STRING is
			-- Additional Borland C flags.
			"-w- -I$(ISE_EIFFEL)\BCC55\include -L$(ISE_EIFFEL)\BCC55\lib "

end -- class WIZARD_MAKEFILE_GENERATOR

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

