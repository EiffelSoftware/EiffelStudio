indexing
	description: "Class that provides interface to Eiffel `emitter'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER

create
	make

feature {NONE} -- Initialization

	make (a_path, a_runtime_version: STRING) is
			-- Create new instance of IL_EMITTER
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
			a_runtime_version_not_void: a_runtime_version /= Void
			a_runtime_version_not_empty: not a_runtime_version.is_empty
		do
			implementation := (create {EMITTER_FACTORY}).new_emitter (a_runtime_version)
			if implementation /= Void then
				implementation.initialize_with_path (create {UNI_STRING}.make (a_path), create {UNI_STRING}.make (a_runtime_version))
			end
		end

feature -- Status report

	exists: BOOLEAN is
		do
			Result := implementation /= Void
		end

	is_initialized: BOOLEAN is
			-- Is consumer initialized for given path?
		require
			exists: exists
		do
			Result := implementation.is_initialized
		end

	assembly_found: BOOLEAN
			-- Was last research with `retrieve_assembly_info' successful?

feature -- Access

	name: STRING is
			-- Version of current assembly.
		require
			assembly_found: assembly_found
		do
			Result := assembly_info.name
		end

	version: STRING is
			-- Version of current assembly.
		require
			assembly_found: assembly_found
		do
			Result := assembly_info.version
		end

	culture: STRING is
			-- Culture of current assembly.
		require
			assembly_found: assembly_found
		do
			Result := assembly_info.culture
		end

	public_key_token: STRING is
			-- Culture of current assembly.
		require
			assembly_found: assembly_found
		do
			Result := assembly_info.public_key_token
		end

	is_in_gac: BOOLEAN is
			-- Was assembly consumed from the GAC?
		require
			assembly_found
		do
			Result := assembly_info.is_in_gac
		end

	is_consumed: BOOLEAN is
			-- Has assembly been consumed
		require
			assembly_found: assembly_found
		do
			Result := assembly_info.is_consumed
		end

	consumed_folder_name: STRING is
			-- Path to consumed assembly folder
		require
			assembly_found: assembly_found
		do
			Result := assembly_info.consumed_folder_name
		end

feature -- Retrieval

	relative_folder_name (a_name, a_version, a_culture, a_key: STRING): STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_name: UNI_STRING
			l_version: UNI_STRING
			l_culture: UNI_STRING
			l_key: UNI_STRING
			l_res: UNI_STRING
		do
			create l_name.make (a_name)
			if a_version /= Void and not a_version.is_empty then
				create l_version.make (a_version)
				if a_culture /= Void and not a_culture.is_empty then
					create l_culture.make (a_culture)
					if a_key /= Void and not a_key.is_empty then
						create l_key.make (a_key)
					end
				end
			end
			l_res := implementation.relative_folder_name (l_name, l_version, l_culture, l_key)
			if l_res /= Void then
				Result := l_res.string
			end
		ensure
			non_void_result: Result /= Void
			non_empty_result: not Result.is_empty
		end

	relative_folder_name_from_path (a_path: STRING): STRING is
			-- Relative path to consumed assembly metadata given `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_res: UNI_STRING
		do
			l_res := implementation.relative_folder_name_from_path (create {UNI_STRING}.make (a_path))
			if l_res /= Void then
				Result := l_res.string
			end
		ensure
			non_void_result: Result /= Void
			non_empty_result: not Result.is_empty
		end

	retrieve_assembly_info (a_path: STRING) is
			-- Retrieve data about assembly stored at `an_assembly'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_uni: UNI_STRING
		do
			create l_uni.make (a_path)
			assembly_info := implementation.assembly_info_from_assembly (l_uni)
			assembly_found := assembly_info /= Void
		end

	retrieve_assembly_info_by_fusion_name (a_name, a_version, a_culture, a_key: STRING) is
			-- Retrieve data about assembly stored using an assembly's fusion name.

		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_version_attached: a_version /= Void
			not_a_version_is_empty: not a_version.is_empty
			not_a_culture_is_empty: a_culture /= Void implies not a_culture.is_empty
			not_a_key_is_empty: a_key /= Void implies not a_key.is_empty
		local
			l_name: UNI_STRING
			l_version: UNI_STRING
			l_culture: UNI_STRING
			l_key: UNI_STRING
			l_res: UNI_STRING
		do
			create l_name.make (a_name)
			if a_version /= Void and not a_version.is_empty then
				create l_version.make (a_version)
				if a_culture /= Void and not a_culture.is_empty then
					create l_culture.make (a_culture)
					if a_key /= Void and not a_key.is_empty then
						create l_key.make (a_key)
					end
				end
			end
			assembly_info := implementation.assembly_info (l_name, l_version, l_culture, l_key)
			assembly_found := assembly_info /= Void
		end

	unload is
			-- unload all used resources
		do
			implementation.unload
		end

feature -- XML generation

	consume_assembly_from_path (a_path: STRING) is
			-- Consume local assembly `a_assembly' and all of its dependencies into EAC
		require
			exists: exists
			non_void_path: a_path /= Void
			non_empty_path: not a_path.is_empty
		do
			implementation.consume_assembly_from_path (
				create {UNI_STRING}.make (a_path))
		end

	consume_assembly (a_name, a_version, a_culture, a_key: STRING) is
			-- consume an assembly into the EAC from assemblyy defined by
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			exists: exists
			non_void_name: a_name /= Void
			non_void_version: a_version /= Void
			non_void_culture: a_culture /= Void
			non_void_key: a_key /= Void
			non_empty_name: not a_name.is_empty
			non_empty_version: not a_version.is_empty
			non_empty_culture: not a_culture.is_empty
			non_empty_key: not a_key.is_empty
		do
			implementation.consume_assembly (
				create {UNI_STRING}.make (a_name),
				create {UNI_STRING}.make (a_version),
				create {UNI_STRING}.make (a_culture),
				create {UNI_STRING}.make (a_key))
		end

feature {NONE} -- Implementation

	implementation: COM_CACHE_MANAGER
			-- Com object to get information about assemblies and emitting them.

	assembly_info: COM_ASSEMBLY_INFORMATION;
			-- Associated information about currently analyzed assembly.

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

end -- class IL_EMITTER
