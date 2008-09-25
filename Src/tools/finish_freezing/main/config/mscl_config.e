indexing
	description: "[
		A Visual Studio VC compiler configuration.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	MSCL_CONFIG

inherit
	C_CONFIG
		rename
			make as make_c_config
		redefine
			on_dispose
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {NONE} -- Initalization

	make (a_key: like product_reg_path; a_use_32bit: like use_32bit; a_code: like code; a_desc: like description; a_version: like version; a_deprecated: like is_deprecated) is
			-- Initialize a config from a relative HKLM\SOFTWARE registry key `a_key'.
		require
			a_key_attached: a_key /= Void
			not_a_key_is_empty: not a_key.is_empty
			a_code_attached: a_code /= Void
			not_a_code_is_empty: not a_code.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_version_attached: a_version /= Void
			not_a_version_is_empty: not a_version.is_empty
		do
			make_c_config (a_use_32bit, a_code, a_desc, a_version)
			product_reg_path := a_key
			is_deprecated := a_deprecated
		ensure
			product_reg_path_set: product_reg_path = a_key
			use_32bit_set: use_32bit = a_use_32bit
			code_set: code = a_code
			is_deprecated_set: is_deprecated = a_deprecated
		end

	on_initialize is
			-- Does actual initialization
		local
			l_file_name: like batch_file_name
			l_parser: ENV_PARSER
		do
			open_key
			if exists then
				l_file_name := batch_file_name
				if (create {RAW_FILE}.make (l_file_name)).exists then
					create l_parser.make (l_file_name, batch_file_arguments, batch_file_options)
					extend_variable (path_var_name, l_parser.path)
					extend_variable (include_var_name, l_parser.include)
					extend_variable (lib_var_name, l_parser.lib)
				else
						-- Reset `internal_reg_key' to default value.
					reset_key
				end

				if is_eiffel_layout_defined and then eiffel_layout.is_valid_environment then
						-- Added runtime include and lib paths
					extend_variable (include_var_name, eiffel_layout.runtime_include_path)
					extend_variable (lib_var_name, eiffel_layout.runtime_lib_path)
				end
			end
		end

feature {NONE} -- Clean up

	on_dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		do
			if internal_reg_key /= default_pointer then
				reset_key
			end
		end

	reset_key is
			-- Reset `ionternal_reg_key'.
		require
			internal_reg_key_computed: internal_reg_key /= default_pointer
		do
			registry.close_key (internal_reg_key)
			internal_reg_key := default_pointer
		ensure
			internal_reg_key_reset: internal_reg_key = default_pointer
		end

feature -- Access

	install_path: STRING is
			-- Location of Visual Studio install base
		local
			l_value: WEL_REGISTRY_KEY_VALUE
		do
			initialize
			l_value := registry.key_value (internal_reg_key, install_path_value_name)
			if l_value /= Void and then l_value.type = {WEL_REGISTRY_KEY_VALUE}.reg_sz then
				Result := l_value.string_value
				if not Result.is_empty then
					if Result.item (Result.count) /= operating_environment.directory_separator then
						Result.append_character (operating_environment.directory_separator)
					end
				end
			end
			if Result = Void or else Result.is_empty then
				Result := ".\"
			end
		end

	compiler_file_name: STRING
			-- The compiler's file name
		once
			Result := "cl.exe"
		end

feature {NONE} -- Access

	batch_file_name: STRING is
			-- Absolute path to an environment configuration batch script
		require
			exists: exists
		deferred
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	batch_file_arguments: STRING is
			-- Arguments for `batch_file_name' execution
		require
			exists: exists
		do
		ensure
			not_result_sis_empty: Result /= Void implies not Result.is_empty
		end

	batch_file_options: STRING is
			-- Option to the COMSPEC DOS prompt.
		require
			exists: exists
		do
			create Result.make_empty
		ensure
			batch_file_options_not_void: Result /= Void
		end

	product_reg_path: STRING
			-- Relative registry location

	full_product_reg_path: STRING is
			-- Absolute product registry location
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	install_path_value_name: STRING is
			-- Key value name for install location
		deferred
		end

	registry: WEL_REGISTRY is
			-- Access to registry
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	exists: BOOLEAN is
			-- Indicates if the product exists
		do
			initialize
			Result := internal_reg_key /= default_pointer
		end

	is_deprecated: BOOLEAN
			-- Indicates if the product is deprecated.

feature {NONE} -- Basic operations

	open_key is
			-- Attempts to open the specified registery key
		require
			not_is_initialized: not is_initialized
			not_exists: not exists
		do
			check internal_reg_key_is_null: internal_reg_key = default_pointer end
			internal_reg_key := registry.open_key_with_access (full_product_reg_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
		end

feature {NONE} -- Internal implementation cache

	internal_reg_key: POINTER
			-- Cached registry key pointer

invariant
	internal_reg_key_not_null: exists implies internal_reg_key /= default_pointer

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
