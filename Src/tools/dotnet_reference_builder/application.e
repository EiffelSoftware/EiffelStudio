note
	description: "[
		Actual application entry point.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	APPLICATION

inherit
	AR_SHARED_SUBSCRIBER
		export
			{NONE} all
		end

	KEY_ENCODER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

feature -- Access

	loaded_assemblies: ARRAYED_LIST [ASSEMBLY]
			-- List of assemblies that have been loaded in current domain
		once
			create Result.make (30)
		ensure
			result_attached: Result /= Void
		end

	failed_loaded_assemblies: ARRAYED_LIST [STRING]
			-- List of assembly names that failed to load in current domain
		once
			create Result.make (5)
			Result.compare_objects
		ensure
			result_attached: Result /= Void
			result_compares_objects: Result.object_comparison
		end

feature {NONE} -- Basic Operations

	start (a_parser: ARGUMENT_PARSER)
			-- Start application
		local
			l_resolver: like resolver
			l_assembly: like load_assembly
			l_assemblies: LIST [STRING]
			l_loaded_assemblies: ARRAYED_LIST [ASSEMBLY]
			l_located_asms: ARRAYED_LIST [LOCATED_ASSEMBLY]
			l_modifier: ECF_MODIFIER
			l_errors: LIST [STRING]
		do
			l_resolver := resolver
			resolve_subscriber.subscribe ({APP_DOMAIN}.current_domain, l_resolver)
			l_assemblies := a_parser.assemblies
			if a_parser.use_assembly_locations then
				l_assemblies.do_all (agent (a_resolver: AR_RESOLVER; a_item: STRING)
					require
						a_resolver_attached: a_resolver /= Void
						a_item_attached: a_item /= Void
						not_a_item_is_empty: not a_item.is_empty
						a_item_exists: (create {RAW_FILE}.make (a_item)).exists
					do
						a_resolver.add_resolve_path_from_file_name (a_item)
					end (l_resolver, ?))
			end
			a_parser.include_paths.do_all (agent (a_resolver: AR_RESOLVER; a_item: STRING)
				require
					a_resolver_attached: a_resolver /= Void
					a_item_attached: a_item /= Void
					not_a_item_is_empty: not a_item.is_empty
					a_item_exists: (create {DIRECTORY}.make (a_item)).exists
				do
					a_resolver.add_resolve_path (a_item)
				end (l_resolver, ?))

				-- Build list of found assemblies
			create l_loaded_assemblies.make (l_assemblies.count)
			from l_assemblies.start until l_assemblies.after loop
				l_assembly := load_assembly (l_assemblies.item)
				if l_assembly = Void then
					failed_loaded_assemblies.extend (l_assemblies.item)
				else
					l_loaded_assemblies.extend (l_assembly)
				end
				l_assemblies.forth
			end

			load_all_assemblies (l_loaded_assemblies)
			l_loaded_assemblies := loaded_assemblies

				-- Generate list of located assemblies from loaded assemblies
			create l_located_asms.make (loaded_assemblies.count)
			l_loaded_assemblies.do_all (agent (a_list: ARRAYED_LIST [LOCATED_ASSEMBLY]; a_item: ASSEMBLY)
				require
					a_list_attached: a_list /= Void
					a_item_attached: a_item /= Void
				do
					a_list.extend (create_located_assembly (a_item))
				end (l_located_asms, ?))

				-- Write quick report
			io.put_string ("Assembly dependency report:%N%N")
			write_report (io.output, l_located_asms, failed_loaded_assemblies)

			if a_parser.modify_ecf_file then
					-- Modify ecf file
				if failed_loaded_assemblies.is_empty then
					io.put_string ("%NModifying ECF file...")
					create l_modifier
					l_modifier.modify (a_parser.ecf_file, a_parser.ecf_targets_file, l_located_asms)
					if l_modifier.successful then
						io.put_string (" ...done.%N")
					else
						io.put_string (" ...error modifing ECF file:%N")
						l_errors := l_modifier.errors
						from l_errors.start until l_errors.after loop
							io.put_string ("  > " + l_errors.item + "%N")
							l_errors.forth
						end
					end
				else
					io.put_string ("No modification has taken place because of unresolved assembly reference.%N")
						-- Failure
					{ENVIRONMENT}.exit (-1)
				end
			end
		end

feature {NONE} -- Output

	write_report (a_writer: IO_MEDIUM; a_located: LIST [LOCATED_ASSEMBLY]; a_failed: LIST [STRING])
			-- Writes loaded/failed report to `a_writer'.
		require
			a_writer_attached: a_writer /= Void
			a_writer_writable: a_writer.is_open_write
			a_located_attached: a_located /= Void
			a_failed_attached: a_failed /= Void
		local
			l_cursor: CURSOR
		do
			if not a_located.is_empty then
				a_writer.put_string ("Loaded assemblies (" + a_located.count.out + "):%N%N")
				l_cursor := a_located.cursor
				from a_located.start until a_located.after loop
					a_writer.put_string (a_located.item.real_path)
					a_writer.new_line
					a_located.forth
				end
				a_located.go_to (l_cursor)
			end
			if not a_failed.is_empty then
				if not a_located.is_empty then
					a_writer.new_line
				end
				a_writer.put_string ("Failed loaded assemblies (" + a_failed.count.out + "):%N%N")
				l_cursor := a_failed.cursor
				from a_failed.start until a_failed.after loop
					a_writer.put_string (a_failed.item)
					a_writer.new_line
					a_failed.forth
				end
				a_failed.go_to (l_cursor)
			end
		ensure
			a_located_unmoved: a_located.cursor.is_equal (old a_located.cursor)
			a_failed_unmoved: a_failed.cursor.is_equal (old a_failed.cursor)
		end

feature {NONE} -- Reflection

	load_assembly (a_path: STRING): ASSEMBLY
			-- Loads assembly from path `a_path'
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {ASSEMBLY}.reflection_only_load_from (a_path)
			end
		rescue
			retried := True
			retry
		end

	load_assembly_from_name (a_name: ASSEMBLY_NAME): ASSEMBLY
			-- Loads assembly from assembly name `a_name'
		require
			a_name_attached: a_name /= Void
		local
			l_fn: STRING
			retried: BOOLEAN
			retried_again: BOOLEAN
		do
			if not retried_again then
				if not retried then
					Result := {ASSEMBLY}.reflection_only_load (a_name.to_string)
				else
						-- Default app domain resolution does not work when loading in a reflection only context.
					l_fn := resolver.resolve_by_assembly_name ({APP_DOMAIN}.current_domain, a_name)
					if l_fn /= Void then
						Result := load_assembly (l_fn)
					end
				end
			end
		rescue
			retried_again := retried
			retried := True
			retry
		end

	load_all_assemblies (a_asms: LIST [ASSEMBLY])
			-- Adds all assemblies and referenced assemblies in `a_asms' to `loaded_assemblies' or `failed_loaded_assemblies' list
			-- depending on the result of them loading.
		require
			a_asms_attached: a_asms /= Void
			not_a_asms_is_empty: not a_asms.is_empty
			loaded_assemblies_attached: loaded_assemblies /= Void
			failed_loaded_assemblies_attached: failed_loaded_assemblies /= Void
		local
			l_cursor: CURSOR
		do
			l_cursor := a_asms.cursor
			from a_asms.start until a_asms.after loop
				loaded_assemblies.extend (a_asms.item)
				load_all_reference_assemblies (a_asms.item)
				a_asms.forth
			end
			a_asms.go_to (l_cursor)
		ensure
			a_asms_unmoved: a_asms.cursor.is_equal (old a_asms.cursor)
		end

	load_all_reference_assemblies (a_asm: ASSEMBLY)
			-- Adds all referenced assemblies of `a_asm' to `loaded_assemblies' or `failed_loaded_assemblies' list
			-- depending on the result of them loading.
		require
			a_asm_attached: a_asm /= Void
			loaded_assemblies_attached: loaded_assemblies /= Void
			failed_loaded_assemblies_attached: failed_loaded_assemblies /= Void
		local
			l_refs: NATIVE_ARRAY [ASSEMBLY_NAME]
			l_assembly: ASSEMBLY
			l_name: ASSEMBLY_NAME
			l_count: INTEGER
			i: INTEGER
		do
			l_refs := a_asm.get_referenced_assemblies
			l_count := l_refs.count
			from i := 0 until i = l_count loop
				l_name := l_refs.item (i)
				l_assembly := load_assembly_from_name (l_name)
				if l_assembly /= Void then
					if not loaded_assemblies.has (l_assembly) then
						loaded_assemblies.extend (l_assembly)
						load_all_reference_assemblies (l_assembly)
					end
				else
					failed_loaded_assemblies.extend (l_name.to_string)
				end
				i := i + 1
			end
		end

feature {NONE} -- Resolution

	resolver: AR_RESOLVER
			-- Resolver used to resolve referenced assemblies
		local
			l_folders: like assembly_folders
			l_cursor: CURSOR
		once
			create Result.make_with_name ("Main")
				-- Remove default added assembly location path.
			Result.remove_resolve_path_from_file_name ((({SYSTEM_OBJECT})[Current]).get_type.assembly.location)

				-- Assembly assembly folder paths
			l_folders := assembly_folders
			l_cursor := l_folders.cursor
			from l_folders.start until l_folders.after loop
				Result.add_resolve_path (l_folders.item)
				l_folders.forth
			end
			l_folders.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Registry access

	assembly_folders: LIST [STRING]
			-- Retrieve list of assembly folders from registry
		local
			l_result: ARRAYED_LIST [STRING]
			l_key: REGISTRY_KEY
			l_folders_key: REGISTRY_KEY
		once
			create l_result.make (10)
			l_result.extend ({RUNTIME_ENVIRONMENT}.get_runtime_directory)
			l_key := {REGISTRY}.local_machine
			l_key := l_key.open_sub_key (framework_reg_key)
			if l_key /= Void then
					-- Add extended folders
				l_folders_key := l_key.open_sub_key ({SYSTEM_STRING}.concat_string_string ({RUNTIME_ENVIRONMENT}.get_system_version, "\AssemblyFoldersEx"))
				if l_folders_key /= Void then
					add_key_content (l_folders_key, l_result)
					l_folders_key.close
				end
					-- Add regular folders
				l_folders_key := l_key.open_sub_key ("AssemblyFolders")
				if l_folders_key /= Void then
					add_key_content (l_folders_key, l_result)
					l_folders_key.close
				end
				l_key.close
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

	add_key_content (a_key: REGISTRY_KEY; a_list: ARRAYED_LIST [STRING])
			-- Adds default values of all subkeys in `a_key' to `a_list'.
		require
			a_key_attached: a_key /= Void
			a_list_attached: a_list /= Void
		local
			l_sub_key: REGISTRY_KEY
			l_value: SYSTEM_STRING
			l_names: NATIVE_ARRAY [SYSTEM_STRING]
			l_count: INTEGER
			i: INTEGER
		do
			l_names := a_key.get_sub_key_names
			l_count := l_names.count
			from until i = l_count loop
				l_sub_key := a_key.open_sub_key (l_names.item (i))
				check l_sub_key_attached: l_sub_key /= Void end
				if l_sub_key /= Void then
					l_value ?= l_sub_key.get_value ("")
					a_list.extend (l_value)
					l_sub_key.close
				end
				i := i + 1
			end
		end

	framework_reg_key: SYSTEM_STRING
			-- Retrieves .NET framework registry key.
		once
			if {DOTNET_POINTER}.get_size = 8 then
				Result := "SOFTWARE\Wow6432Node\Microsoft\.NETFramework"
			else
				Result := "SOFTWARE\Microsoft\.NETFramework"
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: Result.length > 0
		end

feature -- Factory functions

	create_located_assembly (a_asm: ASSEMBLY): LOCATED_ASSEMBLY
			-- Creates a located assembly from assembly `a_asm'
		require
			a_asm_attached: a_asm /= Void
		local
			l_path: STRING
			l_name: ASSEMBLY_NAME
			l_pkt: NATIVE_ARRAY [NATURAL_8]
			l_key: STRING
		do
			if a_asm.global_assembly_cache then
				l_name := a_asm.get_name
				l_pkt := l_name.get_public_key_token
				if l_pkt /= Void then
					l_key := encoded_key (l_pkt)
				end
				l_path := resolver.resolve_by_name ({APP_DOMAIN}.current_domain, l_name.name, l_name.version.to_string, l_name.culture_info.to_string, l_key)
			end
			if l_path = Void then
				l_path := a_asm.location
			end
			create Result.make (a_asm, l_path)
		ensure
			result_attached: Result /= Void
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

end -- class {APPLICATION}
