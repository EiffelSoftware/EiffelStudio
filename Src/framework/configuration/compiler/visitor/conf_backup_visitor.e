note
	description: "Visitor that adapts a configuration so that it accesses the information from the backup directory."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_BACKUP_VISITOR

inherit
	CONF_ITERATOR
		redefine
			process_cluster,
			process_override,
			process_library,
			process_precompile,
			process_assembly
		end

	CONF_CONSTANTS
		export
			{NONE} all
		end

	CONF_ACCESS

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make (directory: like backup_directory)
			-- Initialize with backup directory `directory`.
		do
			backup_directory := directory
		ensure
			backup_directory_set: backup_directory = directory
		end

feature -- Access

	backup_directory: PATH
			-- Location of the backup.

	is_il_generation: BOOLEAN
			-- Are we processing backup for a project compiled for IL code generation?

feature -- Update

	set_is_il_generation (v: BOOLEAN)
			-- Set `is_il_generation' to `v'
		do
			is_il_generation := v
		ensure
			is_il_generation_set: is_il_generation = v
		end

feature -- Visit nodes

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Visit `a_cluster'.
		local
			l_loc: CONF_DIRECTORY_LOCATION
			u: FILE_UTILITIES
		do
			create l_loc.make (a_cluster.name, a_cluster.target)
			a_cluster.set_location (l_loc)
			u.create_directory_path (l_loc.evaluated_path)
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Visit `an_override'.
		do
			process_cluster (an_override)
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		local
			l_loc: CONF_FILE_LOCATION
			l_load: CONF_LOAD
			l_fact: CONF_FACTORY
		do
			create l_fact
			create l_load.make (l_fact)
			l_load.retrieve_uuid (a_library.path)
			if not l_load.is_error and then attached l_load.last_uuid as uuid then
				create l_loc.make ("..\"+uuid.out+"\"+backup_adapted_config_file, a_library.target)
				a_library.set_location (l_loc)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Visit `a_precompile'.
		do
			process_library (a_precompile)
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Visit `an_assembly'.
		local
			l_as: PATH
			l_new_as: STRING_32
			l_loc: CONF_FILE_LOCATION
			f: FILE_UTILITIES
		do
				-- If we are in IL code generation and that we do not handle assemblies specified by their name, version, public token, culture
				-- we need to copy the assembly.
			if is_il_generation and then not an_assembly.is_non_local_assembly then
					-- Assembly was specifed as a path but actually is a GAC assembly, we skip it.
				if attached {CONF_PHYSICAL_ASSEMBLY} an_assembly.physical_assembly as l_assembly and then l_assembly.is_in_gac then
				else
					l_as := an_assembly.location.evaluated_path
					if not l_as.is_empty then
						l_new_as := an_assembly.location.evaluated_file
						create l_loc.make ({STRING_32} "..\" + l_new_as, an_assembly.target)
						an_assembly.set_location (l_loc)
							-- copy assembly
						f.copy_file_path (l_as, backup_directory.extended (l_new_as))
					end
				end
			end
		end
note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
