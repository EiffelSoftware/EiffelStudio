indexing
	description: "Shared il emitter"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_EMITTER

inherit
	ANY

	SHARED_ERROR_HANDLER
		export 
			{NONE} all 
		end
	
	SHARED_WORKBENCH
		export 
			{NONE} all
		end

	COMPILER_EXPORTER
		export 
			{NONE} all
		end
		
	SHARED_ENV
		export 
			{NONE} all 
		end
		
feature -- Access

	assembly_cache_folder: DIRECTORY_NAME is
			-- Absolute path to path of EAC
		once
			if system.metadata_cache_path /= Void and then not system.metadata_cache_path.is_empty then
				create Result.make_from_string (environ.interpreted_string (system.metadata_cache_path))
			else
				create Result.make_from_string (environ.interpreted_string ((create {EIFFEL_ENV}).assemblies_path))
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end
		
	il_emitter: IL_EMITTER is
			-- Instance of IL_EMITTER
		local
			l_vd64: VD64
			l_vd67: VD67
		do
			Result := internal_il_emitter
			if Result = Void or else not Result.exists then
					-- IL_EMITTER component could not be loaded.
				create l_vd64
				error_handler.insert_error (l_vd64)
				Result := Void
			else
				if not Result.is_initialized then
						-- Path to cache is not valid
					create l_vd67.make (assembly_cache_folder)
					system.error_handler.insert_error (l_vd67)
					Result := Void
				end
			end
		ensure
			valid_result: Result /= Void implies Result.exists and then Result.is_initialized
		end

feature {NONE}

	internal_il_emitter: IL_EMITTER is
			-- Unique instance of IL_EMITTER
		once
			create Result.make (assembly_cache_folder, system.clr_runtime_version)
		end

end -- class SHARED_IL_EMITTER
