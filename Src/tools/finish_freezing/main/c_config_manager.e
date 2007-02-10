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

	configs: LIST [C_CONFIG] is
			-- List of C compiler configurations
		do
			Result := internal_configs
			if Result = Void then
				Result := create_configs (for_32bit)
				internal_configs := Result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	has_applicable_config: BOOLEAN is
			-- Determines if a compatible C compiler was found on the user's machine
		local
			l_configs: like configs
			l_config: C_CONFIG
			l_cursor: CURSOR
			l_stop: BOOLEAN
		do
			l_configs := configs
			l_cursor := l_configs.cursor
			from l_configs.start until l_configs.after or l_stop loop
				l_config := l_configs.item
				l_stop := l_config.exists
				if not l_stop then
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

feature {NONE} -- Access

	create_configs (a_use_32bit: BOOLEAN): ARRAYED_LIST [C_CONFIG] is
			-- Visual Studio configuration for x64/x86 platforms
		require
			a_use_32bit_for_x86: not is_windows_x64 implies not a_use_32bit
		do
			create Result.make (5)
			Result.extend (create {PSDK_CONFIG}.make ("Microsoft\Microsoft SDKs\Windows\v6.0\WinSDKCompiler", a_use_32bit))
			Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\8.0\Setup\VC", a_use_32bit))
			if not is_windows_x64 then
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.1\Setup\VC", True))
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\7.0\Setup\VC", True))
				Result.extend (create {VS_CONFIG}.make ("Microsoft\VisualStudio\6.0\Setup\Microsoft Visual C++", True))
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

	internal_configs: like configs
			-- Cached version of `configs'
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
