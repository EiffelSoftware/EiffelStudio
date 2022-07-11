note
	description: "[
		The simplest assembly resolver that will look for dependent assemblies
		in application/library base folder. Other folders will also be examined
		if explicitly added to resolver.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	resolve_paths: ARRAYED_LIST [STRING_32]
			-- List of paths where a potential assembly dependency requiring resolution could be
		do
			Result := internal_resolve_paths
		ensure
			result_not_void: Result /= Void
			result_compares_objects: Result.object_comparison
		end

	friendly_name: detachable STRING_32
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
			l_parts: like split_assembly_name
		do
			if attached {APP_DOMAIN} a_sender as l_domain and then attached a_args.name as l_args_name then
					-- Split assembly name to be resolved into relivent chunks
				l_parts := split_assembly_name (create {STRING_32}.make_from_cil (l_args_name))

					-- Attempt to resolve assembly dependency
				Result := resolve_assembly_by_name (l_domain, l_parts.name, l_parts.version, l_parts.culture, l_parts.public_key_token)
			end
		end

feature -- Resolution

	resolve_by_assembly_name (a_domain: APP_DOMAIN; a_name: ASSEMBLY_NAME): detachable PATH
			-- Resolve an assembly in app domain `a_domain' where name of assembly comprises of `a_name'
		require
			a_domain_not_void: a_domain /= Void
			a_name_not_void: a_name /= Void
		local
			l_parts: like split_assembly_name
		do
			if attached a_name.to_string as l_ass_name then
					-- Split assembly name to be resolved into relivent chunks
				l_parts := split_assembly_name (create {STRING_32}.make_from_cil (l_ass_name))

					-- Attempt to resolve assembly dependency
				Result := resolve_by_name (a_domain, l_parts.name, l_parts.version, l_parts.culture, l_parts.public_key_token)
			end
		ensure
			not_resolve_paths_moved: resolve_paths.cursor.is_equal (old resolve_paths.cursor)
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	resolve_by_name (a_domain: APP_DOMAIN; a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32): detachable PATH
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
			l_file_name: PATH
			l_file_path: READABLE_STRING_32
			l_name: detachable ASSEMBLY_NAME
		do
			debug ("trace")
				{SYSTEM_DLL_TRACE}.write_string ({STRING_32} "Attempting to use custom assembly resolver")
				if attached friendly_name as l_friendly_name then
					{SYSTEM_DLL_TRACE}.write_string ({STRING_32} " '" + l_friendly_name + "'")
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
					{SYSTEM_DLL_TRACE}.write_line_string ({STRING_32} "Looking in '" + l_paths.item + "'.")
				end

				from
					assembly_extensions.start
				until
					assembly_extensions.after or Result /= Void
				loop
					create l_file_name.make_from_string (l_paths.item)
					l_file_name := l_file_name.extended (a_name + assembly_extensions.item)
					l_file_path := l_file_name.name
					debug ("trace")
						{SYSTEM_DLL_TRACE}.write_line_string ({STRING_32} "Looking for '" + l_file_path + "'.")
					end
					if {SYSTEM_FILE}.exists (l_file_path) then
						debug ("trace")
							{SYSTEM_DLL_TRACE}.write_line_string ({STRING_32} "Matching '" + l_file_path + "'.")
						end
						if {SYSTEM_FILE}.exists (l_file_path) then
							l_name := get_assembly_name (l_file_path)
						else
							l_name := Void
						end
						if
							attached l_name and then
							does_name_match (l_name, a_name, a_version, a_culture, a_key)
						then
							debug ("trace")
								{SYSTEM_DLL_TRACE}.write_line_string ({STRING_32} "Attempting to load '" + l_file_path + "'.")
							end
							create Result.make_from_string (l_file_path)
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

	resolve_assembly_by_name (a_domain: APP_DOMAIN; a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32): detachable ASSEMBLY
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
			l_file_name: detachable PATH
		do
			l_file_name := resolve_by_name (a_domain, a_name, a_version, a_culture, a_key)
			if l_file_name /= Void then
				Result := load_assembly (l_file_name)
			end
		ensure
			not_resolve_paths_moved: resolve_paths.cursor.is_equal (old resolve_paths.cursor)
		end

feature -- Query

	does_name_match (a_asm_name: ASSEMBLY_NAME; a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32): BOOLEAN
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
				Result := a_name.same_string (create {STRING_32}.make_from_cil (l_ass_name))
			end
			if
				Result and then a_version /= Void and then attached {VERSION} a_asm_name.version as l_asm_version and then
				attached l_asm_version.to_string as l_version_string
			then
				Result := is_near_version_match (a_version, create {STRING_32}.make_from_cil (l_version_string))
			end
			if
				Result and then a_culture /= Void and then attached {CULTURE_INFO} a_asm_name.culture_info as l_asm_culture and then
				attached l_asm_culture.to_string as l_culture_string
			then
				Result := a_culture.is_case_insensitive_equal_general (create {STRING_32}.make_from_cil (l_culture_string))
			end
			if Result and then a_key /= Void then
				l_key := a_asm_name.get_public_key_token
				if a_key.is_empty then
					Result := l_key = Void or else l_key.length = 0
				elseif l_key /= Void then
					Result := encoded_key (l_key).is_case_insensitive_equal_general (a_key)
				end
			end
		end

	is_near_version_match (a_version, a_match_version: READABLE_STRING_32): BOOLEAN
			-- Is `a_match_version' a near enough match for `a_version'?
		require
			a_version_attached: a_version /= Void
			not_a_version_is_empty: not a_version.is_empty
			a_match_version_attached: a_match_version /= Void
			not_a_match_version_is_empty: not a_match_version.is_empty
		local
			l_parts_a: LIST [READABLE_STRING_32]
			l_parts_b: LIST [READABLE_STRING_32]
			l_count: INTEGER
			l_a: READABLE_STRING_32
			l_b: READABLE_STRING_32
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
				if l_a.is_empty then
					l_a := {STRING_32} "0"
				end
				if l_b.is_empty then
					l_b := {STRING_32} "0"
				end

				if l_a.is_natural_32 and l_b.is_natural_32 then
					Result := l_a.to_natural_32 = l_b.to_natural_32
				else
					Result := l_a.same_string (l_b)
				end

				i := i + 1
			end
		end


feature -- Extending

	add_resolve_path (a_path: READABLE_STRING_32)
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

	add_resolve_path_from_file_name (a_file_name: READABLE_STRING_32)
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

	remove_resolve_path (a_path: READABLE_STRING_32)
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

	remove_resolve_path_from_file_name (a_file_name: READABLE_STRING_32)
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

	normalize_path (a_path: READABLE_STRING_32): STRING_32
			-- Normalize `a_path' by converting to lower-case and removing all duplicate directory
			-- separators.
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_forget_next_ds: BOOLEAN
			l_unc_path: BOOLEAN
			l_char: CHARACTER_32
			i: INTEGER
		do
			create Result.make (a_path.count)
			if a_path.count > 2 then
				l_unc_path := a_path [1] = '\' and a_path [2] = '\'
			end

			if l_unc_path then
				i := 3
				Result.extend ('\')
				Result.extend ('\')
			else
				i := 1
			end

			l_forget_next_ds := True

			from
			until
				i > a_path.count
			loop
				l_char := a_path [i]
				if l_char /= '\' then
					Result.append_character (l_char)
					l_forget_next_ds := False
				elseif not l_forget_next_ds then
					Result.append_character (l_char)
					l_forget_next_ds := True
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	resolver_path_from_file_name (a_file_name: READABLE_STRING_32): READABLE_STRING_32
			-- Retrieves path where `a_file_name' resides
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		do
			Result := (create {PATH}.make_from_string (a_file_name)).parent.name
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	split_assembly_name (a_full_name: READABLE_STRING_32): TUPLE [name: READABLE_STRING_32; version, culture, public_key_token: detachable READABLE_STRING_32]
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
			l_parts: LIST [READABLE_STRING_32]
			l_name: READABLE_STRING_32
			l_item: READABLE_STRING_32
			l_version: detachable READABLE_STRING_32
			l_culture: detachable READABLE_STRING_32
			l_key: detachable READABLE_STRING_32
			l_set_for_it: BOOLEAN
			i: INTEGER
		do
			l_parts := a_full_name.split (',')
			check
				l_parts_has_name: l_parts.count >= 1
			end
			l_name := l_parts.first
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
							if l_culture.is_case_insensitive_equal_general ("neutral") then
								create {IMMUTABLE_STRING_32} l_culture.make_empty
							end
							l_set_for_it := True
						end
					end
					if l_key = Void and not l_set_for_it then
						i := l_item.substring_index ("publickeytoken=", 1)
						if
							i >= 1 and then
							i <= i + 15
						then
							l_key := l_parts.item.substring (i + 15, l_item.count)
							if l_key.is_case_insensitive_equal_general ("null") then
								create {IMMUTABLE_STRING_32} l_key.make_empty
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
			item_1_not_void_and_not_empty: attached {STRING_32} Result [1] as l_ass_name and then not l_ass_name.is_empty
		end

	load_assembly (a_path: PATH): detachable ASSEMBLY
			-- Attempts to load assembly from `a_path'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make_with_path (a_path)).exists
		local
			retried: BOOLEAN
		do
			if not retried then
					-- This will fail on assemblies requiring execution permission.
					-- This is the behavior because most application require execution.
					-- For reflection tools, they should call `resolve_by_*' functions and load
					-- an assembly using {ASSEMBLY}.relfection_load_from (2.0+).
				Result := {ASSEMBLY}.load_from (a_path.name)
			end
		rescue
			retried := True
			retry
		end

	get_assembly_name (a_path: READABLE_STRING_32): detachable ASSEMBLY_NAME
			-- Retrieve an assembly name from `a_path'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make_with_name (a_path)).exists
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

	encoded_key (a_key: NATIVE_ARRAY [NATURAL_8]): STRING_32
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
				Result.append_string_general (a_key.item (i).to_hex_string)
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
					add_resolve_path (create {STRING_32}.make_from_cil (l_dir))
				end
			end
		end

	internal_resolve_paths: ARRAYED_LIST [STRING_32]
			-- List of resolver paths to be used when attempting to resolve a dependency.

	assembly_extensions: ARRAYED_LIST [STRING_32]
			-- List of possible assembly extensions
		once
			create Result.make (2)
			Result.extend ({STRING_32} ".dll")
			Result.extend ({STRING_32} ".exe")
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

invariant
	internal_resolve_paths_not_void: internal_resolve_paths /= Void
	internal_resolve_paths_compares_objects: internal_resolve_paths.object_comparison
	resolve_event_handler_not_void: resolve_event_handler /= Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
