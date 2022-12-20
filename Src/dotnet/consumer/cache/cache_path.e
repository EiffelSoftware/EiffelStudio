note
	description: "Path to various EAC files"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_PATH

inherit
	COMMON_PATH

	KEY_ENCODER
		export
			{NONE} all
		end

	CACHE_SETTINGS
		export
			{NONE} all
		end

	SHARED_CLR_VERSION
		export
			{NONE} all
			{ANY} clr_version
		end

	SHARED_LOGGER
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Access

	absolute_consume_path: PATH
			-- Absolute path to EAC assemblies
		require
			non_void_clr_version: clr_version /= Void
		once
			Result := eiffel_assembly_cache_path.extended_path (relative_executing_env_path)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	absolute_info_path: PATH
			-- Absolute path to EAC assemblies file info
		require
			non_void_clr_version: clr_version /= Void
		once
			Result := absolute_consume_path.extended (eac_info_file_name)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	absolute_assembly_path_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): PATH
			-- Absolute path to folder containing `a_assembly' types.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: a_assembly.key /= Void
			non_void_clr_version: clr_version /= Void
		do
			Result := eiffel_assembly_cache_path.extended_path (relative_assembly_path_from_consumed_assembly (a_assembly))
		ensure
			non_void_path: Result /= Void
		end

	absolute_assembly_mapping_path_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): PATH
			-- Absolute path to folder containing `a_assembly' types.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: a_assembly.key /= Void
			non_void_clr_version: clr_version /= Void
		do
			Result := absolute_assembly_path_from_consumed_assembly (a_assembly).extended (assembly_mapping_file_name)
		ensure
			non_void_path: Result /= Void
		end

	absolute_type_path (a_assembly: CONSUMED_ASSEMBLY): PATH
			-- Path to file describing `a_type' from `a_assembly' relative to `Eac_path'
			-- Always return a value even if `a_type' in not in EAC
		require
			a_assembly_not_void: a_assembly /= Void
			clr_version_not_void: clr_version /= Void
			not_clr_version_empty: not clr_version.is_empty
		do
			Result := eiffel_assembly_cache_path.extended_path (relative_type_path (a_assembly))
		ensure
			non_void_path: Result /= Void
		end

	absolute_type_mapping_path (a_assembly: CONSUMED_ASSEMBLY): PATH
			-- Path to file, describing `a_assembly' .NET type name to class mappings
			-- Always return a value even if `a_assembly' in not in EAC
		require
			a_assembly_not_void: a_assembly /= Void
			clr_version_not_void: clr_version /= Void
			not_clr_version_empty: not clr_version.is_empty
		do
			Result := eiffel_assembly_cache_path.extended_path (relative_type_mapping_path (a_assembly))
		ensure
			non_void_path: Result /= Void
		end

feature {CACHE_READER} -- Access

	relative_assembly_path_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): PATH
			-- Path to folder containing `a_assembly' types relative to `Eac_path'
		require
			non_void_assembly: a_assembly /= Void
		do
			Result := relative_executing_env_path.extended (a_assembly.folder_name)
		ensure
			non_void_path: Result /= Void
		end

	relative_type_path (a_assembly: CONSUMED_ASSEMBLY): PATH
			-- Path to file describing `a_type' from `a_assembly' relative to `Eac_path'
			-- Always return a value even if `a_type' in not in EAC
		require
			a_assembly_not_void: a_assembly /= Void
		do
			Result := relative_assembly_path_from_consumed_assembly (a_assembly).extended (classes_file_name)
		ensure
			non_void_path: Result /= Void
		end

	relative_type_mapping_path (a_assembly: CONSUMED_ASSEMBLY): PATH
			-- Path to file, describing `a_assembly' .NET type name to class mappings, relative to `Eac_path'
			-- Always return a value even if `a_assembly' in not in EAC
		require
			a_assembly_not_void: a_assembly /= Void
		do
			Result := relative_assembly_path_from_consumed_assembly (a_assembly).extended (assembly_types_file_name)
		ensure
			non_void_path: Result /= Void
		end

	eac_info_file_name: STRING = "eac.info"
			-- Path to EAC info file relative to `Eac_path'.

	eiffel_assembly_cache_path: PATH
			-- Path to versioned Eiffel Assembly Cache installation
		require
			clr_version_not_void: clr_version /= Void
			clr_version_not_empty: not clr_version.is_empty
		local
			retried: BOOLEAN
		once
			if not retried then
				if attached internal_eiffel_cache_path.item as l_cache then
					Result := l_cache
				else
					if is_eiffel_layout_defined then
						Result := eiffel_layout.install_path
					else
						create Result.make_current
					end
					Result := Result.extended (eac_path)

						-- set internal EAC path to registry key
					internal_eiffel_cache_path.put (Result)
				end
			else
					-- FIXME: Manu 05/14/2002: we should raise an error here.
				io.error.put_string ("ISE_EIFFEL environment variable is not defined!%N")
				create Result.make_empty
			end
		ensure
			exist: Result /= Void
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			retried := True
			retry
		end

	eac_path: STRING_32 = "dotnet\assemblies"
			-- EAC path relative to $ISE_EIFFEL

feature {EMITTER} -- Access

	relative_executing_env_path: PATH
			-- retrieve relative path for execting environment
		once
			if conservative_mode then
				create Result.make_from_string (short_cache_name)
			else
				create Result.make_from_string (cache_name)
			end
			Result := Result.extended (cache_bit_platform).extended (clr_version)

			if eiffel_assembly_cache_path.name.ends_with (Result.name) then
					-- the related path is already included in the assembly cache path.
				create Result.make_empty
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	internal_eiffel_cache_path: CELL [detachable PATH]
			-- internal eiffel cache path
		once
			create Result.put (Void)
		end

feature {EMITTER} -- Element Change

	set_internal_eiffel_cache_path (a_path: PATH)
			-- set `internal_eiffel_cache_path' to 'a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			internal_eiffel_cache_path.put (a_path)
		end

note
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


end -- class CACHE_PATH

