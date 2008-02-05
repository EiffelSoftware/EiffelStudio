indexing
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

	make (a_for_32bit: like for_32bit) is
			-- Initializes configuration manager given `for_32bit'
		do
			for_32bit := a_for_32bit
		ensure
			for_32bit_set: for_32bit = a_for_32bit
		end

feature -- Access

	for_32bit: BOOLEAN
			-- Indicates if manager is to be used in a 32bit environment

	config_codes: LIST [STRING] is
			-- List of available configuration codes
		local
			l_result: ARRAYED_LIST [STRING]
			l_configs: like configs
		do
			Result := internal_config_codes
			if Result = Void then
				l_configs := configs
				create l_result.make (l_configs.count)
				l_result.compare_objects

				l_configs.do_all (agent (a_item: C_CONFIG; a_list: ARRAYED_LIST [STRING])
					do
						if a_item /= Void then
							a_list.extend (a_item.code)
						end
					end (?, l_result))
				Result := l_result
				internal_config_codes := Result
			end
		ensure
			result_attached: Result /= Void
			result_count_matches_config_count: Result.count = configs.count
			result_compares_objects: Result.object_comparison
			result_contains_attached_items: not Result.has (Void)
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
		end

	configs: LIST [C_CONFIG] is
			-- List of C compiler configurations
		do
			Result := internal_configs
			if Result = Void then
				Result := create_configs (for_32bit or not is_windows_x64)
				internal_configs := Result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_attached_items: not Result.has (Void)
		end

	applicable_config_codes: LIST [STRING] is
			-- List of available and applicable configuration codes
		local
			l_result: ARRAYED_LIST [STRING]
			l_configs: like applicable_configs
		do
			Result := internal_applicable_config_codes
			if Result = Void then
				l_configs := applicable_configs
				create l_result.make (l_configs.count)
				l_result.compare_objects

				l_configs.do_all (agent (a_item: C_CONFIG; a_list: ARRAYED_LIST [STRING])
					do
						if a_item /= Void then
							check a_item_exists: a_item.exists end
							a_list.extend (a_item.code)
						end
					end (?, l_result))
				Result := l_result
				internal_applicable_config_codes := Result
			end
		ensure
			result_attached: Result /= Void
			result_count_big_enough: Result.count <= configs.count
			result_compares_objects: Result.object_comparison
			result_contains_attached_items: not Result.has (Void)
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
		end

	applicable_configs: LIST [C_CONFIG] is
			-- Applicable configurations given user's machine state.
		local
			l_result: ARRAYED_LIST [C_CONFIG]
			l_configs: like configs
			l_config: C_CONFIG
		do
			Result := internal_applicable_configs
			if Result = Void then
				l_configs := configs
				create l_result.make (l_configs.count)
				l_result.append (l_configs)
				from l_result.start until l_result.after loop
					l_config := l_result.item
					if not l_config.exists then
						l_result.remove
					else
						l_result.forth
					end
				end
				Result := l_result
				internal_applicable_configs := Result
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
		end

feature -- Status report

	has_applicable_config: BOOLEAN is
			-- Determines if a compatible C compiler was found on the user's machine
		local
			l_configs: like configs
			l_config: C_CONFIG
			l_cursor: CURSOR
		do
			l_configs := configs
			l_cursor := l_configs.cursor
			from l_configs.start until l_configs.after or Result loop
				l_config := l_configs.item
				Result := l_config.exists
				if not Result then
					l_config := Void
					l_configs.forth
				end
			end
			l_configs.go_to (l_cursor)
		ensure
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
		end

	best_configuration: C_CONFIG is
			-- Retrieve's the best C compiler configuration given the state of a user's system
		require
			has_applicable_config: has_applicable_config
		local
			l_configs: like configs
			l_config: C_CONFIG
			l_cursor: CURSOR
		do
			l_configs := configs
			l_cursor := l_configs.cursor
			from l_configs.start until l_configs.after or Result /= Void loop
				l_config := l_configs.item
				if l_config.exists then
					Result := l_config
				else
					l_configs.forth
				end
			end
			l_configs.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

	config_from_code (a_code: STRING; a_applicable_only: BOOLEAN): C_CONFIG is
			-- Retrieves a config from the code `a_code'. If `a_applicable_only' is set to True
			-- the located configuration must exists in order to return a result
		require
			a_code_attached: a_code /= Void
			not_a_code_is_empty: not a_code.is_empty
		local
			l_configs: like configs
			l_config: C_CONFIG
			l_cursor: CURSOR
		do
			l_configs := configs
			l_cursor := l_configs.cursor
			from l_configs.start until l_configs.after or Result /= Void loop
				l_config := l_configs.item
				if l_config.code.is_case_insensitive_equal (a_code) then
					Result := l_config
					if a_applicable_only and not l_config.exists then
						Result := Void
					end
				end
				l_configs.forth
			end
			l_configs.go_to (l_cursor)
		ensure
			result_exists: a_applicable_only implies (Result = Void or else Result.exists)
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
		end

feature {NONE} -- Access

	create_configs (a_use_32bit: BOOLEAN): ARRAYED_LIST [C_CONFIG] is
			-- Visual Studio configuration for x64/x86 platforms
		require
			a_use_32bit_for_x86: not a_use_32bit implies not is_windows_x64
		do
			create Result.make (5)
			Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\9.0\Setup\VC", a_use_32bit, "VC90", "Microsoft Visual Studio 2008 VC++ 9.0"))
			Result.extend (create {WSDK_CONFIG}.make ("Microsoft\Microsoft SDKs\Windows\v6.0\WinSDKCompiler", a_use_32bit, "WSDK60", "Microsoft Windows SDK 6.0"))
			Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\8.0\Setup\VC", a_use_32bit, "VC80", "Microsoft Visual Studio 2005 VC++ 8.0"))
			if not is_windows_x64 or else a_use_32bit then
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.1\Setup\VC", True, "VC71", "Microsoft Visual Studio .NET 2003 VC++ 7.1"))
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.0\Setup\VC", True, "VC70", "Microsoft Visual Studio .NET 2002 VC++ 7.0"))
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\6.0\Setup\Microsoft Visual C++", True, "VC60", "Microsoft Visual Studio VC++ 6.0"))
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Externals

	is_windows_x64: BOOLEAN is
			-- Is Current running on Windows 64 bits?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_64_BITS"
		end

feature {NONE} -- Internal implementation cache

	internal_config_codes: like config_codes
			-- Cached version of `config_codes'
			-- Note: Do not use directly

	internal_configs: like configs
			-- Cached version of `configs'
			-- Note: Do not use directly

	internal_applicable_config_codes: like applicable_config_codes
			-- Cached version of `applicable_config_codes'
			-- Note: Do not use directly

	internal_applicable_configs: like applicable_configs
			-- Cached version of `applicable_configs'
			-- Note: Do not use directly

;indexing
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
end
