indexing
	description: "Specifies a condition."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITION

inherit
	CONF_VALIDITY
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create.
		do
			create version.make (1)
			create custom.make (1)
		end

feature -- Access

	platform: TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]
			-- Platform where it is enabled or for which it is disabled (if `invert' is true)

	build: TUPLE [value: ARRAYED_LIST [INTEGER]; invert: BOOLEAN]
			-- Build where it is is enabled or for which it is disabled (if `invert' is true)

	multithreaded: CELL [BOOLEAN]
			-- Enabled for multithreaded?

	dotnet: CELL [BOOLEAN]
			-- Enabled for dotnet?

	dynamic_runtime: CELL [BOOLEAN]
			-- Enabled for dynamic runtime?

	version: HASH_TABLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION], STRING]
			-- Enabled for a certain version number? Indexed by the type of the version number.

	custom: HASH_TABLE [TUPLE [value: STRING; invert: BOOLEAN], STRING]
			-- Custom variables that have to be fullfilled indexed by the variable name.

feature -- Queries

	satisfied (a_state: CONF_STATE): BOOLEAN is
			-- Does `a_state' satisfy `Current'?
		require
			a_state_not_void: a_state /= Void
		local
			l_cust_cond: TUPLE [value: STRING; invert: BOOLEAN]
			l_vars: EQUALITY_HASH_TABLE [STRING, STRING]
			l_version: HASH_TABLE [CONF_VERSION, STRING]
			l_ver_cond: TUPLE [min: CONF_VERSION; max: CONF_VERSION]
			l_ver_state: CONF_VERSION
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
				Result := platform.value.has (a_state.platform) xor platform.invert
			end

				-- build
			if Result and build /= Void then
				Result := build.value.has (a_state.build) xor build.invert
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
					Result := l_ver_state /= Void and then (l_ver_cond.min = Void or else l_ver_cond.min <= l_ver_state) and
						(l_ver_cond.max = Void or else l_ver_cond.max >= l_ver_state)
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
					Result := equal (l_vars.item (custom.key_for_iteration), l_cust_cond.value) xor l_cust_cond.invert
					custom.forth
				end
			end
		end

feature -- Update

	add_platform (a_platform: INTEGER) is
			-- Add requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			no_invert: platform = Void or else not platform.invert
		do
			if platform = Void then
				create platform
				platform.value := create {ARRAYED_LIST [INTEGER]}.make (1)
			end
			platform.value.force (a_platform)
		end

	exclude_platform (a_platform: INTEGER) is
			-- Add an exclude requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			all_invert: platform = Void or else platform.invert
		do
			if platform = Void then
				create platform
				platform.value := create {ARRAYED_LIST [INTEGER]}.make (1)
				platform.invert := True
			end
			platform.value.force (a_platform)
		end

	wipe_out_platform is
			-- Wipe out platforms.
		do
			platform := Void
		ensure
			platform_void: platform = Void
		end

	add_build (a_build: INTEGER) is
			-- Add requirement on `a_build'.
		require
			valid_build: valid_build (a_build)
			no_invert: build = Void or else not build.invert
		do
			if build = Void then
				create build
				build.value := create {ARRAYED_LIST [INTEGER]}.make (1)
			end
			build.value.force (a_build)
		end

	exclude_build (a_build: INTEGER) is
			-- Add an exclude requirement on `a_build'.
		require
			valid_build: valid_build (a_build)
			all_invert: build = void or else build.invert
		do
			if build = Void then
				create build
				build.value := create {ARRAYED_LIST [INTEGER]}.make (1)
				build.invert := True
			end
			build.value.force (a_build)
		end

	wipe_out_build is
			-- Wipe out builds.
		do
			build := Void
		ensure
			build_void: build = Void
		end

	set_multithreaded (a_value: BOOLEAN) is
			-- Set `multithreaded' to `a_value'.
		do
			create multithreaded.put (a_value)
		end

	set_dotnet (a_value: BOOLEAN) is
			-- Set `dotnet' to `a_value'.
		do
			create dotnet.put (a_value)
		end

	set_dynamic_runtime (a_value: BOOLEAN) is
			-- Set `dynamic_runtime' to `a_value'.
		do
			create dynamic_runtime.put (a_value)
		end

	unset_multithreaded is
			-- Unset `multithreaded'.
		do
			multithreaded := Void
		end

	unset_dotnet is
			-- Unset `dotnet'.
		do
			dotnet := Void
		end

	unset_dynamic_runtime is
			-- Unset `dynamic_runtime'.
		do
			dynamic_runtime := Void
		end

	add_custom (a_name, a_value: STRING) is
			-- Add requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			custom.force ([a_value, False], a_name)
		end

	exclude_custom (a_name, a_value: STRING) is
			-- Add exclude requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			custom.force ([a_value, True], a_name)
		end

	wipe_out_custom is
			-- Wipe out custom.
		do
			custom.clear_all
		ensure
			custom_empty: custom.is_empty
		end

	unset_version (a_type: STRING) is
			-- Unset version constraint.
		require
			valid_type: valid_version_type (a_type)
		do
			version.remove (a_type)
		ensure
			unset: not version.has (a_type)
		end

	add_version (a_min, a_max: CONF_VERSION; a_type: STRING) is
			-- Set version constraint.
		require
			min_or_max: a_min /= Void or a_max /= Void
			min_less_max: a_min /= Void and a_max /= Void implies a_min <= a_max
			valid_type: valid_version_type (a_type)
		local
			l_vers: TUPLE [min: CONF_VERSION; max: CONF_VERSION]
		do
			create l_vers
			l_vers.min := a_min
			l_vers.max := a_max
			version.force (l_vers, a_type)
		ensure
			version_added: version.has (a_type)
		end

feature -- Output

	out: STRING is
			-- Text representation for the conditions.
		local
			l_conc: STRING
			l_lst: ARRAYED_LIST [INTEGER]
		do
			create Result.make_empty
			if platform /= Void then
				if platform.invert then
					Result.append ("not ")
					l_conc := " and "
				else
					l_conc := " or "
				end
				Result.append ("(")
				from
					l_lst := platform.value
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
				if build.invert then
					Result.append ("not ")
					l_conc := " and "
				else
					l_conc := " or "
				end
				Result.append ("(")
				from
					l_lst := build.value
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
				if version.item_for_iteration.min /= Void then
					Result.append (version.item_for_iteration.min.version + " <= ")
				end
				Result.append (version.key_for_iteration + " version")
				if version.item_for_iteration.max /= Void then
					Result.append (" <= " + version.item_for_iteration.max.version)
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
				Result.append (custom.key_for_iteration)
				if custom.item_for_iteration.invert then
					Result.append (" /= ")
				else
					Result.append (" = ")
				end
				Result.append (custom.item_for_iteration.value + " and ")
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
	platform_ok: platform /= Void implies platform.value /= Void
	build_ok: build /= Void implies build.value /= Void
	version_not_void: version /= Void
	custom_not_void: custom /= Void
end
