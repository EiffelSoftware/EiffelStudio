indexing 
	description: "Shared data for Eiffel code_generator"
	date: "$$"
	revision: "$$"

class
	ECDP_SHARED_DATA

inherit
	ECDP_USER_DATA_KEYS

	EXCEPTIONS

feature -- Access
	
	Eiffel_types: ECDP_TYPE_CONVERTER is
			-- [Generated types
			--				Value: `EIFFEL_TYPE'
			--				Key: ID corresponding to CodeDom type name]
		once
			create Result.default_create
		ensure
			types_table_created: Result /= Void
		end

	Ace_file: ECDP_ACE_FILE_WRITER is
			-- Create instance of `ECDP_ACE_FILE_WRITER'.
		once
			create Result.make
		ensure
			non_void_Ace_file: Result /= Void
		end

	Members_mapping: ECDP_MEMBERS_MAPPING is
			-- members mapping
		once
			create Result
		ensure
			non_void_members_mapping: Result /= Void
		end

	ace_file_path: SYSTEM_STRING is
			-- Path to ace file.
		require
			temporary_files_set: temporary_files /= Void
		do
			create Result.make_from_c_and_count ('.', 0)
			Result := Result.concat_string_string_string_string (temporary_files.base_path, ("\").to_cil, system_name, ("." + Ace_file_extension).to_cil)			
		ensure
			non_void_ace_file_path: Result /= Void
			not_empty_ace_file_path: Result.length > 0
		end

	system_name: SYSTEM_STRING is
			-- System name.
		require
			temporary_files_set: temporary_files /= Void
		do
			Result := temporary_files.base_path
			Result := Result.remove (0, temporary_files.temp_dir.length + 1)
		ensure
			non_void_system_name: Result /= Void
			not_empty_system_name: Result.length > 0
		end
	
	temporary_files: SYSTEM_DLL_TEMP_FILE_COLLECTION is
			-- Temporary files used to generate code.
		do
			Result := internal_temporary_files.item (0)
		end
	
feature -- Constants

	Eiffel_file_extension: STRING is "e"
			-- Eiffel file extension.
			
	Ace_file_extension: STRING is "ace"
			-- Ace file extension.
			
	Cast_expr_local: STRING is "l_cast_exp_"
			-- Constant for assignment attempt local variable name

	Return_var_name: STRING is "l_res"
			-- Constant for dummy function calls return values

feature -- System Setting

	set_temporary_files (temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION) is
			-- Initialize `ace_file_path' and `{ECDP_CODE_DOM_PATH}.local_cache_path'
		require
			non_void_temp_files: temp_files /= Void
		do
			internal_temporary_files.put (0, temp_files)
			(create {ECDP_CODE_DOM_PATH}).set_local_cache_path (temp_files.base_path)
		ensure
			temporary_files_set: temporary_files.equals (temp_files)
		end

feature {NONE} -- Implementation

	internal_temporary_files: NATIVE_ARRAY [SYSTEM_DLL_TEMP_FILE_COLLECTION] is
			-- Internal representation of `temporary_files'.
		once
			create Result.make (1)
		ensure
			non_void_internal_temporary_files: Result /= Void
		end

end -- class ECDP_SHARED_DATA

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
