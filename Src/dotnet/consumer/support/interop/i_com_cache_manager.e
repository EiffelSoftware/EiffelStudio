indexing
	description: "COM interface for supported metadata consumer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	interface_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE100-6FE1-4C21-AE1E-01415B20FE30") end

deferred class
	I_COM_CACHE_MANAGER

feature -- Initialization

	initialize (a_clr_version: SYSTEM_STRING) is
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
		deferred
		ensure
			clr_version_set: clr_version = a_clr_version
			current_initialized: is_initialized
		end

	initialize_with_path (a_path, a_clr_version: SYSTEM_STRING) is
			-- initialize object with path to specific EAC and initializes it if not already done.
		require
			not_already_initialized: not is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
		deferred
		ensure
			clr_version_set: clr_version = a_clr_version
			eac_path_set: eac_path = a_path
			current_initialized: is_initialized
		end

feature -- Uninitialization

	unload is
			-- unloads initialized app domain and cache releated objects to preserve resources
		deferred
		end

feature -- Access

	is_successful: BOOLEAN is
			-- Was the consuming successful?
		deferred
		end
		
	is_initialized: BOOLEAN is
			-- has COM object been initialized?
		deferred
		end
		
	last_error_message: SYSTEM_STRING is
			-- Last error message
		deferred
		end

feature -- Basic Operations

	consume_assembly (a_name, a_version, a_culture, a_key: SYSTEM_STRING) is
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		deferred
		end

	consume_assembly_from_path (a_path: SYSTEM_STRING) is
			-- Consume assembly located `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		deferred
		end

feature -- Query

	relative_folder_name (a_name, a_version, a_culture, a_key: SYSTEM_STRING): SYSTEM_STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		deferred
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end

	relative_folder_name_from_path (a_path: SYSTEM_STRING): SYSTEM_STRING is
			-- Relative path to consumed assembly metadata given `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
			path_exists: (create {FILE_INFO}.make (a_path)).exists
		deferred
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end

	assembly_info_from_assembly (a_path: SYSTEM_STRING): I_COM_ASSEMBLY_INFORMATION is
			-- retrieve a local assembly's information
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		deferred
		ensure
			non_void_result: Result /= Void
		end
		
feature {NONE} -- Implementation

	clr_version: SYSTEM_STRING is
			-- Version of CLR used to emit data
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		deferred
		end

	eac_path: SYSTEM_STRING is
			-- Location of EAC `Eiffel Assembly Cache'
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		deferred
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


end -- I_COM_CACHE_MANAGER
