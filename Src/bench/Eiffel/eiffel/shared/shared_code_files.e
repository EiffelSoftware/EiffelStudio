indexing
	description: "Helper for creating files used in C code generation"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CODE_FILES

inherit
	PROJECT_CONTEXT
	
feature -- Makefile generation

	Make_f (final_mode: BOOLEAN): INDENT_FILE is
			-- Makefile for C compilation
		local
			p: STRING
			f_name: FILE_NAME
		do
			if final_mode then
				p := Final_generation_path
			else
				p := Workbench_generation_path
			end
			create f_name.make_from_string (p)
			f_name.set_file_name (Makefile_sh)
			create Result.make (f_name)
		end

feature -- C code generation

	gen_file_name (final_mode: BOOLEAN; base_name: STRING): STRING is
			-- Generate a file name either in workbench or final mode with
			-- a `.c' extension in the E1 directory.
		require
			base_name_not_void: base_name /= Void
		do
			Result := full_file_name (final_mode, System_object_prefix, base_name, Dot_c, 1)
		ensure
			result_not_void: Result /= Void
		end

	x_gen_file_name (final_mode: BOOLEAN; base_name: STRING): STRING is
			-- Generate a file name either in workbench or final mode with
			-- a `.x' extension in the E1 directory.
		require
			base_name_not_void: base_name /= Void
		do
			if final_mode then
				Result := full_file_name (final_mode, System_object_prefix, base_name, Dot_x, 1)
			else
				Result := full_file_name (final_mode, System_object_prefix, base_name, Dot_c, 1)
			end
		ensure
			result_not_void: Result /= Void
		end

	final_file_name (base_name, extension: STRING; n: INTEGER): STRING is
			-- Generate a file name in final_mode with file `extension'
			-- in system directory E`n'.
		require
			base_name_not_void: base_name /= Void
			extension_not_void: extension /= Void
			positive_n: n >= 1
		do
			Result := full_file_name (True, system_object_prefix, base_name, extension, n)
		ensure
			result_not_void: Result /= Void
		end

	workbench_file_name (base_name, extension: STRING; n: INTEGER): STRING is
			-- Generate a file in workbench_mode with file `extension'
			-- in system directory E1.
		require
			base_name_not_void: base_name /= Void
			extension_not_void: extension /= Void
			n_positive: n > 0
		do
			Result := full_file_name (False, system_object_prefix, base_name, extension, n)
		ensure
			result_not_void: Result /= Void
		end

	full_file_name (final_mode: BOOLEAN; sub_dir_prefix: CHARACTER; file_name, extension: STRING; packet: INTEGER): STRING is
			-- Generated file name for `final_mode' creating a subdirectory
			-- if `sub_dir_prefix' is not the null character using
			-- `file_name'+`extension' as filename.
			-- Side effect: Create the corresponding subdirectory if it
			-- does not exist yet.
		require
			file_name_not_void: file_name /= Void
			packet_positive: sub_dir_prefix /= '%U' implies packet > 0
		local
			subdirectory: STRING
			dir: DIRECTORY
			f_name: FILE_NAME
			dir_name: DIRECTORY_NAME
			finished_file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
			l_name: STRING
		do
			if final_mode then
				Result := final_generation_path
			else
				Result := workbench_generation_path
			end
			create dir_name.make_from_string (Result)

			if sub_dir_prefix /= '%U' then
				create subdirectory.make (7)
				subdirectory.append_character (sub_dir_prefix)
				subdirectory.append_integer (packet)
				dir_name.extend (subdirectory)
			end

				-- Side effect here, we create a new subdirectory if it does
				-- not exist yet.
			create dir.make (dir_name)
			if not dir.exists then
				dir.create_dir
			end

			create f_name.make_from_string (dir_name)
			if extension /= Void then
				l_name := file_name.twin
				l_name.append (extension)
			else
				l_name := file_name
			end
			f_name.set_file_name (l_name)
			Result := f_name

				-- Other side effect here so that we let our makefiles
				-- know that something needs to be recompiled in the `dir'
				-- directory.
			create finished_file_name.make_from_string (dir_name)
			finished_file_name.set_file_name (Finished_file_for_make)
			create finished_file.make (finished_file_name)
			if finished_file.exists and then finished_file.is_writable then
				finished_file.delete	
			end
		ensure
			result_not_void: Result /= Void
		end

end -- end class SHARED_CODE_FILES
