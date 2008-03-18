indexing
	description: "Makefile generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

feature -- Basic operations

	generate (a_folder_name, a_library_name: STRING) is
			-- Generates `Makefile' in folder `a_folder_name'.
		require
			a_folder_name_attached: a_folder_name /= Void
			valid_a_folder_name: is_valid_folder_name (a_folder_name)
			a_library_name_attached: a_library_name /= Void
			not_a_library_name_is_empty: not a_library_name.is_empty
		local
			a_directory: DIRECTORY
			a_file_list: LIST [STRING]
			a_working_directory: STRING
			obj_list: STRING
			wobj_list: STRING
			files: ARRAYED_LIST [STRING]
		do
			a_working_directory := Env.current_working_directory.twin
			create a_directory.make_open_read (a_folder_name)
			a_file_list := a_directory.linear_representation
			Env.change_working_directory (a_folder_name)
			from
				a_file_list.start
				create obj_list.make (100)
				create wobj_list.make (100)
				create files.make (100)
			until
				a_file_list.after or environment.abort
			loop
				if is_c_file (a_file_list.item) then
					obj_list.append (c_to_obj (a_file_list.item) + Space + "\%N")
					wobj_list.append ("w" + c_to_obj (a_file_list.item) + Space + "\%N")
					files.extend (a_file_list.item)
				end
				a_file_list.forth
			end
			if not obj_list.is_empty then
				save_file (make_file (files, a_library_name, "msc", False), "Makefile.msc")
				save_file (make_file (files, a_library_name, "msc", True), "Makefile-mt.msc")
				save_file (make_file (files, a_library_name, "bcb", False), "Makefile.bcb")
				save_file (make_file (files, a_library_name, "bcb", True), "Makefile-mt.bcb")
				save_file (environment_set_string (msc_compiler) + "%Nnmake /f Makefile.msc%Nnmake /f Makefile-mt.msc", "make_msc.bat")
				save_file (environment_set_string (bcb_compiler) + "%N%"%%ISE_EIFFEL%%\BCC55\bin\make%" /f Makefile.bcb%N%"%%ISE_EIFFEL%%\BCC55\bin\make%" /f Makefile-mt.bcb", "make_bcb.bat")
			end
			Env.change_working_directory (a_working_directory)
		end

feature {NONE} -- Basic operations

	make_file (a_file_list: LIST [STRING]; a_library_name, a_c_compiler: STRING; a_multi_threaded: BOOLEAN): STRING is
			-- Makefile text.
		require
			a_file_list_attached: a_file_list /= Void
			not_a_file_list_is_empty: not a_file_list.is_empty
			a_file_list_contains_attached_items: not a_file_list.has (Void)
			a_library_name_attached: a_library_name /= Void
			not_a_library_name_is_empty: not a_library_name.is_empty
			a_c_compiler_attached: a_c_compiler /= Void
			not_a_c_compiler_is_empty: not a_c_compiler.is_empty
			a_c_compiler_is_valid: a_c_compiler.is_equal (msc_compiler) or
				a_c_compiler.is_equal (bcb_compiler)
		local
			l_cursor: CURSOR
			l_file: STRING
		do
			create Result.make (1000)
			Result.append ("# ecom.lib - Makefile for EiffelCOM Generated C/C++ Object File%N%NMV = copy%N")

				-- Basic macros
			if a_c_compiler.is_equal (msc_compiler) then
				Result.append (makefile_macros_msc)
			else
				check
					a_c_compiler.is_equal (bcb_compiler)
				end
				Result.append (makefile_macros_bcb)
			end

				-- C flags
			Result.append (	"CFLAGS = ")
			if a_c_compiler.is_equal ("msc") then
					-- Note, we always compile in multithreaded mode
				Result.append (msc_compiler_flags)
			else
				Result.append (bcb_compiler_flags)
			end
			Result.append_character (' ')
			if a_multi_threaded then
					-- Add multi-threaded define
				Result.append ("-DEIF_THREADS ")
			end
			Result.append (c_compiler_flags)

				-- File macros
			Result.append ("%N%NOBJ = " + object_files (a_file_list, False) + "%N%NWOBJ = " + object_files (a_file_list, True))
			Result.append ("%N%Nall:: ")
			Result.append (library_name (a_library_name, True, a_multi_threaded))
			Result.append (".lib ")
			Result.append (library_name (a_library_name, False, a_multi_threaded))
			Result.append (".lib%N%N")
			Result.append (lib_generation (library_name (a_library_name, True, a_multi_threaded), "WOBJ", a_c_compiler))
			Result.append (lib_generation (library_name (a_library_name, False, a_multi_threaded), "OBJ", a_c_compiler))
			Result.append (".cpp.obj:")
			if a_c_compiler.is_equal ("msc") then
				Result.append (":")
			end
			Result.append ("%N	$(CC) $(CFLAGS) ")
			if a_c_compiler.is_equal (msc_compiler) then
				Result.append (" /nologo ")
			end
			Result.append ("$<%N%N")
			Result.append (wobj_generation (a_file_list))
		ensure
			non_void_make_file: Result /= Void
			valid_make_file: not Result.is_empty
		end

	save_file (a_content, a_file_name: STRING) is
			-- Save file with content `content' and file name `a_file_name'.
		require
			a_content_attached: a_content /= Void
			not_a_content_is_empty: not a_content.is_empty
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			l_string: STRING
		do
			if not retried then
				l_string := Env.current_working_directory.twin
				l_string.append_character (Directory_separator)
				l_string.append (a_file_name)
				create l_file.make_open_write (l_string)
				l_file.put_string (a_content)
				l_file.close
			else
				environment.set_abort (Makefile_write_error)
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

feature {NONE} -- Query

	library_name (a_base: STRING; a_workbench, a_multi_threaded: BOOLEAN): STRING
			-- Generates a library name base on a base name `a_base'
		require
			a_base_attached: a_base /= Void
			not_a_base_is_empty: not a_base.is_empty
		do
			create Result.make (a_base.count + 10)
			if a_workbench then
				Result.append (workbench_prefix)
			end
			Result.append (a_base)
			if a_multi_threaded then
				Result.append (multi_threaded_suffix)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	lib_generation (a_library_name, a_obj_name, a_c_compiler: STRING): STRING is
			-- lib generation part of Makefile
		require
			a_library_name_attached: a_library_name /= Void
			valid_library_name: not a_library_name.is_empty
			a_obj_name_attached: a_obj_name /= Void
			not_a_obj_name_is_empty: not a_obj_name.is_empty
			a_c_compiler_attached: a_c_compiler /= Void
			a_c_compiler_is_valid: a_c_compiler.is_equal (msc_compiler) or
				a_c_compiler.is_equal (bcb_compiler)
		local
			l_lib_name: STRING
		do
			create Result.make (200)

			l_lib_name := a_library_name.twin
			Result.append (a_library_name + ".lib: $(" + a_obj_name+ ")%N%
					%	if exist $@ del $@%N")
			if a_c_compiler.is_equal ("msc") then
				Result.append ("	lib -OUT:$@ $(" + a_obj_name+ ")%N")
			else
				check
					a_c_compiler.is_equal ("bcb")
				end
				Result.append ("	&$(ISE_EIFFEL)\Bcc55\Bin\tlib.exe %"$@%" /p256 +-$**%N")
			end

			Result.append ("	del *.obj%N%
					%	if not exist " + a_c_compiler + " mkdir " + a_c_compiler + "%N%
					%	$(MV) $@ " + a_c_compiler + "%N%
					%	del $@%N%N")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	object_files (a_files: LIST [STRING]; a_workbench: BOOLEAN): STRING
			-- Retrieve a list of object files
		require
			a_files_attached: a_files /= Void
			not_a_files_is_empty: not a_files.is_empty
			a_files_contained_attached_items: not a_files.has (Void)
		local
			l_cursor: CURSOR
		do
			create Result.make (1024)
			l_cursor := a_files.cursor
			from a_files.start until a_files.after loop
				if a_workbench then
					Result.append (workbench_prefix)
				end
				Result.append (c_to_obj (a_files.item))
				if not a_files.islast then
					Result.append (" \%N")
				end
				a_files.forth
			end
			a_files.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			a_files_unmoved: a_files.cursor.is_equal (old a_files.cursor)
		end

	wobj_generation (a_files: LIST [STRING]): STRING is
			-- String to generate wobj generation string.
		require
			a_files_attached: a_files /= Void
			not_a_files_is_empty: not a_files.is_empty
			a_files_contained_attached_items: not a_files.has (Void)
		local
			l_cursor: CURSOR
		do
			create Result.make (1024)
			l_cursor := a_files.cursor
			from a_files.start until a_files.after loop
				Result.append (wobj_string (a_files.item))
				a_files.forth
			end
			a_files.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			a_files_unmoved: a_files.cursor.is_equal (old a_files.cursor)
		end

	wobj_string (a_c_file_name: STRING): STRING is
			-- String to generate wobj file.
		require
			a_c_file_name_attached: a_c_file_name /= Void
			not_a_c_file_name_is_empty: not a_c_file_name.is_empty
			a_c_file_name_is_valid_name: is_c_file (a_c_file_name)
		do
			create Result.make (100)
			Result.append (workbench_prefix)
			Result.append (c_to_obj (a_c_file_name) +
					": " + a_c_file_name + "%N%
					%	$(CC) $(CFLAGS) -DWORKBENCH	")
			if not eiffel_layout.has_borland then
				Result.append (" -nologo ")
			end
			Result.append ("$(OUTPUT_CMD)$@ $?%N%N")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	environment_set_string (a_compile: STRING): STRING is
			-- Environment setting header
		require
			layout_defined: is_eiffel_layout_defined
			a_compile_attached: a_compile /= Void
			a_compile_is_valid: a_compile = msc_compiler or a_compile = bcb_compiler
		do
			create Result.make (512)
			Result.append ("@ECHO OFF%N")
			Result.append ("IF %"%%ISE_EIFFEL%%.%" == %".%" SET ISE_EIFFEL=")
			Result.append (eiffel_layout.install_path)
			Result.append ("%NIF %"%%ISE_PLATFORM%%.%" == %".%" SET ISE_PLATFORM=")
			Result.append (eiffel_layout.eiffel_platform)
			Result.append ("%NIF %"%%ISE_LIBRARY%%.%" == %".%" SET ISE_LIBRARY=")
			Result.append (eiffel_layout.eiffel_library)
			Result.append ("%NSET ISE_C_COMPILER=" + a_compile + "%N")
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	msc_compiler: STRING = "msc"
	bcb_compiler: STRING = "bcb"
			-- C compiler constants

	makefile_macros_msc: STRING is
			-- Makefile macros for msc compiler
		"CC = cl%N%
		%OUTPUT_CMD = -Fo%N"

	makefile_macros_bcb: STRING =
			-- Makefile macros for msc compiler
		"CC = %"$(ISE_EIFFEL)\Bcc55\Bin\bcc32.exe%"%N OUTPUT_CMD = -o%N"


	c_compiler_flags: STRING =
			-- C compiler options to compile generated code.
		"-D_WIN32_DCOM -c -I..\..\client\include -I..\..\server\include -I..\..\common\include -I%"%
		%$(ISE_EIFFEL)\studio\spec\%
		%$(ISE_PLATFORM)\include%" -I%"%
		%$(ISE_LIBRARY)\library\com\spec\windows\include%" "

	msc_compiler_flags: STRING is
			-- Additional Borland C flags.
			"-MT -W0 -Ox"

	bcb_compiler_flags: STRING is
			-- Additional Borland C flags.
		"-w- -I%"%
		%$(ISE_EIFFEL)\BCC55\include%" -L%"%
		%$(ISE_EIFFEL)\BCC55\lib%""

	workbench_prefix: STRING is "w";
			-- Library workbench prefix

	multi_threaded_suffix: STRING is "-mt";
			-- Multithreaded library name suffix

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
end -- class WIZARD_MAKEFILE_GENERATOR


