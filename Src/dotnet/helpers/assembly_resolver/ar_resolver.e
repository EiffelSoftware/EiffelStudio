indexing
	description: "[
		The simplest assembly resolver that will look for dependent assemblies
		in application/library base folder. Other folders will also be examined
		if explicitly added to resolver.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AR_RESOLVER

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make is
			-- Initialize instance
		do
			common_initialization
		end

	make_with_name (a_name: like friendly_name) is
			-- Initialize instance and set `friendly_name' with `a_name'
		require
			a_name_not_void: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			common_initialization
			friendly_name := a_name
		ensure
			friendly_name_set: friendly_name = a_name
		end

	common_initialization is
			-- Additional initialization.
		do
			create internal_resolve_paths.make (1)
			internal_resolve_paths.compare_objects
			add_current_assembly_path
			create resolve_event_handler.make (Current, $resolve)
		end

feature -- Access

	resolve_paths: LIST [STRING] is
			-- List of paths where a potential assembly dependency requiring resolution could be
		do
			Result := internal_resolve_paths
		ensure
			result_not_void: Result /= Void
			result_compares_objects: Result.object_comparison
		end

	friendly_name: STRING
			-- Resolver friendly name

feature {AR_SUBSCRIPTION} -- Access

	resolve_event_handler: RESOLVE_EVENT_HANDLER
			-- Retrieve an event handler for `Current'

feature {NONE} -- Resolution

	resolve (a_sender: SYSTEM_OBJECT; a_args: RESOLVE_EVENT_ARGS): ASSEMBLY is
			-- Event handler for System.AppDomain.AssemblyResolve event
		require
			a_send_not_void: a_sender /= Void
			a_args_not_void: a_args /= Void
		local
			l_domain: APP_DOMAIN
			l_parts: LIST [STRING]

		do
			l_domain ?= a_sender
			check
				l_domain_not_void: l_domain /= Void
			end

				-- Split assembly name to be resolved into relivent chunks
			l_parts := split_assembly_name (a_args.name)

				-- Attempt to resolve assembly dependency
			Result := resolve_by_name (l_domain, l_parts @ 1, l_parts @ 2, l_parts @ 3, l_parts @ 4)
		end

feature -- Resolution

	resolve_by_name (a_domain: APP_DOMAIN; a_name: STRING; a_version: STRING; a_culture: STRING; a_key: STRING): ASSEMBLY is
			-- Resolve an assembly in app domain `a_domain' where name of assembly comprises of assembly name `a_name'
			-- and optionally version `a_version', culture `a_culture' and public key token `a_key'
		require
			a_domain_not_void: a_domain /= Void
			a_name_not_void: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_version_is_empty: a_version /= Void implies not a_version.is_empty
		local
			l_cursor: CURSOR
			l_paths: like resolve_paths
			l_file_name: FILE_NAME
			l_name: ASSEMBLY_NAME
		do
			feature {SYSTEM_DLL_TRACE}.write_string ("Attempting to use custom assembly resolver")
			if friendly_name /= Void then
				feature {SYSTEM_DLL_TRACE}.write_string (" '" + friendly_name + "'")
			end
			feature {SYSTEM_DLL_TRACE}.write_line_string (".")

			l_paths := resolve_paths
			l_cursor := l_paths.cursor

			from
				l_paths.start
			until
				l_paths.after or Result /= Void
			loop
				feature {SYSTEM_DLL_TRACE}.write_line_string ("Looking in '" + l_paths.item + "'.")

				from
					assembly_extensions.start
				until
					assembly_extensions.after or Result /= Void
				loop
					create l_file_name.make_from_string (l_paths.item)
					l_file_name.set_file_name (a_name + assembly_extensions.item)
					feature {SYSTEM_DLL_TRACE}.write_line_string ("Looking for '" + l_file_name + "'.")
					if (create {RAW_FILE}.make (l_file_name)).exists then
						feature {SYSTEM_DLL_TRACE}.write_line_string ("Matching '" + l_file_name + "'.")
						l_name := get_assembly_name (l_file_name)
						if l_name /= Void then
							if does_name_match (l_name, a_name, a_version, a_culture, a_key) then
								feature {SYSTEM_DLL_TRACE}.write_line_string ("Attempting to load '" + l_file_name + "'.")
								Result := load_assembly (l_file_name)
							end
						end
					end
					assembly_extensions.forth
				end

				l_paths.forth
			end

			l_paths.go_to (l_cursor)
		ensure
			not_resolve_paths_moved: resolve_paths.cursor.is_equal (old resolve_paths.cursor)
		end

feature -- Query

	does_name_match (a_asm_name: ASSEMBLY_NAME; a_name: STRING; a_version: STRING; a_culture: STRING; a_key: STRING): BOOLEAN is
			-- Does `a_asm_name' match `a_name', `a_version', `a_culture' and `a_key'
		require
			a_asm_name_not_void: a_asm_name /= Void
			a_name_not_void: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_version_is_empty: a_version /= Void implies not a_version.is_empty
		local
			l_key: NATIVE_ARRAY [NATURAL_8]
		do
			Result := a_name.is_equal (a_asm_name.name)
			if Result and then a_version /= Void then
				Result := is_near_version_match (a_version, a_asm_name.version.to_string)
			end
			if Result and then a_culture /= Void then
				Result := a_culture.as_lower.is_equal (a_asm_name.culture_info.to_string.to_lower)
			end
			if Result and then a_key /= Void then
				l_key := a_asm_name.get_public_key_token
				if a_key.is_empty then
					Result := l_key = Void or else l_key.length = 0
				else
					Result := encoded_key (l_key).as_lower.is_equal (a_key.as_lower)
				end
			end
		end

	is_near_version_match (a_version: STRING; a_match_version: STRING): BOOLEAN is
			-- Is `a_match_version' a near enough match for `a_version'?
		require
			a_version_attached: a_version /= Void
			not_a_version_is_empty: not a_version.is_empty
			a_match_version_attached: a_match_version /= Void
			not_a_match_version_is_empty: not a_match_version.is_empty
		local
			l_parts_a: LIST [STRING]
			l_parts_b: LIST [STRING]
			l_count: INTEGER
			l_a: STRING
			l_b: STRING
			i: INTEGER
		do

			l_parts_a := a_version.split ('.')
			l_parts_b := a_match_version.split ('.')
			l_count := l_parts_a.count.min (l_parts_b.count)

				-- Must have major and minor version numbers
			Result := l_count > 2
			from
				i := 1
			until
				not Result or i > l_count
			loop
				l_a :=  l_parts_a[i]
				l_b :=  l_parts_b[i]

					-- Remove leading zeros (should not be there but you never know)
				l_a.prune_all_leading ('0')
				l_b.prune_all_leading ('0')
				if l_a.is_empty then
					l_a.append_character ('0')
				end
				if l_b.is_empty then
					l_b.append_character ('0')
				end

				Result := l_a.is_equal (l_b)

				i := i + 1
			end
		end


feature -- Extending

	add_resolve_path (a_path: STRING) is
			-- Adds `a_path' to list `resolve_paths'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			not_a_path_already_added: not resolve_paths.has (normalize_path (a_path))
		do
			internal_resolve_paths.extend (normalize_path (a_path))
		ensure
			a_path_added: resolve_paths.has (normalize_path (a_path))
		end

	add_resolve_path_from_file_name (a_file_name: STRING) is
			-- Adds `a_file_name' location to list `resolve_paths'
		require
			a_file_name_not_void: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			internal_resolve_paths.extend (normalize_path (resolver_path_from_file_name (a_file_name)))
		ensure
			a_path_added: resolve_paths.has (normalize_path (resolver_path_from_file_name (a_file_name)))
		end

feature -- Removal

	remove_resolve_path (a_path: STRING) is
			-- Removes `a_path' to list `'resolve_paths'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			resolve_paths_has_a_path: not resolve_paths.has (normalize_path (a_path))
		do
			internal_resolve_paths.search (normalize_path (a_path))
			if not internal_resolve_paths.after then
				internal_resolve_paths.remove
			end
		ensure
			a_path_remove: not resolve_paths.has (normalize_path (a_path))
		end

	remove_resolve_path_from_file_name (a_file_name: STRING) is
			-- Removes `a_file_name' location to list `'resolve_paths'
		require
			a_file_name_not_void: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			internal_resolve_paths.search (normalize_path (resolver_path_from_file_name (a_file_name)))
			if not internal_resolve_paths.after then
				internal_resolve_paths.remove
			end
		ensure
			a_path_remove: not resolve_paths.has (normalize_path (resolver_path_from_file_name (a_file_name)))
		end

feature -- Formatting

	normalize_path (a_path: STRING): STRING is
			-- Normalize `a_path' by converting to lower-case and removing all duplicate directory
			-- separators.
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_res: STRING
			l_forget_next_ds: BOOLEAN
			l_unc_path: BOOLEAN
			l_char: CHARACTER
			i: INTEGER
		do
			create l_res.make (a_path.count)
			if a_path.count > 2 then
				l_unc_path := a_path.substring (1, 2).is_equal ("\\")
			end

			if l_unc_path then
				i := 3
				l_res.append ("\\")
			else
				i := 1
			end

			l_forget_next_ds := True

			from
			until
				i > a_path.count
			loop
				l_char := a_path @ i
				if l_char /= '\' then
					l_res.append_character (l_char)
					l_forget_next_ds := False
				elseif not l_forget_next_ds then
					l_res.append_character (l_char)
					l_forget_next_ds := True
				end
				i := i + 1
			end

			Result := l_res
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	resolver_path_from_file_name (a_file_name: STRING): STRING is
			-- Retrieves path where `a_file_name' resides
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
			a_file_name_has_not_forward_slash: a_file_name.occurrences ('/') = 0
		local
			l_location: STRING
			l_is_network_path: BOOLEAN
		do
			l_location := a_file_name.twin
			if l_location.count > 2 and then l_location.substring (1, 2).is_equal ("\\") then
					-- `PATH' doesn't evaluate network paths correctly so leading '\\'
					-- requires removal.
				l_is_network_path := True
				l_location.prune_all_leading ('\')
			end
			l_location := {PATH}.get_directory_name (l_location)
			if not l_location.is_empty then
				if l_is_network_path then
					l_location.prepend ("\\")
				end
				Result := l_location
			else
					-- If there is no directory then file is relative to CWD.
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	split_assembly_name (a_full_name: STRING): LIST [STRING] is
			-- Splits `a_full_name' into a 4 part list
			-- @ 1: Assembly Name
			-- @ 2: Version
			-- @ 3: Culture
			-- @ 4: Public Key Token
			-- @ ?: For subclasses to define as custom data - this data is not extracted here.
			-- Note: items 2-? will be void if they are not specified in `a_full_name'
		require
			a_full_name_not_void: a_full_name /= Void
			not_a_full_name_is_empty: not a_full_name.is_empty
		local
			l_res: ARRAYED_LIST [STRING]
			l_parts: LIST [STRING]
			l_name: STRING
			l_item: STRING
			l_version: STRING
			l_culture: STRING
			l_key: STRING
			l_set_for_it: BOOLEAN
			i: INTEGER
		do
			create l_res.make (4)
			l_parts := a_full_name.split (',')
			check
				l_parts_has_name: l_parts.count >= 1
			end
			l_name := l_parts @ 1
			if l_parts.count >= 2 then
				from
					l_parts.go_i_th (2)
				until
					l_parts.after
				loop
					l_item := l_parts.item.as_lower
					l_set_for_it := False
					if l_version = Void then
						i := l_item.substring_index ("version=", 1)
						if i >= 1 and i <= i + 9 then
							l_version := l_parts.item.substring (i + 8, l_item.count)
							l_set_for_it := True
						end
					end
					if l_culture = Void and not l_set_for_it  then
						i := l_item.substring_index ("culture=", 1)
						if i >= 1 and i <= i + 9 then
							l_culture := l_parts.item.substring (i + 8, l_item.count)
							if l_culture.as_lower.is_equal ("neutral") then
								create l_culture.make_empty
							end
							l_set_for_it := True
						end
					end
					if l_key = Void and not l_set_for_it then
						i := l_item.substring_index ("publickeytoken=", 1)
						if i >= 1 then
							if i <= i + 15 then
								l_key := l_parts.item.substring (i + 15, l_item.count)
								if l_key.as_lower.is_equal ("null") then
									create l_key.make_empty
								end
							end
						end
					end
					l_parts.forth
				end
			end
			l_res.extend (l_name)
			l_res.extend (l_version)
			l_res.extend (l_culture)
			l_res.extend (l_key)
			Result := l_res
		ensure
			result_not_void: Result /= Void
			result_count_is_4: Result.count >= 4
			item_1_not_void: Result @ 1 /= Void
			not_item_1_is_empty: not (Result @ 1).is_empty
		end

	load_assembly (a_path: STRING): ASSEMBLY is
			-- Attempts to load assembly from `a_path'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := feature {ASSEMBLY}.load_from (a_path)
			end
		rescue
			retried := True
			retry
		end

	get_assembly_name (a_path: STRING): ASSEMBLY_NAME is
			-- Retrieve an assembly name from `a_path'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {ASSEMBLY_NAME}.get_assembly_name (a_path)
			end
		rescue
			retried := True
			retry
		end

	encoded_key (a_key: NATIVE_ARRAY [NATURAL_8]): STRING is
			-- Printable representation of `a_key'
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
		do
			create Result.make (a_key.count * 2)
			from
				i := 0
			until
				i >= a_key.count
			loop
				Result.append (a_key.item (i).to_hex_string)
				i := i + 1
			end
			Result.to_lower
		ensure
			Result_not_void: Result /= Void
		end

	add_current_assembly_path is
			-- Adds `Cuurent's contained assembly path to `resolver_paths'
		local
			l_file: FILE_INFO
			l_type: SYSTEM_TYPE
		do
			l_type := {AR_RESOLVER}
			create l_file.make (l_type.assembly.location)
			add_resolve_path (l_file.directory_name)
		end

	internal_resolve_paths: ARRAYED_LIST [STRING]
			-- List of resolver paths to be used when attempting to resolve a dependency.

	assembly_extensions: LIST [STRING] is
			-- List of possible assembly extensions
		local
			l_res: ARRAYED_LIST [STRING]
		once
			create l_res.make (2)
			l_res.extend (".dll")
			l_res.extend (".exe")
			Result := l_res
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

invariant
	internal_resolve_paths_not_void: internal_resolve_paths /= Void
	internal_resolve_paths_compares_objects: internal_resolve_paths.object_comparison
	resolve_event_handler_not_void: resolve_event_handler /= Void

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


end -- class AR_RESOLVER
