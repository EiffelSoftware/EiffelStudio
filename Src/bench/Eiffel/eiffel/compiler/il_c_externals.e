indexing
	description: "[
		List of all C external features in IL code generation.
		For each class ID we have a SEARCH_TABLE [INTEGER] that
		represents all external names ID in class ID.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_C_EXTERNALS 

inherit
	HASH_TABLE [SEARCH_TABLE [INTEGER], INTEGER]
	
	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_DECLARATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_CODE_FILES
		export
			{NONE} all
		undefine
			copy, is_equal
		end
	
create
	make

feature -- Insertion/Removal

	add_external (ext: FEATURE_I) is
			-- Add `ext' in Current.
		require
			is_c_external: ext.is_c_external
		local
			l_s: SEARCH_TABLE [INTEGER]
		do
			l_s := item (ext.written_in)
			if l_s = Void then
				create l_s.make (1)
				force (l_s, ext.written_in)
			end
			l_s.force (ext.feature_name_id)
		end

	remove_external (ext: FEATURE_I) is
			-- Remove `ext' in Current.
		require
			is_c_external: ext.is_c_external
			has_entry: has (ext.written_in)
		local
			l_s: SEARCH_TABLE [INTEGER]
		do
			l_s := item (ext.written_in)
			if l_s /= Void then
				l_s.remove (ext.feature_name_id)
				if l_s.is_empty then
					remove (ext.written_in)
				end
			end
		end
		
feature -- Code generation

	generate_il is
			-- Generate C encapsulation for all calls.
		local
			buffer, header_buffer: GENERATION_BUFFER
			external_file, header_file: INDENT_FILE
			final_mode: BOOLEAN
		do
			from
				final_mode := context.final_mode
				buffer := context.generation_buffer
				header_buffer := context.header_generation_buffer
				buffer.set_is_il_generation (True)
				header_buffer.set_is_il_generation (True)
				context.set_buffer (buffer)
				context.set_header_buffer (header_buffer)
				extern_declarations.wipe_out
				buffer.putstring ("#include %"eif_eiffel.h%"%N")
				buffer.putstring ("#include %"" + System.system_name + ".h%"%N")
				buffer.start_c_specific_code
				header_buffer.putstring ("#include %"eif_eiffel.h%"%N")
				header_buffer.start_c_specific_code
				start
			until
				after
			loop
				generate_class_il (item_for_iteration, System.class_of_id (key_for_iteration).feature_table, buffer)
				buffer.new_line
				forth
			end
			buffer.end_c_specific_code
			header_buffer.end_c_specific_code

			create header_file.make_open_write (full_file_name (System.system_name + ".h", final_mode))
			extern_declarations.generate_header_files (header_buffer)
			header_file.put_string (header_buffer)
			header_file.close

			create external_file.make_open_write (full_file_name (System.system_name + ".c", final_mode))
			external_file.put_string (buffer)
			external_file.close
			
				-- Clean allocated data.
			extern_declarations.wipe_out
			buffer.clear_all
			header_buffer.clear_all		
		end
		
feature {NONE} -- Implementation

	generate_class_il (a_s: SEARCH_TABLE [INTEGER]; feat_tbl: FEATURE_TABLE; buffer: GENERATION_BUFFER) is
			-- Generate C il code
		local
			ext: EXTERNAL_I
			class_c: CLASS_C
		do
			from
				class_c := System.class_of_id (feat_tbl.feat_tbl_id)
				context.init (class_c.types.first)
				a_s.start
			until
				a_s.after
			loop
				ext ?= feat_tbl.item_id (a_s.item_for_iteration)
				ext.generate_c_il (buffer)
				a_s.forth
			end
		end

feature {NONE} -- Path

	full_file_name (base_file_name: STRING; final: BOOLEAN): STRING is
			-- Generated file name prefix
		local
			f_name: FILE_NAME
			dir_name: DIRECTORY_NAME
			finished_file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
		do
			if final then
				Result := final_generation_path
			else
				Result := workbench_generation_path
			end

			create dir_name.make_from_string (Result)
			create f_name.make_from_string (dir_name)
			f_name.set_file_name (base_file_name)
			Result := f_name

			create finished_file_name.make_from_string (dir_name)
			finished_file_name.set_file_name (Finished_file_for_make)
			create finished_file.make (finished_file_name)
			if finished_file.exists and then finished_file.is_writable then
				finished_file.delete	
			end
		end
		
end -- class IL_C_EXTERNALS
