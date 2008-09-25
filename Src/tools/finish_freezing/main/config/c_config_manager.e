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

	config_codes: !LIST [!STRING]
			-- List of available configuration codes
		local
			l_codes: !ARRAYED_LIST [!STRING]
			l_configs: !like configs
		do
			if {l_result: LIST [!STRING]} internal_config_codes then
				Result := l_result
			else
				l_configs := configs
				create l_codes.make (l_configs.count)
				l_codes.compare_objects
				l_configs.do_all (agent (ia_item: !C_CONFIG; ia_list: !ARRAYED_LIST [!STRING])
					do
						if {l_code: STRING} ia_item.code.as_string_8 then
							ia_list.extend (l_code)
						end
					end (?, l_codes))
				Result := l_codes
				internal_config_codes := Result
			end
		ensure
			result_consistent: Result = config_codes
			result_count_matches_config_count: Result.count = configs.count
			result_compares_objects: Result.object_comparison
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
		end

	configs: !LIST [!C_CONFIG]
			-- List of C compiler configurations
		do
			if {l_result: LIST [!C_CONFIG]} internal_configs then
				Result := l_result
			else
				Result := create_configs (for_32bit or not {PLATFORM_CONSTANTS}.is_64_bits)
				internal_configs := Result
			end
		ensure
			not_result_is_empty: not Result.is_empty
			ordered_deprecation: Result.for_all (agent (ia_item: !C_CONFIG; ia_dep: !CELL [BOOLEAN]): BOOLEAN
				do
					if ia_item.is_deprecated then
						ia_dep.put (True)
						Result := True
					else
						Result := not ia_dep.item
					end
				end (?, create {CELL [BOOLEAN]}))
			result_consistent: Result = configs
		end

	ordered_configs: !LIST [!C_CONFIG]
			-- List of sorted configurations, by description.
		local
			l_configs: !like configs
			l_cursor: CURSOR
			l_item: !C_CONFIG
			l_ordered_list: !ARRAYED_LIST [!C_CONFIG]
		do
			if {l_result: LIST [!C_CONFIG]} internal_ordered_configs then
				Result := l_result
			else
				l_configs := configs
				l_cursor := l_configs.cursor
				create l_ordered_list.make (l_configs.count)
				from l_configs.start until l_configs.after loop
					l_item := l_configs.item
					if l_ordered_list.is_empty then
						l_ordered_list.put_front (l_item)
					else
						from
							l_ordered_list.start
						until
							l_ordered_list.after or else
							l_ordered_list.item.version < l_item.version
						loop
							l_ordered_list.forth
						end
						l_ordered_list.put_left (l_item)
					end
					l_configs.forth
				end
				l_configs.go_to (l_cursor)
				Result := l_ordered_list
				internal_ordered_configs := Result
			end
		ensure
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
			not_result_is_empty: not Result.is_empty
			result_count_matches_config_count: Result.count = configs.count
			result_consistent: Result = ordered_configs
		end

	applicable_config_codes: !LIST [!STRING] is
			-- List of available and applicable configuration codes
		local
			l_list: !ARRAYED_LIST [!STRING]
			l_configs: !like applicable_configs
		do
			if {l_result: !LIST [!STRING]} internal_applicable_config_codes then
				Result := l_result
			else
				l_configs := applicable_configs
				create l_list.make (l_configs.count)
				l_list.compare_objects

				l_configs.do_all (agent (ia_item: !C_CONFIG; ia_list: !ARRAYED_LIST [!STRING])
					local
						l_code: STRING
					do
						if ia_item /= Void then
							check ia_item_exists: ia_item.exists end
							l_code := ia_item.code
							if l_code /= Void then
								ia_list.extend (l_code)
							end
						end
					end (?, l_list))
				Result := l_list
				internal_applicable_config_codes := Result
			end
		ensure
			result_count_big_enough: Result.count <= configs.count
			result_compares_objects: Result.object_comparison
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
			result_consistent: Result = applicable_config_codes
		end

	applicable_configs: !LIST [!C_CONFIG]
			-- Applicable configurations given user's machine state.
		local
			l_list: !ARRAYED_LIST [!C_CONFIG]
			l_configs: !like configs
			l_config: !C_CONFIG
		do
			if {l_result: !LIST [!C_CONFIG]} internal_applicable_configs then
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
			configs_unmoved: configs.cursor.is_equal (old configs.cursor)
			result_consistent: Result = applicable_configs
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

	best_configuration: ?C_CONFIG is
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

	config_from_code (a_code: STRING; a_applicable_only: BOOLEAN): ?C_CONFIG is
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

	create_configs (a_use_32bit: BOOLEAN): !ARRAYED_LIST [!C_CONFIG] is
			-- Visual Studio configuration for x64/x86 platforms.
			--|Be sure to place deprecated configurations after all valid configurations!
		require
			a_use_32bit_for_x86: not a_use_32bit implies {PLATFORM_CONSTANTS}.is_64_bits
		local
			l_32_bits: BOOLEAN
		do
			l_32_bits := not {PLATFORM_CONSTANTS}.is_64_bits or else a_use_32bit
			create Result.make (7)

				-- VS 9.0
			Result.extend (create {WSDK_CONFIG}.make ("Microsoft\Microsoft SDKs\Windows\v6.1\WinSDK", a_use_32bit, "WSDK61", "Microsoft Windows SDK 6.1", "2008-WSDK", False))
			Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\9.0\Setup\VC", a_use_32bit, "VC90", "Microsoft Visual Studio 2008 VC++ (9.0)", "2008-VS", False))
			if l_32_bits then
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VCExpress\9.0\Setup\VC", True, "VC90X", "Microsoft Visual C++ 2008 Express (9.0)", "2008-VC", False))
			end

				-- VS 8.0
			Result.extend (create {WSDK_CONFIG}.make ("Microsoft\Microsoft SDKs\Windows\v6.0\WinSDKCompiler", a_use_32bit, "WSDK60", "Microsoft Windows SDK 6.0", "2006-WSDK", False))
			Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\8.0\Setup\VC", a_use_32bit, "VC80", "Microsoft Visual Studio 2005 VC++ (8.0)", "2005-VS", False))

			if l_32_bits then
					-- VS Other
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.1\Setup\VC", True, "VC71", "Microsoft Visual Studio .NET 2003 VC++ (7.1)", "2001-VS", True))
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.0\Setup\VC", True, "VC70", "Microsoft Visual Studio .NET 2002 VC++ (7.0)", "2002-VS", True))
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\6.0\Setup\Microsoft Visual C++", True, "VC60", "Microsoft Visual Studio VC++ (6.0)", "199x-VS", True))
			end
		ensure
			ordered_deprecation: Result.for_all (agent (ia_item: !C_CONFIG; ia_dep: !CELL [BOOLEAN]): BOOLEAN
				do
					if ia_item.is_deprecated then
						ia_dep.put (True)
						Result := True
					else
						Result := not ia_dep.item
					end
				end (?, create {CELL [BOOLEAN]}))
		end

feature {NONE} -- Internal implementation cache

	internal_config_codes: ?like config_codes
			-- Cached version of `config_codes'
			-- Note: Do not use directly

	internal_configs: ?like configs
			-- Cached version of `configs'
			-- Note: Do not use directly

	internal_ordered_configs: ?like ordered_configs
			-- Cached version of `ordered_configs'
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
