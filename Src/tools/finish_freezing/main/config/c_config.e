indexing
	description: "An abstract environment configuration for a C/C++ compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date: $"
	revision: "$revision: $"

deferred class
	C_CONFIG

inherit
	ENV_CONSTANTS
		export
			{NONE} all
		end

	DISPOSABLE

feature {NONE} -- Initalization

	make (a_use_32bit: like use_32bit; a_code: like code; a_desc: like description; a_version: like version) is
			-- Initialize a config
		require
			a_code_attached: a_code /= Void
			not_a_code_is_empty: not a_code.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_version_attached: a_version /= Void
			not_a_version_is_empty: not a_version.is_empty
		do
			use_32bit := a_use_32bit
			code := a_code
			description := a_desc
			version := a_version
		ensure
			use_32bit_set: use_32bit = a_use_32bit
			code_set: code = a_code
			description_set: description = a_desc
			version_set: version = a_version
		end

	frozen initialize is
			-- Initializes internal state variables, if possible
		do
			if not is_initialized and not is_initializing then
				create variable_table.make (3)
				is_initializing := True
				on_initialize
				is_initialized := True
				is_initializing := False
			end
		ensure
			is_initialized: not is_initializing implies is_initialized
		end

	on_initialize is
			-- Does actual initialization
		require
			is_initializing: is_initializing
			not_is_initialized: not is_initialized
		deferred
		ensure
			is_initialized_untouched: is_initialized = old is_initialized
		end

feature -- Clean up

	frozen dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		do
			if is_initialized then
				on_dispose
			end
			is_initialized := False
		ensure then
			not_is_initialized: not is_initialized
		end

feature {NONE} -- Clean up

	on_dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		require
			is_initialized: is_initialized
		do
		ensure
			is_initialized_untouched: is_initialized = old is_initialized
		end

feature -- Access

	install_path: STRING is
			-- Location of Visual Studio install base
		require
			exists: exists
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_ends_with_dir_separator: Result.item (Result.count) = operating_environment.directory_separator
		end

	path_var: STRING is
			-- PATH environment variable
		require
			exists: exists
		do
			Result := variable_for_name (path_var_name)
		ensure
			result_attached: Result /= Void
		end

	include_var: STRING is
			-- INCLUDE environment variable
		require
			exists: exists
		do
			Result := variable_for_name (include_var_name)
		ensure
			result_attached: Result /= Void
		end

	lib_var: STRING is
			-- LIBS environment variable
		require
			exists: exists
		do
			Result := variable_for_name (lib_var_name)
		ensure
			result_attached: Result /= Void
		end

	code: STRING
			-- Compiler id code

	description: STRING
			-- Configuration compiler description

	version: STRING
			-- A version string

	compiler_file_name: STRING
			-- The compiler's file name
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	exists: BOOLEAN is
			-- Indicates if the product exists
		deferred
		end

feature {NONE} -- Status report

	is_initialized: BOOLEAN
			-- Indicates if state was initialized already

	is_initializing: BOOLEAN
			-- Indicates if config is being initialized

	use_32bit: BOOLEAN
			-- Indicates if environment should be evaluated for a 32bit compilation

feature {NONE} -- Variable caching

	extend_variable (a_name: STRING; a_values: STRING) is
			-- Extends internal variable `a_name' with values in `a_values'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty:  not a_name.is_empty
			a_values_attached: a_values /= Void
			variable_table_attached: variable_table /= Void
		local
			l_table: like variable_table
			l_old_values: STRING
			l_new_values: STRING
		do
			l_table := variable_table
			l_old_values := l_table.item (a_name)
			if l_old_values = Void then
				l_new_values := a_values
			else
				create l_new_values.make (l_old_values.count + 1 + a_values.count)
				l_new_values.append (a_values)
				if not a_values.is_empty and not l_old_values.is_empty then
					if l_new_values.item (l_new_values.count) /= ';' then
						l_new_values.append_character (';')
					end
					l_new_values.append (l_old_values)
				end
			end
			l_table.force (l_new_values, a_name)
		ensure
			variable_table_has_a_name: variable_table.has (a_name)
		end

	variable_for_name (a_name: STRING): STRING is
			-- Retrieves varaible for name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			variable_table_attached: variable_table /= Void
		do
			Result := variable_table.item (a_name)
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	variable_table: HASH_TABLE [STRING, STRING]
			-- Table of cached variables and values.
			-- To extend use safe `extend_variable'
			-- To query use `variable_for_name'

invariant
	variable_table_attached: is_initialized implies variable_table /= Void
	code_attached: code /= Void
	not_code_is_empty: not code.is_empty
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty
	version_attached: version /= Void
	not_version_is_empty: not version.is_empty

indexing
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
