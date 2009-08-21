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
			out,
			is_equal
		end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
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

	multithreaded: CELL [BOOLEAN]
			-- Enabled for multithreaded?

	dotnet: CELL [BOOLEAN]
			-- Enabled for dotnet?

	dynamic_runtime: CELL [BOOLEAN]
			-- Enabled for dynamic runtime?

	version: HASH_TABLE [EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]], STRING]
			-- Enabled for a certain version number? Indexed by the type of the version number.

	custom: HASH_TABLE [EQUALITY_TUPLE [TUPLE [value: STRING_GENERAL; invert: BOOLEAN]], STRING_GENERAL]
			-- Custom variables that have to be fullfilled indexed by the variable name.

feature -- Queries

	satisfied (a_state: CONF_STATE): BOOLEAN
			-- Does `a_state' satisfy `Current'?
		require
			a_state_not_void: a_state /= Void
		local
			l_cust_cond: EQUALITY_TUPLE [TUPLE [value: STRING_GENERAL; invert: BOOLEAN]]
			l_vars: EQUALITY_HASH_TABLE [STRING_GENERAL, STRING_GENERAL]
			l_version: HASH_TABLE [CONF_VERSION, STRING]
			l_ver_cond: EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]]
			l_ver_state: CONF_VERSION
			l_var_key, l_var_val: STRING_GENERAL
		do
			Result := True
				-- multithreaded
			if Result and multithreaded /= Void then
				Result := a_state.is_multithreaded = multithreaded.item
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
					l_cust_cond := custom.item_for_iteration
					l_var_key := custom.key_for_iteration
					l_var_val := l_vars.item (l_var_key)
					if l_var_val = Void then
						check
							l_var_key_valid_as_string_8: l_var_key.is_valid_as_string_8
						end
						l_var_val := execution_environment.variable_value (l_var_key.as_string_8)
					end
					Result := equal (l_var_val, l_cust_cond.item.value) xor l_cust_cond.item.invert
					custom.forth
				end
			end
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

	set_multithreaded (a_value: BOOLEAN)
			-- Set `multithreaded' to `a_value'.
		do
			create multithreaded.put (a_value)
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

	unset_multithreaded
			-- Unset `multithreaded'.
		do
			multithreaded := Void
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

	add_custom (a_name, a_value: STRING)
			-- Add requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			custom.force (create {EQUALITY_TUPLE [TUPLE [STRING_GENERAL, BOOLEAN]]}.make ([a_value, False]), a_name)
		end

	exclude_custom (a_name, a_value: STRING)
			-- Add exclude requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			custom.force (create {EQUALITY_TUPLE [TUPLE [STRING_GENERAL, BOOLEAN]]}.make ([a_value, True]), a_name)
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
		local
			l_conc: STRING
			l_lst: ARRAYED_LIST [INTEGER]
		do
			create Result.make_empty
			if platform /= Void then
				if platform.item.invert then
					Result.append ("not ")
					l_conc := " and "
				else
					l_conc := " or "
				end
				Result.append ("(")
				from
					l_lst := platform.item.value
					l_lst.start
				until
					l_lst.after
				loop
					Result.append (platform_names.item (l_lst.item) + l_conc)
					l_lst.forth
				end
				Result.remove_tail (l_conc.count)
				Result.append (") and ")
			end

			if build /= Void then
				if build.item.invert then
					Result.append ("not ")
					l_conc := " and "
				else
					l_conc := " or "
				end
				Result.append ("(")
				from
					l_lst := build.item.value
					l_lst.start
				until
					l_lst.after
				loop
					Result.append (build_names.item (l_lst.item) + l_conc)
					l_lst.forth
				end
				Result.remove_tail (l_conc.count)
				Result.append (") and ")
			end

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

			if multithreaded /= Void then
				if multithreaded.item then
					Result.append ("multithreaded and ")
				else
					Result.append ("not multithreaded and ")
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
					is_valid_as_string_8: custom.item_for_iteration.item.value.is_valid_as_string_8
				end
				Result.append (custom.key_for_iteration.as_string_8)
				if custom.item_for_iteration.item.invert then
					Result.append (" /= ")
				else
					Result.append (" = ")
				end
				Result.append (custom.item_for_iteration.item.value.as_string_8 + " and ")
				custom.forth
			end

				-- remove last " and "
			if not Result.is_empty then
				Result.remove_tail (5)
			end
		ensure then
			Result_not_void: Result /= Void
		end

invariant
	platform_ok: platform /= Void implies platform.item.value /= Void
	build_ok: build /= Void implies build.item.value /= Void
	version_not_void: version /= Void
	custom_not_void: custom /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
