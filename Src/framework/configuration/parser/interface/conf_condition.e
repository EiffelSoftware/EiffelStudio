note
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
			is_equal
		end

	SHARED_EXECUTION_ENVIRONMENT
		redefine
			is_equal
		end

	SHARED_LOCALE
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create.
		do
			create version.make (1)
			create custom.make_caseless (1)
		end

feature -- Access

	platform: detachable EQUALITY_TUPLE [TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]]
			-- Platform where it is enabled or for which it is disabled (if `invert' is true)

	build: detachable EQUALITY_TUPLE [TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]]
			-- Build where it is is enabled or for which it is disabled (if `invert' is true)

	concurrency: detachable EQUALITY_TUPLE [TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]]
			-- Concurrency setting where it is is enabled or for which it is disabled (if `invert' is true)

	dotnet: detachable CELL [BOOLEAN]
			-- Enabled for dotnet?

	dynamic_runtime: detachable CELL [BOOLEAN]
			-- Enabled for dynamic runtime?

	version: STRING_TABLE [EQUALITY_TUPLE [TUPLE [min: detachable CONF_VERSION; max: detachable CONF_VERSION]]]
			-- Enabled for a certain version number? Indexed by the type of the version number.

	custom: STRING_TABLE [STRING_TABLE [BOOLEAN]]
			-- Custom variables that have to be fullfilled indexed by the variable name.
			-- Values having the same name are indexed by the value.
			-- [[invert, value], key]

feature -- Queries

	satisfied (a_state: CONF_STATE): BOOLEAN
			-- Does `a_state' satisfy `Current'?
		require
			a_state_not_void: a_state /= Void
		local
			l_vars: STRING_TABLE [READABLE_STRING_GENERAL]
			l_version: STRING_TABLE [CONF_VERSION]
			l_ver_cond: like version.item_for_iteration
			l_ver_state: detachable CONF_VERSION
			l_var_key, l_var_val: detachable READABLE_STRING_GENERAL
			l_values: STRING_TABLE [BOOLEAN]
		do
			Result := True

				-- concurrency
			if Result and attached concurrency as l_concurrency then
				Result := l_concurrency.item.value.has (a_state.concurrency) xor l_concurrency.item.invert
			end

				-- dotnet
			if Result and attached dotnet as l_dotnet then
				Result := a_state.is_dotnet = l_dotnet.item
			end

				-- dynamic runtime
			if Result and attached dynamic_runtime as l_dynamic_runtime then
				Result := a_state.is_dynamic_runtime = l_dynamic_runtime.item
			end

				-- platform
			if Result and attached platform as l_platform then
				Result := l_platform.item.value.has (a_state.platform) xor l_platform.item.invert
			end

				-- build
			if Result and attached build as l_build then
				Result := l_build.item.value.has (a_state.build) xor l_build.item.invert
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
					Result := l_ver_state /= Void and then
						(not attached l_ver_cond.item.min as l_min or else l_min <= l_ver_state) and then
						(not attached l_ver_cond.item.max as l_max or else l_max >= l_ver_state)
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

	exclusion_value (a_key, a_value: READABLE_STRING_GENERAL): BOOLEAN
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
			no_invert: attached platform as p implies not p.item.invert
		local
			l_platform: like platform
		do
			l_platform := platform
			if l_platform = Void then
				create l_platform.make ([create {ARRAYED_LIST [INTEGER]}.make (1), False])
				platform := l_platform
			end
			l_platform.item.value.force (a_platform)
		end

	exclude_platform (a_platform: INTEGER)
			-- Add an exclude requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			all_invert: attached platform as p implies p.item.invert
		local
			l_platform: like platform
		do
			l_platform := platform
			if l_platform = Void then
				create l_platform.make ([create {ARRAYED_LIST [INTEGER]}.make (1), True])
				platform := l_platform
			end
			l_platform.item.value.force (a_platform)
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
			no_invert: attached build as b implies not b.item.invert
		local
			l_build: like build
		do
			l_build := build
			if l_build = Void then
				create l_build.make ([create {ARRAYED_LIST [INTEGER]}.make (1), False])
				build := l_build
			end
			l_build.item.value.force (a_build)
		end

	exclude_build (a_build: INTEGER)
			-- Add an exclude requirement on `a_build'.
		require
			valid_build: valid_build (a_build)
			all_invert: attached build as b implies b.item.invert
		local
			l_build: like build
		do
			l_build := build
			if l_build = Void then
				create l_build.make ([create {ARRAYED_LIST [INTEGER]}.make (1), True])
				build := l_build
			end
			l_build.item.value.force (a_build)
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
			not_invert: attached concurrency as c implies not c.item.invert
		local
			l_concurrency: like concurrency
		do
			l_concurrency := concurrency
			if l_concurrency = Void then
				create l_concurrency.make ([create {ARRAYED_LIST [INTEGER]}.make (1), False])
				concurrency := l_concurrency
			end
			l_concurrency.item.value.force (a_concurrency)
		end

	exclude_concurrency (a_concurrency: INTEGER)
			-- Add an exclude requirement on `a_concurrency'.
		require
			valid_concurrency: valid_concurrency (a_concurrency)
			all_invert: attached concurrency as c implies c.item.invert
		local
			l_concurrency: like concurrency
		do
			l_concurrency := concurrency
			if l_concurrency = Void then
				create l_concurrency.make ([create {ARRAYED_LIST [INTEGER]}.make (1), True])
				concurrency := l_concurrency
			end
			l_concurrency.item.value.force (a_concurrency)
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

	add_custom (a_name, a_value: READABLE_STRING_GENERAL; a_exclude: BOOLEAN)
			-- Add requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		local
			l_values: STRING_TABLE [BOOLEAN]
		do
			if attached custom.item (a_name) as l_val then
				l_values := l_val
			else
				create l_values.make (1)
				custom.force (l_values, a_name)
			end
			l_values.force (a_exclude, a_value)
		end

	remove_custom (a_name, a_value: READABLE_STRING_GENERAL)
			-- Remove custom attribute `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			if attached custom.item (a_name) as l_values then
				l_values.remove (a_value)
				if l_values.is_empty then
						-- Remove the empty one
					custom.remove (a_name)
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

	add_version (a_min, a_max: detachable CONF_VERSION; a_type: STRING_32)
			-- Set version constraint.
		require
			min_or_max: a_min /= Void or a_max /= Void
			min_less_max: a_min /= Void and a_max /= Void implies a_min <= a_max
			valid_type: valid_version_type (a_type)
		local
			l_vers: EQUALITY_TUPLE [TUPLE [min: detachable CONF_VERSION; max: detachable CONF_VERSION]]
		do
			create l_vers.make ([a_min, a_max])
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
			Result := text.is_equal (other.text)
		end

feature -- Output

	text: STRING_32
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
				if attached version.item_for_iteration.item.min as l_min then
					Result.append (l_min.version)
					Result.append_string_general (" <= ")
				end
				Result.append_string_general (version.key_for_iteration + " version")
				if attached version.item_for_iteration.item.max as l_max then
					Result.append_string_general (" <= ")
					Result.append (l_max.version)
				end
				Result.append_string_general (" and ")
				version.forth
			end

			if attached dotnet as l_dotnet then
				if l_dotnet.item then
					Result.append_string_general (".NET and ")
				else
					Result.append_string_general ("not .NET and ")
				end
			end

			if attached dynamic_runtime as l_dynamic_runtime then
				if l_dynamic_runtime.item then
					Result.append_string_general ("dynamic_runtime and ")
				else
					Result.append_string_general ("not dynamic_runtime and ")
				end
			end

			across custom as custom_ic loop
				across
					custom_ic.item as l_c
				loop
					Result.append_string_general (custom_ic.key)
					if l_c.item then
						Result.append_string_general (" /= ")
					else
						Result.append_string_general (" = ")
					end
					Result.append_string_general (l_c.key)
					Result.append_string_general (" and ")
				end
			end

				-- remove last " and "
			if not Result.is_empty then
				Result.remove_tail (5)
			end
		ensure then
			Result_not_void: Result /= Void
		end

feature {NONE} -- Output

	append_list (data: like platform; names: like platform_names; a_output: STRING_32)
			-- Append `data' (if any) to `a_output' using specified `names'.
		require
			names_attached: attached names
			output_attached: attached a_output
		local
			c: STRING
		do
			if data /= Void then
				if attached data.item as i and then attached i.value as v then
					if i.invert then
						a_output.append_string_general ("not ")
						c := " and "
					else
						c := " or "
					end
					a_output.append_character ('(')
					from
						v.start
					until
						v.after
					loop
						if attached names.item (v.item) as l_name then
							a_output.append_string_general (l_name)
						else
							check has_name: False end
							a_output.append_string_general ("False")
						end
						a_output.append_string_general (c)
						v.forth
					end
					a_output.remove_tail (c.count)
					a_output.append_string_general (") and ")
				else
					check False end
				end
			end
		end

invariant
	platform_ok: attached platform as p implies p.item.value /= Void
	build_ok: attached build as b implies b.item.value /= Void
	concurrency_ok: attached concurrency as c implies attached c.item as i and then attached i.value
	version_not_void: version /= Void
	custom_not_void: custom /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
