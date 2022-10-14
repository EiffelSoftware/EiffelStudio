note
	description: "Simplistic interface for client assemblies"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CACHE_MANAGER

inherit
	EMITTER
		rename
			make as make_emitter
		export
			{NONE} all
			{CACHE_MANAGER} clr_version
			{ANY} cache_writer
		end

	SHARED_ASSEMBLY_LOADER

	CACHE_MANAGER_ERRORS
		export
			{NONE} all
		end

	SHARED_CACHE_MUTEX_GUARD
		export
			{NONE} all
		end

create
	make,
	make_with_path

feature {NONE}-- Initialization

	make
			-- create an instance of CACHE_MANAGER
		do
			if notifier = Void then
				create {FORM_NOTIFIER} notifier.make
			end
			guard.set_notifier (notifier)

			is_successful := True
			create last_error_message.make_empty
			create cache_writer.make
		end

	make_with_path (a_path: PATH)
			-- create instance of CACHE_MANAGER with ISE_EIFFEL path set to `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {DIRECTORY}.make_with_path (a_path)).exists
		do
			set_internal_eiffel_cache_path (a_path)
			make
		end

feature -- Clean Up

	unload
			-- Unloads all loaded assemblies and releases any
			-- resources. This is not a dispose so and cleaned up
			-- resources should be able to be resurected.

		do
			if attached notifier as l_notifier then
				l_notifier.dispose
				notifier := Void
			end
			cache_writer.dispose
			assembly_loader.release_cached_data
		end

feature -- Access

	is_successful: BOOLEAN

	last_error_message: STRING_32
		-- last error message

feature -- Basic Oprtations

	consume_assembly (a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32; a_info_only: BOOLEAN)
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_assembly: detachable ASSEMBLY
			l_resolver: CONSUMER_AGUMENTED_RESOLVER
			l_current_domain: detachable APP_DOMAIN
			l_loc: STRING_32
		do
			is_successful := True
			create last_error_message.make_empty

			l_assembly := assembly_loader.load_from_full_name (fully_quantified_name (a_name, a_version, a_culture, a_key))
			if l_assembly /= Void and then attached l_assembly.location as l_location then
				create l_loc.make_from_cil (l_location)
				create l_resolver.make (create {ARRAYED_LIST [STRING_32]}.make (0))
				if attached {RUNTIME_ENVIRONMENT}.get_runtime_directory as l_runtime_dir then
					l_resolver.add_resolve_path (create {STRING_32}.make_from_cil (l_runtime_dir))
				end
				l_resolver.add_resolve_path_from_file_name (l_loc)
				l_current_domain := {APP_DOMAIN}.current_domain
				if attached l_current_domain then
					resolve_subscriber.subscribe (l_current_domain, l_resolver)
				else
					check
						from_documentation: False
					then
					end
				end
				assembly_loader.set_resolver (l_resolver)
				cache_writer.add_assembly_ex (l_loc, a_info_only, Void, create {ARRAYED_LIST [READABLE_STRING_32]}.make (0))
				assembly_loader.set_resolver (Void)
				if attached l_current_domain then
					resolve_subscriber.unsubscribe (l_current_domain, l_resolver)
				end
			end
		ensure
			successful: is_successful
		end

	consume_assembly_from_path (a_path: READABLE_STRING_32; a_info_only: BOOLEAN; a_references: detachable READABLE_STRING_32)
			-- Consume assembly located `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_paths: LIST [READABLE_STRING_32]
			l_resolver: CONSUMER_AGUMENTED_RESOLVER
			l_processed: ARRAYED_LIST [READABLE_STRING_32]
			l_refs: LIST [READABLE_STRING_32]
			l_files: ARRAYED_LIST [READABLE_STRING_32]
			l_current_domain: APP_DOMAIN
		do
			is_successful := True
			create last_error_message.make_empty

			l_paths := a_path.split (';')
			l_paths.compare_objects

			create l_files.make (30)
			if attached {RUNTIME_ENVIRONMENT}.get_runtime_directory as l_runtime_dir then
				l_files.extend (create {STRING_32}.make_from_cil (l_runtime_dir))
			end
			l_files.append (l_paths)

			if a_references /= Void then
					-- For now, references are file references!
				l_refs := a_references.split (';')
				l_files.append (l_refs)
			end

				-- Prune all empty paths
			from l_files.start until l_files.after loop
				if l_files.item.is_empty then
					l_files.remove
				else
					l_files.forth
				end
			end

			create l_resolver.make (l_files)
			l_current_domain := {APP_DOMAIN}.current_domain
			if attached l_current_domain then
				resolve_subscriber.subscribe (l_current_domain, l_resolver)
			else
				check
					from_documentation: False
				then
				end
			end

			create l_processed.make (l_paths.count * 3)
			l_processed.compare_objects

			from
				l_paths.start
			until
				l_paths.after
			loop
				l_resolver.add_resolve_path_from_file_name (l_paths.item)
				assembly_loader.set_resolver (l_resolver)
				cache_writer.add_assembly_ex (l_paths.item, a_info_only, l_paths, l_processed)
				assembly_loader.set_resolver (Void)
				l_resolver.remove_resolve_path_from_file_name (l_paths.item)
				l_paths.forth
			end
			if attached l_current_domain then
				resolve_subscriber.unsubscribe (l_current_domain, l_resolver)
			end
		ensure
			successful: is_successful
		end

	relative_folder_name (a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32): detachable PATH
			-- returns the relative path to an assembly using at least `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_ca: detachable CONSUMED_ASSEMBLY
		do
			l_ca := assembly_info (a_name, a_version, a_culture, a_key)
			if l_ca /= Void then
				Result := relative_assembly_path_from_consumed_assembly (l_ca)
			end
		end

	relative_folder_name_from_path (a_path: READABLE_STRING_32): detachable PATH
			-- Relative path to consumed assembly metadata given `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: detachable CONSUMED_ASSEMBLY
			l_assembly: detachable ASSEMBLY
		do
			l_assembly := assembly_loader.load_from (a_path)
			if l_assembly /= Void and then attached l_assembly.location as l_location then
				l_ca := cache_writer.consumed_assembly_from_path (create {STRING_32}.make_from_cil (l_location))
			end
			if l_ca = Void then
					-- Try load assembly from GAC
				l_assembly := assembly_loader.load_from_gac_or_path (a_path)
				if l_assembly /= Void and then attached l_assembly.location as l_location then
					l_ca := cache_writer.consumed_assembly_from_path (create {STRING_32}.make_from_cil (l_location))
				end
			end
			if l_ca /= Void then
				Result := relative_assembly_path_from_consumed_assembly (l_ca)
			end
		end

	assembly_info_from_path (a_path: PATH): detachable CONSUMED_ASSEMBLY
			-- retrieve a local assembly's information.
			-- If assembly has already been consumed then function will
			-- return found matching CONSUMED_ASSEMBLY.
			-- If you need to use resulting CONSUMED_ASSEMBLY.folder_name
			-- then you need to query CONSUMED_ASSEMBLY.is_consumed = True to
			-- know that that name exists.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			Result := cache_writer.consumed_assembly_from_path (a_path.name)
		end

	assembly_info (a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32): detachable CONSUMED_ASSEMBLY
			-- retrieve a assembly's information.
			-- If assembly has already been consumed then function will
			-- return found matching CONSUMED_ASSEMBLY.
			-- If you need to use resulting CONSUMED_ASSEMBLY.folder_name
			-- then you need to query CONSUMED_ASSEMBLY.is_consumed = True to
			-- know that that name exists.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_assembly: detachable ASSEMBLY
		do
			l_assembly := assembly_loader.load_from_full_name (fully_quantified_name (a_name, a_version, a_culture, a_key))
			if l_assembly /= Void and then attached l_assembly.location as l_location then
				Result := cache_writer.consumed_assembly_from_path (create {STRING_32}.make_from_cil (l_location))
			end
		end

feature {NONE} -- Basic Operations

	fully_quantified_name (a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32): STRING_32
			-- returns "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make_from_string (a_name)
			if a_version /= Void and then not a_version.is_empty then
				Result.append_string_general (", Version=")
				Result.append_string (a_version)
				if a_culture /= Void and then not a_culture.is_empty then
					if not a_culture.is_case_insensitive_equal (neutral_culture) then
						Result.append_string_general (", Culture=")
						Result.append (a_culture)
					end
				end
				if a_key /= Void and then not a_key.is_empty then
					Result.append_string_general (", PublicKeyToken=")
					Result.append (a_key)
				end
			end
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

feature {NONE} -- Constants

	neutral_culture: STRING_32 = "neutral"

feature {NONE} -- Implementation

	notifier: detachable NOTIFIER
			-- Notifier used to notifer user of cache operations.

invariant
	cache_writer_not_void: cache_writer /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
