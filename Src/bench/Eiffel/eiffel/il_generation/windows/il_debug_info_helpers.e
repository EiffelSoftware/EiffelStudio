indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IL_DEBUG_INFO_HELPERS

inherit

	SHARED_WORKBENCH
		export
			{NONE} all 
		end

	PROJECT_CONTEXT
		export
			{NONE} all 
		end
		
feature -- Query

	is_entry_point (a_feat: FEATURE_I): BOOLEAN is
			-- Is `a_feat' the entry point ?
		require
			feat_not_void: a_feat /= Void
		local
			l_creation_name: STRING
		do
			l_creation_name := System.creation_name
			Result := l_creation_name /= Void --| In case we are precompiling |--
					and then a_feat.feature_name.is_equal (l_creation_name)
					and then a_feat.written_class.is_equal (System.root_class.compiled_class)
		end


feature -- IL info file names 

	Il_info_file_name: FILE_NAME is
			-- Filename for IL info storage
		do
			if system.is_precompile_finalized then
				Result := Final_il_info_file_name
			else
				Result := Workbench_il_info_file_name
			end
		end
		
	Workbench_il_info_file_name: FILE_NAME is
			-- Filename for Workbench IL info storage
		do		
			create Result.make_from_string (Workbench_generation_path)
			Result.set_file_name (Il_info_name)
			Result.add_extension (Il_info_extension)
		end

	Final_il_info_file_name: FILE_NAME is
			-- Filename for Final IL info storage
		once
			create Result.make_from_string (Final_generation_path)
			Result.set_file_name (Il_info_name)
			Result.add_extension (Il_info_extension)
		end

feature -- File name data From compiler world

	module_directory_name: STRING is
			-- Directory path where module are located
		do
				-- MEGA BIG FIX HERE !!!! how can one know if we are in wb or final ?
				-- FOR NOW WE ASSUME WE DEBUG ONLY WORKBENCH PROGR		
			Result := Workbench_generation_path
		end
		
	assembly_directory_name: STRING is
			-- Directory path where assemblies are located
			-- that is also valid for precompilation assemblies
		do
				-- MEGA BIG FIX HERE !!!! how can one know if we are in wb or final ?
				-- FOR NOW WE ASSUME WE DEBUG ONLY WORKBENCH PROGR			
			Result := Workbench_bin_generation_path
		end		
		
	precompilation_module_filename (a_system_name: STRING): FILE_NAME is
		do
			create Result.make_from_string (assembly_directory_name)
			Result.set_file_name (precompilation_module_name (a_system_name))
		end

	precompilation_module_name (a_system_name: STRING): STRING is
		do
			Result := a_system_name + ".dll"
		end		
		
	module_file_name_for_class (a_class_type: CLASS_TYPE): STRING is
			-- Computed module file name for `a_class_type'
			--| we use CLASS_TYPE for the precompiled case .
		require
			class_type_not_void: a_class_type /= Void
			a_class_type_is_not_external: not a_class_type.is_external
		local
			l_location_path: STRING
			l_output: FILE_NAME
			l_module_filename: STRING
		do
				--| Please make sure this computing is similar to 
				--| the one inside IL_CODE_GENERATOR.il_module
			if a_class_type.is_precompiled then
				l_output := precompilation_module_filename (a_class_type.assembly_info.assembly_name)
			else
				l_location_path := module_directory_name
				create l_output.make_from_string (l_location_path)
				l_module_filename := module_name_for_class (a_class_type)
				l_output.set_file_name (l_module_filename)
			end
			Result := l_output
		end
		
	module_name_for_class (a_class_type: CLASS_TYPE): STRING is
			-- Computed module name for `a_class_type'
			--| we use CLASS_TYPE for the precompiled case .
		require
			class_type_not_void: a_class_type /= Void
		local
			l_type_id: INTEGER
			l_assembly_name: STRING
			l_module_name: STRING
			l_is_single_module: BOOLEAN
		do
				--| Please make sure this computing is similar to 
				--| the one inside IL_CODE_GENERATOR.il_module

--			l_is_single_module := System.in_final_mode or else Compilation_modes.is_precompiling
-- We assume, we are debugging only Workbench application for now.
			
			if a_class_type.is_precompiled then
				l_is_single_module := True
				l_module_name := precompilation_module_name (a_class_type.assembly_info.assembly_name)
			else
				if l_is_single_module then
					l_type_id := 1
				else
					l_type_id := a_class_type.associated_class.class_id // System.msil_classes_per_module + 1
				end
				l_module_name := "module_" + l_type_id.out + ".dll"
			end

			Result := l_module_name
		end		

end -- class IL_DEBUG_INFO_HELPERS
