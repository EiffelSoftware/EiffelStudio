note
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

	make
			-- Initialize instance
		do
			common_initialization
		end

	make_with_name (a_name: attached like friendly_name)
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

	common_initialization
			-- Additional initialization.
		do
			create internal_resolve_paths.make (1)
			internal_resolve_paths.compare_objects
			add_current_assembly_path
			create resolve_event_handler.make (Current, $resolve)
		end

feature -- Access

	resolve_paths: LIST [STRING]
			-- List of paths where a potential assembly dependency requiring resolution could be
		do
			Result := internal_resolve_paths
		ensure
			result_not_void: Result /= Void
			result_compares_objects: Result.object_comparison
		end

	friendly_name: detachable STRING
			-- Resolver friendly name

feature {AR_SUBSCRIPTION} -- Access

	resolve_event_handler: detachable RESOLVE_EVENT_HANDLER
			-- Retrieve an event handler for `Current'

feature {NONE} -- Resolution

	resolve (a_sender: SYSTEM_OBJECT; a_args: RESOLVE_EVENT_ARGS): detachable ASSEMBLY
			-- Event handler for System.AppDomain.AssemblyResolve event
		require
			a_send_not_void: a_sender /= Void
			a_args_not_void: a_args /= Void
		local
			l_domain: detachable APP_DOMAIN
			l_parts: like split_assembly_name
		do
			l_domain ?= a_sender
			if l_domain /= Void and then attached a_args.name as l_args_name then
					-- Split assembly name to be resolved into relivent chunks
				l_parts := split_assembly_name (l_args_name)

					-- Attempt to resolve assembly dependency
				Result := resolve_assembly_by_name (l_domain, l_parts.name, l_parts.version, l_parts.culture, l_parts.public_key_token)
			end
		end

feature -- Resolution

	resolve_by_assembly_name (a_domain: APP_DOMAIN; a_name: ASSEMBLY_NAME): detachable STRING
			-- Resolve an assembly in app domain `a_domain' where name of assembly comprises of `a_name'
		require
			a_domain_not_void: a_domain /= Void
			a_name_not_void: a_name /= Void
		local
			l_parts: like split_assembly_name
		do
			if attached a_name.to_string as l_ass_name then
					-- Split assembly name to be resolved into relivent chunks
				l_parts := split_assembly_name (l_ass_name)

					-- Attempt to resolve assembly dependency
				Result := resolve_by_name (a_domain, l_parts.name, l_parts.version, l_parts.culture, l_parts.public_key_token)
			end
		ensure
			not_resolve_paths_moved: resolve_paths.cursor.is_equal (old resolve_paths.cursor)
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	resolve_by_name (a_domain: APP_DOMAIN; a_name: STRING; a_version: detachable STRING; a_culture: detachable STRING; a_key: detachable STRING): detachable STRING
			-- Resolve an assembly in app domain `a_domain' where name of assembly comprises of assembly name `a_name'
			-- and optionally version `a_version', culture `a_culture' and public key token `a_key', and return file name
		require
			a_domain_not_void: a_domain /= Void
			a_name_not_void: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_version_is_empty: a_version /= Void implies not a_version.is_empty
		local
			l_cursor: CURSOR
			l_paths: like resolve_paths
			l_file_name: FILE_NAME
			l_file_path: STRING
			l_name: detachable ASSEMBLY_NAME
		do
			debug ("trace")
				{SYSTEM_DLL_TRACE}.write_string ("Attempting to use custom assembly resolver")
				if attached friendly_name as l_friendly_name then
					{SYSTEM_DLL_TRACE}.write_string (" '" + l_friendly_name + "'")
				end
				{SYSTEM_DLL_TRACE}.write_line_string (".")
			end

			l_paths := resolve_paths
			l_cursor := l_paths.cursor

			from
				l_paths.start
			until
				l_paths.after or Result /= Void
			loop
				debug ("trace")
					{SYSTEM_DLL_TRACE}.write_line_string ("Looking in '" + l_paths.item + "'.")
				end

				from
					assembly_extensions.start
				until
					assembly_extensions.after or Result /= Void
				loop
					create l_file_name.make_from_string (l_paths.item)
					l_file_name.set_file_name (a_name + assembly_extensions.item)
					debug ("trace")
						{SYSTEM_DLL_TRACE}.write_line_string ("Looking for '" + l_file_name + "'.")
					end
					l_file_path := l_file_name.string
					if {SYSTEM_FILE}.exists (l_file_path) then
						debug ("trace")
							{SYSTEM_DLL_TRACE}.write_line_string ("Matching '" + l_file_path + "'.")
						end
						if {SYSTEM_FILE}.exists (l_file_path) then
							l_name := get_assembly_name (l_file_path)
						else
							l_name := Void
						end
						if l_name /= Void then
							if does_name_match (l_name, a_name, a_version, a_culture, a_key) then
								debug ("trace")
									{SYSTEM_DLL_TRACE}.write_line_string ("Attempting to load '" + l_file_path + "'.")
								end

								Result := l_file_path
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
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	resolve_assembly_by_name (a_domain: APP_DOMAIN; a_name: STRING; a_version: detachable STRING; a_culture: detachable STRING; a_key: detachable STRING): detachable ASSEMBLY
			-- Resolve an assembly in app domain `a_domain' where name of assembly comprises of assembly name `a_name'
			-- and optionally version `a_version', culture `a_culture' and public key token `a_key'
			--
			-- Note: This routine can only be used for assemblies not requiring special execution permissions.
		require
			a_domain_not_void: a_domain /= Void
			a_name_not_void: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_version_is_empty: a_version /= Void implies not a_version.is_empty
		local
			l_file_name: detachable STRING
		do
			l_file_name := resolve_by_name (a_domain, a_name, a_version, a_culture, a_key)
			if l_file_name /= Void then
				Result := load_assembly (l_file_name)
			end
		ensure
			not_resolve_paths_moved: resolve_paths.cursor.is_equal (old resolve_paths.cursor)
		end

feature -- Query

	does_name_match (a_asm_name: ASSEMBLY_NAME; a_name: STRING; a_version: detachable STRING; a_culture: detachable STRING; a_key: detachable STRING): BOOLEAN
			-- Does `a_asm_name' match `a_name', `a_version', `a_culture' and `a_key'
		require
			a_asm_name_not_void: a_asm_name /= Void
			a_name_not_void: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_version_is_empty: a_version /= Void implies not a_version.is_empty
		local
			l_key: detachable NATIVE_ARRAY [NATURAL_8]
		do
			if attached a_asm_name.name as l_ass_name then
				Result := a_name.is_equal (l_ass_name)
			end
			if
				Result and then a_version /= Void and then attached {VERSION} a_asm_name.version as l_asm_version and then
				attached l_asm_version.to_string as l_version_string
			then
				Result := is_near_version_match (a_version, l_version_string)
			end
			if
				Result and then a_culture /= Void and then attached {CULTURE_INFO} a_asm_name.culture_info as l_asm_culture and then
				attached l_asm_culture.to_string as l_culture_string
			then
				Result := a_culture.is_case_insensitive_equal (l_culture_string)
			end
			if Result and then a_key /= Void then
				l_key := a_asm_name.get_public_key_token
				if a_key.is_empty then
					Result := l_key = Void or else l_key.length = 0
				elseif l_key /= Void then
					Result := encoded_key (l_key).as_lower.is_equal (a_key.as_lower)
				end
			end
		end

	is_near_version_match (a_version: STRING; a_match_version: STRING): BOOLEAN
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

	add_resolve_path (a_path: STRING)
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

	add_resolve_path_from_file_name (a_file_name: STRING)
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

	remove_resolve_path (a_path: STRING)
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

	remove_resolve_path_from_file_name (a_file_name: STRING)
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

	normalize_path (a_path: STRING): STRING
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

	resolver_path_from_file_name (a_file_name: STRING): STRING
			-- Retrieves path where `a_file_name' resides
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
			a_file_name_has_not_forward_slash: a_file_name.occurrences ('/') = 0
		local
			l_location: detachable SYSTEM_STRING
			l_path: STRING
			l_is_network_path: BOOLEAN
		do
			if  a_file_name.count > 2 and then a_file_name.substring (1, 2).is_equal ("\\") then
					-- `PATH' doesn't evaluate network paths correctly so leading '\\'
					-- requires removal.
				l_is_network_path := True
				l_path := a_file_name.twin
				l_path.prune_all_leading ('\')
			else
				l_path := a_file_name
			end
			l_location := {SYSTEM_PATH}.get_directory_name (l_path)
			if l_location /= Void and then l_location.length > 0 then
				Result := l_location
				if l_is_network_path then
					Result.prepend ("\\")
				end
			else
					-- If there is no directory then file is relative to CWD.
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	split_assembly_name (a_full_name: STRING): TUPLE [name: STRING; version, culture, public_key_token: detachable STRING]
			-- Splits `a_full_name' into a 4 part list
			-- @ 1: Assembly Name
			-- @ 2: Version
			-- @ 3: Culture
			-- @ 4: Public Key Token
			-- Note: items 2-? will be void if they are not specified in `a_full_name'
		require
			a_full_name_not_void: a_full_name /= Void
			not_a_full_name_is_empty: not a_full_name.is_empty
		local
			l_parts: LIST [STRING]
			l_name: STRING
			l_item: STRING
			l_version: detachable STRING
			l_culture: detachable STRING
			l_key: detachable STRING
			l_set_for_it: BOOLEAN
			i: INTEGER
		do
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
			Result := [l_name, l_version, l_culture, l_key]
		ensure
			result_not_void: Result /= Void
			result_count_is_4: Result.count >= 4
			item_1_not_void_and_not_empty: attached {STRING} Result [1] as l_ass_name and then not l_ass_name.is_empty
		end

	load_assembly (a_path: STRING): detachable ASSEMBLY
			-- Attempts to load assembly from `a_path'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: {SYSTEM_FILE}.exists (a_path)
		local
			retried: BOOLEAN
		do
			if not retried then
					-- This will fail on assemblies requiring execution permission.
					-- This is the behavior because most application require execution.
					-- For reflection tools, they should call `resolve_by_*' functions and load
					-- an assembly using {ASSEMBLY}.relfection_load_from (2.0+).
				Result := {ASSEMBLY}.load_from (a_path)
			end
		rescue
			retried := True
			retry
		end

	get_assembly_name (a_path: STRING): detachable ASSEMBLY_NAME
			-- Retrieve an assembly name from `a_path'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: {SYSTEM_FILE}.exists (a_path)
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

	encoded_key (a_key: NATIVE_ARRAY [NATURAL_8]): STRING
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

	add_current_assembly_path
			-- Adds `Cuurent's contained assembly path to `resolver_paths'
		local
			l_file: SYSTEM_FILE_INFO
			l_type: SYSTEM_TYPE
		do
			l_type := {AR_RESOLVER}
			if attached l_type.assembly as l_assembly then
				create l_file.make (l_assembly.location)
				if attached l_file.directory_name as l_dir then
					add_resolve_path (l_dir)
				end
			end
		end

	internal_resolve_paths: ARRAYED_LIST [STRING]
			-- List of resolver paths to be used when attempting to resolve a dependency.

	assembly_extensions: LIST [STRING]
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


end -- class AR_RESOLVER
