indexing
	description: "Shared il emitter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result := internal_il_emitter.item
			if Result = Void then
				create Result.make (assembly_cache_folder, system.clr_runtime_version)
				if Result.exists then
					internal_il_emitter.put (Result)
				end
			end
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

	internal_il_emitter: CELL [IL_EMITTER] is
			-- Unique instance of IL_EMITTER
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SHARED_IL_EMITTER
