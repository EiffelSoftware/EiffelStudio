note
	description: "Manages C compiler configurations so clients can access the appropriate configuration with ease"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	C_CONFIG_MANAGER

create
	make

feature -- Initialization

	make (a_for_32bit: like for_32bit)
			-- Initializes configuration manager given `for_32bit'
		do
			for_32bit := a_for_32bit
			initialize_configs (a_for_32bit or not {PLATFORM}.is_64_bits)
		ensure
			for_32bit_set: for_32bit = a_for_32bit
		end

feature -- Access

	for_32bit: BOOLEAN
			-- Indicates if manager is to be used in a 32bit environment

	config_codes: ARRAYED_LIST [STRING]
			-- List of available configuration codes
		local
			l_codes: ARRAYED_LIST [STRING]
			l_configs: like configs
			l_config: detachable C_CONFIG
			l_result: like internal_config_codes
			l_cursor: CURSOR
		do
			l_result := internal_config_codes
			if l_result /= Void then
				Result := l_result
			else
				l_configs := configs
				create l_codes.make (l_configs.count)
				l_codes.compare_objects
				l_cursor := l_configs.cursor
				from l_configs.start until l_configs.after loop
					l_config := l_configs.item_for_iteration
					check l_config_attached: l_config /= Void end
					l_codes.extend (l_config.code)
					l_configs.forth
				end
				Result := l_codes
				internal_config_codes := Result
			end
		ensure
			configs_unmoved: configs.cursor ~ old configs.cursor
			result_count_matches_config_count: Result.count = configs.count
			result_compares_objects: Result.object_comparison
			result_consistent: Result = config_codes
		end

	configs: ARRAYED_LIST [C_CONFIG]
			-- List of C compiler configurations.

	applicable_config_codes: ARRAYED_LIST [STRING]
			-- List of available and applicable configuration codes.
		local
			l_configs: like applicable_configs
		do
			Result := internal_applicable_config_codes
			if Result = Void then
				l_configs := applicable_configs
				create Result.make (l_configs.count)
				Result.compare_objects
				across l_configs as l_config loop
					Result.extend (l_config.item.code)
				end
				internal_applicable_config_codes := Result
			end
		ensure
			result_count_small_enough: Result.count <= configs.count
			result_compares_objects: Result.object_comparison
			configs_unmoved: configs.cursor ~ old configs.cursor
			result_consistent: Result = applicable_config_codes
		end

	applicable_configs: LIST [C_CONFIG]
			-- Applicable configurations given user's machine state.
		local
			l_list: ARRAYED_LIST [C_CONFIG]
			l_configs: like configs
			l_config: C_CONFIG
			l_result: like internal_applicable_configs
		do
			l_result := internal_applicable_configs
			if l_result /= Void then
				Result := l_result
			else
				l_configs := configs
				create l_list.make (l_configs.count)
				l_list.append (l_configs)
				from l_list.start until l_list.after loop
					l_config := l_list.item
					if not l_config.exists then
						l_list.remove
					else
						l_list.forth
					end
				end
				Result := l_list
				internal_applicable_configs := Result
			end
		ensure
			result_count_small_enough: Result.count <= configs.count
			configs_unmoved: configs.cursor ~ old configs.cursor
			result_consistent: Result = applicable_configs
		end

feature -- Status report

	is_config_code_valid (a_config_code: STRING): BOOLEAN
			-- Is `a_config_code' a known code?
		do
			Result := compatibility_configs.has (a_config_code)
		end

	best_configuration (a_compatible_config: detachable STRING): detachable C_CONFIG
			-- If `a_compatible_config' is not set, retrieves the best C compiler configuration overall.
			-- Otherwise, the best C compiler configuration compatible with `a_compatible_config'.
		require
			compatible_config_not_empty_if_set: a_compatible_config /= Void implies not a_compatible_config.is_empty
			valid_config: a_compatible_config /= Void implies is_config_code_valid (a_compatible_config)
		local
			l_configs: like configs
		do
			if a_compatible_config /= Void then
				l_configs := compatibility_configs.item (a_compatible_config)
					-- Per precondition, we should have a list.
				check l_configs_found: l_configs /= Void end
			else
					-- We use all our known configs
				l_configs := configs
			end
			if attached l_configs then
				across l_configs as l_config until Result /= Void loop
					if l_config.item.exists then
						Result := l_config.item
					end
				end
			end
		ensure
			configs_unmoved: configs.cursor ~ old configs.cursor
		end

	config_from_code (a_code: STRING; a_check_for_existence: BOOLEAN): detachable C_CONFIG
			-- Retrieves a config from the code `a_code'. If `a_check_for_existence' is set to True
			-- the located configuration must exists in order to return a result
		require
			not_a_code_is_empty: not a_code.is_empty
			a_code_valid: is_config_code_valid (a_code)
		do
			across configs as l_config until Result /= Void loop
				if
					l_config.item.code.is_case_insensitive_equal (a_code) and then
					(not a_check_for_existence or else l_config.item.exists)
				then
					Result := l_config.item
				end
			end
		ensure
			result_exists: a_check_for_existence implies (Result = Void or else Result.exists)
			configs_unmoved: configs.cursor ~ old configs.cursor
		end

feature {NONE} -- Access

	initialize_configs (a_use_32bit: BOOLEAN)
			-- Visual Studio configuration for x64/x86 platforms.
			--|Be sure to place deprecated configurations after all valid configurations!
		require
			a_use_32bit_for_x86: not a_use_32bit implies {PLATFORM}.is_64_bits
		local
			l_32_bits: BOOLEAN
			l_configs: ARRAYED_LIST [C_CONFIG]
			l_c_config: C_CONFIG
		do
			l_32_bits := not {PLATFORM}.is_64_bits or else a_use_32bit

			create compatibility_configs.make_caseless (2)
			create configs.make (10)

				-- Group of compatible C compilers.
			create l_configs.make (1)

				-- VS 17.0 (aka VS 2022 all editions)
			create {VS_SETUP_CUSTOM_CONFIG} l_c_config.make (a_use_32bit, "VC170", "Microsoft Visual Studio 2022 VC++ (17.0)", "2022-VS", 17)
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)

				-- VS 16.0 (aka VS 2019 all editions)
			create {VS_SETUP_CUSTOM_CONFIG} l_c_config.make (a_use_32bit, "VC160", "Microsoft Visual Studio 2019 VC++ (19.0)", "2019-VS", 16)
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)

				-- VS 15.0 (aka VS 2017 all editions)
			create {VS_SETUP_CUSTOM_CONFIG} l_c_config.make (a_use_32bit, "VC150", "Microsoft Visual Studio 2017 VC++ (15.0)", "2017-VS", 15)
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)

				-- VS 14.0 (aka VS 2015 all editions)
			create {VS_2015_CONFIG} l_c_config.make ("Microsoft\VisualStudio\14.0\Setup\VC", a_use_32bit, "VC140", "Microsoft Visual Studio 2015 VC++ (14.0)", "2015-VS")
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)

				-- Update `configs' with group.
			configs.append (l_configs)


				-- Group of compatible C compilers.
			create l_configs.make (1)
				-- VS 12.0 (aka VS 2013)
			create {VS_NEW_CONFIG} l_c_config.make ("Microsoft\VisualStudio\12.0\Setup\VC", a_use_32bit, "VC120", "Microsoft Visual Studio 2013 VC++ (12.0)", "2013-VS")
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)

				-- VS 11.0 (aka VS 2012)
			create {VS_NEW_CONFIG} l_c_config.make ("Microsoft\VisualStudio\11.0\Setup\VC", a_use_32bit, "VC110", "Microsoft Visual Studio 2012 VC++ (11.0)", "2012-VS")
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)

				-- Windows SDKs
			create {WSDK_CONFIG} l_c_config.make ("Microsoft\Microsoft SDKs\Windows\v7.1", a_use_32bit, {WSDK_CONFIG}.wsdk_71, "Microsoft Windows SDK 7.1 (Windows 7)", "2010-WSDK")
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)

				-- VS 10.0 (aka VS 2010)
			create {VS_NEW_CONFIG} l_c_config.make ("Microsoft\VisualStudio\10.0\Setup\VC", a_use_32bit, "VC100", "Microsoft Visual Studio 2010 VC++ (10.0)", "2010-VS")
			l_configs.extend (l_c_config)
			compatibility_configs.put (l_configs, l_c_config.code)
			if l_32_bits then
				create {VS_CONFIG} l_c_config.make ("Microsoft\VCExpress\10.0\Setup\VC", True, "VC100X", "Microsoft Visual C++ 2010 Express (10.0)", "2010-VC")
				l_configs.extend (l_c_config)
				compatibility_configs.put (l_configs, l_c_config.code)
			end

				-- Update `configs' with group.
			configs.append (l_configs)
		end

	extend_old_configs (a_list: ARRAYED_LIST [C_CONFIG]; a_use_32bit, is_32_bits: BOOLEAN)
			-- Extend `a_list' with old configs that are not officially supported anymore.
			--| We keep this code for reference only.
		do
				-- Old Windows SDKs
			a_list.extend (create {WSDK_CONFIG}.make ("Microsoft\Microsoft SDKs\Windows\v7.0", a_use_32bit, {WSDK_CONFIG}.wsdk_70, "Microsoft Windows SDK 7.0 (Windows 7)", "2009-WSDK"))
			a_list.extend (create {WSDK_CONFIG}.make ("Microsoft\Microsoft SDKs\Windows\v6.1", a_use_32bit, {WSDK_CONFIG}.wsdk_61, "Microsoft Windows SDK 6.1 (Windows Vista)", "2008-WSDK"))

				-- VS 9.0
			a_list.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\9.0\Setup\VC", a_use_32bit, "VC90", "Microsoft Visual Studio 2008 VC++ (9.0)", "2008-VS"))
			if is_32_bits then
				a_list.extend (create {VS_CONFIG}.make ("Microsoft\VCExpress\9.0\Setup\VC", True, "VC90X", "Microsoft Visual C++ 2008 Express (9.0)", "2008-VC"))
			end

				-- VS 8.0
			a_list.extend (create {WSDK_CONFIG}.make ("Microsoft\Microsoft SDKs\Windows\v6.0\WinSDKCompiler", a_use_32bit, {WSDK_CONFIG}.wsdk_60, "Microsoft Windows SDK 6.0 (Windows Vista)", "2006-WSDK"))
			a_list.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\8.0\Setup\VC", a_use_32bit, "VC80", "Microsoft Visual Studio 2005 VC++ (8.0)", "2005-VS"))

			if is_32_bits then
					-- VS Other
				a_list.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.1\Setup\VC", True, "VC71", "Microsoft Visual Studio .NET 2003 VC++ (7.1)", "2001-VS"))
				a_list.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.0\Setup\VC", True, "VC70", "Microsoft Visual Studio .NET 2002 VC++ (7.0)", "2002-VS"))
				a_list.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\6.0\Setup\Microsoft Visual C++", True, "VC60", "Microsoft Visual Studio VC++ (6.0)", "199x-VS"))
			end
		end

feature {NONE} -- Internal implementation cache

	internal_config_codes: detachable like config_codes
			-- Cached version of `config_codes'
			-- Note: Do not use directly

	internal_configs: detachable like configs
			-- Cached version of `configs'
			-- Note: Do not use directly

	internal_applicable_config_codes: detachable like applicable_config_codes
			-- Cached version of `applicable_config_codes'
			-- Note: Do not use directly

	internal_applicable_configs: detachable like applicable_configs
			-- Cached version of `applicable_configs'
			-- Note: Do not use directly

	compatibility_configs: STRING_TABLE [like configs]
			-- Map C configs code to the list of compatible C configs.

;note
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
