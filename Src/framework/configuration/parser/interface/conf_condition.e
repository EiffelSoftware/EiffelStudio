﻿note
	description: "Specifies a condition."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITION

inherit
	CONF_VALIDITY
		redefine
			out,
			is_equal
		end

	SHARED_EXECUTION_ENVIRONMENT
		redefine
			out,
			is_equal
		end

	SHARED_LOCALE
		undefine
			out,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create.
		do
			create version.make (1)
			create custom.make (1)
		end

feature -- Access

	platform: EQUALITY_TUPLE [TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]]
			-- Platform where it is enabled or for which it is disabled (if `invert' is true)

	build: EQUALITY_TUPLE [TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]]
			-- Build where it is is enabled or for which it is disabled (if `invert' is true)

	concurrency: EQUALITY_TUPLE [TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]]
			-- Concurrency setting where it is is enabled or for which it is disabled (if `invert' is true)

	dotnet: CELL [BOOLEAN]
			-- Enabled for dotnet?

	dynamic_runtime: CELL [BOOLEAN]
			-- Enabled for dynamic runtime?

	version: HASH_TABLE [EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]], STRING]
			-- Enabled for a certain version number? Indexed by the type of the version number.

	custom: HASH_TABLE [HASH_TABLE [BOOLEAN, READABLE_STRING_32], READABLE_STRING_32]
			-- Custom variables that have to be fullfilled indexed by the variable name.
			-- Values having the same name are indexed by the value.
			-- [[invert, value], key]

feature -- Queries

	satisfied (a_state: CONF_STATE): BOOLEAN
			-- Does `a_state' satisfy `Current'?
		require
			a_state_not_void: a_state /= Void
		local
			l_vars: EQUALITY_HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			l_version: HASH_TABLE [CONF_VERSION, STRING]
			l_ver_cond: EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]]
			l_ver_state: CONF_VERSION
			l_var_key, l_var_val: READABLE_STRING_32
			l_values: HASH_TABLE [BOOLEAN, READABLE_STRING_32]
		do
			Result := True

				-- concurrency
			if Result and concurrency /= Void then
				Result := concurrency.item.value.has (a_state.concurrency) xor concurrency.item.invert
			end

				-- dotnet
			if Result and dotnet /= Void then
				Result := a_state.is_dotnet = dotnet.item
			end

				-- dynamic runtime
			if Result and dynamic_runtime /= Void then
				Result := a_state.is_dynamic_runtime = dynamic_runtime.item
			end

				-- platform
			if Result and platform /= Void then
				Result := platform.item.value.has (a_state.platform) xor platform.item.invert
			end

				-- build
			if Result and build /= Void then
				Result := build.item.value.has (a_state.build) xor build.item.invert
			end

				-- Version
			if Result and not version.is_empty then
				from
					l_version := a_state.version
					version.start
				until
					not Result or version.after
				loop
					l_ver_cond := version.item_for_iteration
					l_ver_state := l_version.item (version.key_for_iteration)
					Result := l_ver_state /= Void and then (l_ver_cond.item.min = Void or else l_ver_cond.item.min <= l_ver_state) and
						(l_ver_cond.item.max = Void or else l_ver_cond.item.max >= l_ver_state)
					version.forth
				end
			end

				-- custom
			if Result and not custom.is_empty then
				from
					l_vars := a_state.custom_variables
					custom.start
				until
					not Result or custom.after
				loop
					l_values := custom.item_for_iteration
					l_var_key := custom.key_for_iteration
					l_var_val := l_vars.item (l_var_key)
					if l_var_val = Void then
						l_var_val := execution_environment.item (l_var_key)
					end
					from
						l_values.start
					until
						l_values.after or not Result
					loop
						Result := (l_var_val /= Void and then l_values.key_for_iteration.same_string (l_var_val)) xor l_values.item_for_iteration
						l_values.forth
					end
					custom.forth
				end
			end
		end

	exclusion_value (a_key, a_value: READABLE_STRING_32): BOOLEAN
			-- Exclusion value of `a_key' and `a_value' pair
		require
			a_key_ok: a_key /= Void and then custom.has (a_key.as_lower)
		do
			Result := attached custom.item (a_key.as_lower) as l_item and then l_item.item (a_value)
		end

feature -- Update

	add_platform (a_platform: INTEGER)
			-- Add requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			no_invert: platform = Void or else not platform.item.invert
		do
			if platform = Void then
				create platform
				platform.item.value := create {ARRAYED_LIST [INTEGER]}.make (1)
			end
			platform.item.value.force (a_platform)
		end

	exclude_platform (a_platform: INTEGER)
			-- Add an exclude requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			all_invert: platform = Void or else platform.item.invert
		do
			if platform = Void then
				create platform
				platform.item.value := create {ARRAYED_LIST [INTEGER]}.make (1)
				platform.item.invert := True
			end
			platform.item.value.force (a_platform)
		end

	wipe_out_platform
			-- Wipe out platforms.
		do
			platform := Void
		ensure
			platform_void: platform = Void
		end

	add_build (a_build: INTEGER)
			-- Add requirement on `a_build'.
		require
			valid_build: valid_build (a_build)
			no_invert: build = Void or else not build.item.invert
		do
			if build = Void then
				create build
				build.item.value := create {ARRAYED_LIST [INTEGER]}.make (1)
			end
			build.item.value.force (a_build)
		end

	exclude_build (a_build: INTEGER)
			-- Add an exclude requirement on `a_build'.
		require
			valid_build: valid_build (a_build)
			all_invert: build = void or else build.item.invert
		do
			if build = Void then
				create build
				build.item.value := create {ARRAYED_LIST [INTEGER]}.make (1)
				build.item.invert := True
			end
			build.item.value.force (a_build)
		end

	wipe_out_build
			-- Wipe out builds.
		do
			build := Void
		ensure
			build_void: build = Void
		end

	add_concurrency (a_concurrency: INTEGER)
			-- Add requirement on `a_concurrency'.
		require
			valid_platform: valid_concurrency (a_concurrency)
			no_invert: concurrency = Void or else not concurrency.item.invert
		do
			if concurrency = Void then
				create concurrency
				concurrency.item.value := create {ARRAYED_LIST [INTEGER]}.make (1)
			end
			concurrency.item.value.force (a_concurrency)
		end

	exclude_concurrency (a_concurrency: INTEGER)
			-- Add an exclude requirement on `a_concurrency'.
		require
			valid_concurrency: valid_concurrency (a_concurrency)
			all_invert: concurrency = Void or else concurrency.item.invert
		do
			if concurrency = Void then
				create concurrency
				concurrency.item.value := create {ARRAYED_LIST [INTEGER]}.make (1)
				concurrency.item.invert := True
			end
			concurrency.item.value.force (a_concurrency)
		end

	wipe_out_concurrency
			-- Wipe out concurrency.
		do
			concurrency := Void
		ensure
			concurrency_void: concurrency = Void
		end

	set_dotnet (a_value: BOOLEAN)
			-- Set `dotnet' to `a_value'.
		do
			create dotnet.put (a_value)
		end

	set_dynamic_runtime (a_value: BOOLEAN)
			-- Set `dynamic_runtime' to `a_value'.
		do
			create dynamic_runtime.put (a_value)
		end

	unset_dotnet
			-- Unset `dotnet'.
		do
			dotnet := Void
		end

	unset_dynamic_runtime
			-- Unset `dynamic_runtime'.
		do
			dynamic_runtime := Void
		end

	add_custom (a_name, a_value: READABLE_STRING_32; a_exclude: BOOLEAN)
			-- Add requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		local
			l_values: HASH_TABLE [BOOLEAN, READABLE_STRING_32]
			l_name: READABLE_STRING_32
		do
			l_name := a_name.as_lower
			custom.search (l_name)
			if not custom.found then
				create l_values.make (1)
				l_values.force (a_exclude, a_value)
				custom.force (l_values, l_name)
			else
				l_values := custom.found_item
				l_values.force (a_exclude, a_value)
			end
		end

	remove_custom (a_name, a_value: READABLE_STRING_32)
			-- Remove custom attribute `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		local
			l_name: READABLE_STRING_32
		do
			l_name := a_name.as_lower
			custom.search (l_name)
			if custom.found then
				check attached custom.found_item as l_values then
					l_values.remove (a_value)
					if l_values.is_empty then
							-- Remove the empty one
						custom.remove (l_name)
					end
				end
			end
		end

	wipe_out_custom
			-- Wipe out custom.
		do
			custom.wipe_out
		ensure
			custom_empty: custom.is_empty
		end

	unset_version (a_type: STRING)
			-- Unset version constraint.
		require
			valid_type: valid_version_type (a_type)
		do
			version.remove (a_type)
		ensure
			unset: not version.has (a_type)
		end

	add_version (a_min, a_max: CONF_VERSION; a_type: STRING)
			-- Set version constraint.
		require
			min_or_max: a_min /= Void or a_max /= Void
			min_less_max: a_min /= Void and a_max /= Void implies a_min <= a_max
			valid_type: valid_version_type (a_type)
		local
			l_vers: EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]]
		do
			create l_vers
			l_vers.item.min := a_min
			l_vers.item.max := a_max
			version.force (l_vers, a_type)
		ensure
			version_added: version.has (a_type)
		end

feature -- Equality

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
				-- we consider them equal if the textual representation is equal
			Result := out.is_equal (other.out)
		end

feature -- Output

	out: STRING
			-- Text representation for the conditions.
		do
			create Result.make_empty

			append_list (platform, platform_names, Result)
			append_list (build, build_names, Result)
			append_list (concurrency, concurrency_names, Result)

			from
				version.start
			until
				version.after
			loop
				if version.item_for_iteration.item.min /= Void then
					Result.append (version.item_for_iteration.item.min.version + " <= ")
				end
				Result.append (version.key_for_iteration + " version")
				if version.item_for_iteration.item.max /= Void then
					Result.append (" <= " + version.item_for_iteration.item.max.version)
				end
				Result.append (" and ")
				version.forth
			end

			if dotnet /= Void then
				if dotnet.item then
					Result.append (".NET and ")
				else
					Result.append ("not .NET and ")
				end
			end

			if dynamic_runtime /= Void then
				if dynamic_runtime.item then
					Result.append ("dynamic_runtime and ")
				else
					Result.append ("not dynamic_runtime and ")
				end
			end

			from
				custom.start
			until
				custom.after
			loop
				check
					is_valid_as_string_8: custom.key_for_iteration.is_valid_as_string_8
				end
				across
					custom.item_for_iteration as l_c
				loop
					check
						is_valid_as_string_8: l_c.key.is_valid_as_string_8
					end
					Result.append (custom.key_for_iteration.as_string_8)
					if l_c.item then
						Result.append (" /= ")
					else
						Result.append (" = ")
					end
					Result.append (l_c.key.as_string_8 + " and ")
				end
				custom.forth
			end

				-- remove last " and "
			if not Result.is_empty then
				Result.remove_tail (5)
			end
		ensure then
			Result_not_void: Result /= Void
		end

feature {NONE} -- Output

	append_list (data: like platform; names: like platform_names; output: STRING)
			-- Append `data' (if any) to `output' using specified `names'.
		require
			names_attached: attached names
			output_attached: attached output
		local
			c: STRING
		do
			if attached data then
				check attached data.item as i and then attached i.value as v then
					if i.invert then
						output.append ("not ")
						c := " and "
					else
						c := " or "
					end
					output.append_character ('(')
					from
						v.start
					until
						v.after
					loop
						output.append (names.item (v.item))
						output.append (c)
						v.forth
					end
					output.remove_tail (c.count)
					output.append (") and ")
				end
			end
		end

invariant
	platform_ok: platform /= Void implies platform.item.value /= Void
	build_ok: build /= Void implies build.item.value /= Void
	concurrency_ok: attached concurrency as c implies attached c.item as i and then attached i.value
	version_not_void: version /= Void
	custom_not_void: custom /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
