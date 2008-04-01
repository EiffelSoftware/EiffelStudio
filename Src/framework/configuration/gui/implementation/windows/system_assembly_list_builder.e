indexing
	description: "[
		A class to perform a system search for all assemblies registered as locatable.
		Locatable does not refer to the Globabl Assembly Cache but assemblies that are found
		in folders registers as an Assembly Folder in the registry.
	]"
	date:        "$Date$"
	revision:    "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	SYSTEM_ASSEMBLY_LIST_BUILDER

create
	make

feature

	make (a_fw_folder: like framework_folder; a_clr_version: like clr_version)
			-- Create
		require
			a_fw_folder_attached: a_fw_folder /= Void
			not_a_fw_folder_is_empty: not a_fw_folder.is_empty
			a_fw_folder_has_no_trailing_separator: a_fw_folder.item (a_fw_folder.count) /= operating_environment.directory_separator
			a_clr_version_attached: a_clr_version /= Void
			not_a_clr_version_is_empty: not a_clr_version.is_empty
			a_clr_version_has_v_prefix: (a_clr_version.item (1)).as_lower = 'v'
		do
			framework_folder := a_fw_folder
			clr_version := a_clr_version
		ensure
			framework_folder_set: framework_folder = a_fw_folder
			clr_version_set: clr_version = a_clr_version
		end

feature -- Access

	framework_folder: STRING_32
			-- Location of .NET framework folder

	clr_version: STRING_32
			-- 'v' prefixed version of CLR

	assembly_folders: LIST [STRING_32]
			-- List of current assembly folder
		local
			l_result: like internal_assembly_folders
		do
			Result := internal_assembly_folders
			if Result = Void then
				create l_result.make (1)
				l_result.extend (framework_folder)
				l_result.append (folders_from_path (assembly_folders_registry_path))
				l_result.append (folders_from_path (versioned_registry_root_path))
				internal_assembly_folders := l_result
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			internal_assembly_folders_set: internal_assembly_folders = Result
		end

	assemblies: ARRAYED_LIST [STRING_8]
			-- Flat list of all assemblies in all `assembly_folders'.
		local
			l_folders: like assembly_folders
			l_folder: STRING_32
			l_cursor: CURSOR
			l_dir: DIRECTORY
			l_content: LIST [STRING_8]
			l_item: STRING_8
			l_pe_info: PE_FILE_INFO
			l_fn: FILE_NAME
			l_file: RAW_FILE
			l_ext: STRING
			l_count: INTEGER_32
		do
			create Result.make (30)
			l_folders := assembly_folders
			if not l_folders.is_empty then
				create l_pe_info
				l_cursor := l_folders.cursor
				from l_folders.start until l_folders.after loop
					l_folder := l_folders.item
					check l_folder_has_no_trailing_separator: l_folder.item (l_folder.count) /= operating_environment.directory_separator end
					create l_dir.make (l_folder)
					if l_dir.exists then
						l_content := l_dir.linear_representation
						from l_content.start until l_content.after loop
							l_item := l_content.item
							l_count := l_item.count
							if l_count > 4 then
								l_ext := l_item.substring (l_count - 3, l_count)
								l_ext.to_lower
								if l_ext.is_equal (dll_extension) then
										-- Must have .dll
									create l_fn.make
									l_fn.set_directory (l_folder)
									l_fn.set_file_name (l_item)
									create l_file.make (l_fn)
									if l_file.exists and then not l_file.is_directory and then l_pe_info.is_com2_pe_file (l_fn) then
										Result.extend (l_fn)
									end
								end
							end
							l_content.forth
						end
					end
					l_folders.forth
				end
				l_folders.go_to (l_cursor)
			end
		ensure
			result_attached: Result /= Void
		end

	assemblies_properties: LIST [ASSEMBLY_PROPERTIES] is
			-- A flat list of assembly properties
		local
			l_files: like assemblies
			l_cursor: CURSOR
			l_result: SORTED_TWO_WAY_LIST [ASSEMBLY_PROPERTIES]
			l_props: ASSEMBLY_PROPERTIES
			l_reader: ASSEMBLY_PROPERTIES_READER
		do
			l_files := assemblies
			create l_result.make
			if not l_files.is_empty then
				create l_reader.make (clr_version)
				l_cursor := l_files.cursor
				from l_files.start until l_files.after loop
					l_props := l_reader.retrieve_assembly_properties (l_files.item)
					if l_props /= Void then
						l_result.extend (l_props)
					end
					l_files.forth
				end
				l_files.go_to (l_cursor)
			end
			l_result.sort
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Registry Searching

	folders_from_path (a_reg_path: STRING_32): ARRAYED_LIST [STRING_32]
			-- Retrieve list of paths from reqistry path `a_reg_path'
		require
			a_reg_path_attached: a_reg_path /= Void
			not_a_reg_path_is_empty: not a_reg_path.is_empty
		local
			l_reg: WEL_REGISTRY
			l_key: WEL_REGISTRY_KEY
			l_value: WEL_REGISTRY_KEY_VALUE
			l_path: STRING_32
			l_p: POINTER
			l_subp: POINTER
			l_separator: CHARACTER
			l_count: INTEGER_32
			i: INTEGER_32
		do
			create l_reg
			l_p := l_reg.open_key ({WEL_REGISTRY}.hkey_local_machine, a_reg_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
			if l_p /= default_pointer then
				l_separator := operating_environment.directory_separator
				l_count := l_reg.number_of_subkeys (l_p)
				create Result.make (l_count)
				from i := 0 until i = l_count loop
					l_key := l_reg.enumerate_key (l_p, i)
					check l_key_attached: l_key /= Void end
					if l_key /= Void then
						l_subp := l_reg.open_key (l_p, l_key.name, {WEL_REGISTRY_ACCESS_MODE}.key_read)
						if l_subp /= default_pointer then
							l_value := l_reg.key_value (l_subp, once "")
							if l_value /= Void then
								l_path := l_value.string_value
								if not l_path.is_empty then
									l_path.prune_all_trailing (l_separator)
									Result.extend (l_path)
								end
							end
							l_reg.close_key (l_subp)
						end
					end
					i := i + 1
				end
				l_reg.close_key (l_p)
			else
				create Result.make (0)
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Registry Paths

	registry_root_path: STRING_32
			-- Root registry path to use for a given bit platform
		once
			if is_windows_64_bits then
					-- There are no 64bit keys!
				Result := "SOFTWARE\Wow6432Node\Microsoft\.NETFramework\"
			else
				Result := "SOFTWARE\Microsoft\.NETFramework\"
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	assembly_folders_registry_path: STRING_32
			-- Default assembly folders look up path
		local
			l_root: like registry_root_path
		once
			l_root := registry_root_path
			create Result.make (l_root.count + 16)
			Result.append (l_root)
			Result.append ("AssemblyFolders")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	versioned_registry_root_path: STRING_32
			-- Assemblies folder registry root for `clr_version' version or CLR.
		local
			l_root: like registry_root_path
			l_version: like clr_version
		do
			Result := internal_versioned_registry_root_path
			if Result = Void then
				l_root := registry_root_path
				l_version := clr_version
				create Result.make (l_root.count + l_version.count + 18)
				Result.append (l_root)
				Result.append (clr_version)
				Result.append (once "\AssemblyFoldersEx")
				internal_versioned_registry_root_path := Result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			internal_versioned_registry_root_path_set: internal_versioned_registry_root_path = Result
		end

feature {NONE} -- Externals

	is_windows_64_bits: BOOLEAN is
			-- Is Current running on Windows 64 bits?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_64_BITS"
		end

feature {NONE} -- Constants

	dll_extension: STRING is ".dll"
			-- DLL file extension

feature {NONE} -- Internal Implementation Cache

	internal_assembly_folders: ARRAYED_LIST [STRING_32]
			-- Cached version of `assembly_folders'
			-- Note: Do not use directly!

	internal_versioned_registry_root_path: like versioned_registry_root_path
			-- Cached version of `versioned_registry_root_path'
			-- Note: Do not use directly!

invariant
	framework_folder_attached: framework_folder /= Void
	not_framework_folder_is_empty: not framework_folder.is_empty
	clr_version_attached: clr_version /= Void
	not_clr_version_is_empty: not clr_version.is_empty
	clr_version_has_v_prefix: (clr_version.item (1)).as_lower = 'v'

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

end -- class {SYSTEM_ASSEMBLY_LIST_BUILDER}
