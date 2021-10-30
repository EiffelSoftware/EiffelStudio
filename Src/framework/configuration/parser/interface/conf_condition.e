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
	make,
	make_with_target

feature {NONE} -- Initialization

	make
			-- Create.
		do
			create version.make (1)
			create custom.make_caseless (1)
		end

	make_with_target (a_target: CONF_TARGET)
		do
			make
			target := a_target
		end

feature -- Access

	platform: detachable TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]
			-- Platform where it is enabled or for which it is disabled (if `invert' is true)

	build: detachable TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]
			-- Build where it is is enabled or for which it is disabled (if `invert' is true)

	concurrency: detachable TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]
			-- Concurrency capability where it is is enabled or for which it is disabled (if `invert' is true)

	void_safety: detachable TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]
			-- Void_safety capability where it is is enabled or for which it is disabled (if `invert' is true)

	dotnet: detachable CELL [BOOLEAN]
			-- Enabled for dotnet?

	dynamic_runtime: detachable CELL [BOOLEAN]
			-- Enabled for dynamic runtime?

	version: STRING_TABLE [TUPLE [min: detachable CONF_VERSION; max: detachable CONF_VERSION]]
			-- Enabled for a certain version number? Indexed by the type of the version number.

	custom: STRING_TABLE [STRING_TABLE [CONF_CONDITION_CUSTOM_ATTRIBUTES]]
			-- Custom variables that have to be fullfilled indexed by the variable name.
			-- Values having the same name are indexed by the value.
			-- [[custom_data, value], key]

	target: detachable CONF_TARGET
			-- The target where this condition is written in.

feature -- Queries

	satisfied (a_state: CONF_STATE): BOOLEAN
			-- Does `a_state' satisfy `Current'?
		require
			a_state_not_void: a_state /= Void
		local
			l_version: STRING_TABLE [CONF_VERSION]
			l_ver_cond: like version.item_for_iteration
			l_ver_state: detachable CONF_VERSION
		do
			Result := True

				-- concurrency
			if Result and attached concurrency as l_concurrency then
				Result := l_concurrency.value.has (a_state.concurrency) xor l_concurrency.invert
			end

				-- void_safety
			if Result and attached void_safety as l_void_safety then
				Result := l_void_safety.value.has (a_state.void_safety) xor l_void_safety.invert
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
				Result := l_platform.value.has (a_state.platform) xor l_platform.invert
			end

				-- build
			if Result and attached build as l_build then
				Result := l_build.value.has (a_state.build) xor l_build.invert
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
						(not attached l_ver_cond.min as l_min or else l_min <= l_ver_state) and then
						(not attached l_ver_cond.max as l_max or else l_max >= l_ver_state)
					version.forth
				end
			end

				-- custom
			if Result and not custom.is_empty then
				across
					custom as ic
				until
					not Result
				loop
					Result := custom_satisfied (a_state, @ ic.key, ic)
				end
			end
		end

	custom_satisfied (a_state: CONF_STATE; a_custom_name: READABLE_STRING_GENERAL; a_custom_values: STRING_TABLE [CONF_CONDITION_CUSTOM_ATTRIBUTES]): BOOLEAN
			-- Does `a_state' satisfy `a_custom` condition?	
		local
			l_var_key: detachable READABLE_STRING_GENERAL
			l_var_val: detachable READABLE_STRING_32
			l_choice: READABLE_STRING_GENERAL
			l_custom_item: detachable CONF_CONDITION_CUSTOM_ATTRIBUTES
			l_target: like target
			regexp: REGULAR_EXPRESSION
			kmp: KMP_WILD
			l_vars: STRING_TABLE [READABLE_STRING_32]

			s: STRING_8
			b: BOOLEAN
			utf: UTF_CONVERTER
		do
			Result := True
			l_target := target
			l_vars := a_state.custom_variables

			l_var_key := a_custom_name
			l_var_val := l_vars.item (l_var_key)
			if l_var_val = Void then
				l_var_val := execution_environment.item (l_var_key)
				if l_target /= Void then
					if l_var_val /= Void then
						l_target.record_environ_variable (l_var_val, l_var_key)
					end
				end
			end
			from
				a_custom_values.start
			until
				a_custom_values.after or not Result
			loop
				l_choice := a_custom_values.key_for_iteration
				l_custom_item := a_custom_values.item_for_iteration
				b := False
				if l_var_val /= Void then
					if l_custom_item.is_regular_expression then
						s := utf.utf_32_string_to_utf_8_string_8 (l_choice)
						create regexp
						regexp.compile (s)
						if regexp.is_compiled then
							b := regexp.matches (utf.utf_32_string_to_utf_8_string_8 (l_var_val))
						end
					elseif l_custom_item.is_wildcard then
						s := utf.utf_32_string_to_utf_8_string_8 (l_choice)
						create kmp.make (l_choice, l_var_val)
						b := kmp.pattern_matches
					elseif l_custom_item.is_case_insensitive then
						b := l_choice.is_case_insensitive_equal (l_var_val)
					else
						b := l_choice.same_string (l_var_val)
					end
				end
				Result := b xor l_custom_item.inverted
				a_custom_values.forth
			end
		end

	custom_attributes_for (a_key, a_value: READABLE_STRING_GENERAL): detachable CONF_CONDITION_CUSTOM_ATTRIBUTES
			-- Exclusion value of `a_key' and `a_value' pair
		require
			a_key_ok: a_key /= Void and then custom.has (a_key.as_lower)
		do
			if attached custom.item (a_key.as_lower) as tb then
				Result := tb.item (a_value)
			end
		end

feature -- Update

	set_target (a_target: like target)
			-- Set associated `target` to `a_target`.
		do
			target := a_target
		end

	add_platform (a_platform: INTEGER)
			-- Add requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			no_invert: attached platform as p implies not p.invert
		local
			l_platform: like platform
		do
			l_platform := platform
			if l_platform = Void then
				l_platform := [create {ARRAYED_LIST [INTEGER]}.make (1), False]
				l_platform.compare_objects
				platform := l_platform
			end
			l_platform.value.force (a_platform)
		end

	exclude_platform (a_platform: INTEGER)
			-- Add an exclude requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			all_invert: attached platform as p implies p.invert
		local
			l_platform: like platform
		do
			l_platform := platform
			if l_platform = Void then
				l_platform := [create {ARRAYED_LIST [INTEGER]}.make (1), True]
				l_platform.compare_objects
				platform := l_platform
			end
			l_platform.value.force (a_platform)
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
			no_invert: attached build as b implies not b.invert
		local
			l_build: like build
		do
			l_build := build
			if l_build = Void then
				l_build := [create {ARRAYED_LIST [INTEGER]}.make (1), False]
				l_build.compare_objects
				build := l_build
			end
			l_build.value.force (a_build)
		end

	exclude_build (a_build: INTEGER)
			-- Add an exclude requirement on `a_build'.
		require
			valid_build: valid_build (a_build)
			all_invert: attached build as b implies b.invert
		local
			l_build: like build
		do
			l_build := build
			if l_build = Void then
				l_build := [create {ARRAYED_LIST [INTEGER]}.make (1), True]
				l_build.compare_objects
				build := l_build
			end
			l_build.value.force (a_build)
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
			not_invert: attached concurrency as c implies not c.invert
		local
			l_concurrency: like concurrency
		do
			l_concurrency := concurrency
			if l_concurrency = Void then
				l_concurrency := [create {ARRAYED_LIST [INTEGER]}.make (1), False]
				l_concurrency.compare_objects
				concurrency := l_concurrency
			end
			l_concurrency.value.force (a_concurrency)
		end

	exclude_concurrency (a_concurrency: INTEGER)
			-- Add an exclude requirement on `a_concurrency'.
		require
			valid_concurrency: valid_concurrency (a_concurrency)
			all_invert: attached concurrency as c implies c.invert
		local
			l_concurrency: like concurrency
		do
			l_concurrency := concurrency
			if l_concurrency = Void then
				l_concurrency := [create {ARRAYED_LIST [INTEGER]}.make (1), True]
				l_concurrency.compare_objects
				concurrency := l_concurrency
			end
			l_concurrency.value.force (a_concurrency)
		end

	wipe_out_concurrency
			-- Wipe out concurrency.
		do
			concurrency := Void
		ensure
			concurrency_void: concurrency = Void
		end

	add_void_safety (a_void_safety: INTEGER)
			-- Add requirement on `a_void_safety'.
		require
			valid_platform: valid_void_safety (a_void_safety)
			not_invert: attached void_safety as c implies not c.invert
		local
			l_void_safety: like void_safety
		do
			l_void_safety := void_safety
			if l_void_safety = Void then
				l_void_safety := [create {ARRAYED_LIST [INTEGER]}.make (1), False]
				l_void_safety.compare_objects
				void_safety := l_void_safety
			end
			l_void_safety.value.force (a_void_safety)
		end

	exclude_void_safety (a_void_safety: INTEGER)
			-- Add an exclude requirement on `a_void_safety'.
		require
			valid_void_safety: valid_void_safety (a_void_safety)
			all_invert: attached void_safety as c implies c.invert
		local
			l_void_safety: like void_safety
		do
			l_void_safety := void_safety
			if l_void_safety = Void then
				l_void_safety := [create {ARRAYED_LIST [INTEGER]}.make (1), True]
				l_void_safety.compare_objects
				void_safety := l_void_safety
			end
			l_void_safety.value.force (a_void_safety)
		end

	wipe_out_void_safety
			-- Wipe out void_safety.
		do
			void_safety := Void
		ensure
			void_safety_void: void_safety = Void
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

	add_custom (a_name, a_value: READABLE_STRING_GENERAL; a_custom_data: CONF_CONDITION_CUSTOM_ATTRIBUTES)
			-- Add requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		local
			l_values: like custom.item_for_iteration
		do
			if attached custom.item (a_name) as l_val then
				l_values := l_val
			else
				create l_values.make (1)
				custom.force (l_values, a_name)
			end
			l_values.force (a_custom_data, a_value)
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

	unset_version (a_type: READABLE_STRING_32)
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
			l_vers: TUPLE [min: detachable CONF_VERSION; max: detachable CONF_VERSION]
		do
			l_vers := [a_min, a_max]
			l_vers.compare_objects
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
			append_list (void_safety, void_safety_names, Result)

			from
				version.start
			until
				version.after
			loop
				if attached version.item_for_iteration.min as l_min then
					Result.append (l_min.version)
					Result.append_string_general (" <= ")
				end
				Result.append_string_general (version.key_for_iteration)
				Result.append_string_general (" version")
				if attached version.item_for_iteration.max as l_max then
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
					custom_ic as l_c
				loop
						-- FIXME: jfiat
					Result.append_string_general (@ custom_ic.key)
					if l_c.inverted then
						if l_c.is_case_insensitive then
							Result.append_string_general (" /<caseless>= ")
						elseif l_c.is_wildcard then
							Result.append_string_general (" /<wildcard>= ")
						elseif l_c.is_regular_expression then
							Result.append_string_general (" /<regexp>= ")
						else
							Result.append_string_general (" /= ")
						end

					else
						if l_c.is_case_insensitive then
							Result.append_string_general (" =<caseless>= ")
						elseif l_c.is_wildcard then
							Result.append_string_general (" =<wildcard>= ")
						elseif l_c.is_regular_expression then
							Result.append_string_general (" =<regexp>= ")
						else
							Result.append_string_general (" = ")
						end
					end
					Result.append_string_general (@ l_c.key)
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
				if attached data as i and then attached i.value as v then
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
	platform_ok: attached platform as p implies p.object_comparison and p.value /= Void
	build_ok: attached build as b implies b.object_comparison and b.value /= Void
	concurrency_ok: attached concurrency as c implies c.object_comparison and attached c.value
	void_safety_ok: attached void_safety as c implies c.object_comparison and attached c.value
	version_not_void: version /= Void
	custom_not_void: custom /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
