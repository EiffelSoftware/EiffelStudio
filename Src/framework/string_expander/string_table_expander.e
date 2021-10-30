note
	description: "[
			A string expander utilizing a custom table of variables as its source of variable values.
			Environment variables can also be used, if a variable is not found in the custom table.
			
			See {STRING_EXPANDER} for details on variable styles and expansion.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_TABLE_EXPANDER

inherit
	STRING_ENVIRONMENT_EXPANDER
		rename
			expand_string as expand_string_internal,
			expand_string_32 as expand_string_32_internal
		export {NONE}
			expand_string_internal,
			expand_string_32_internal
		redefine
			use_environment_variables,
			variable,
			variable_32
		end

feature {NONE} -- Access

	table_8: detachable HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Table of variable names to value mappings for `expand_string'.

	table_32: detachable HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			-- Table of variable names to value mappings for `expand_string_32'.

feature {NONE} -- Status report

	use_environment_variables: BOOLEAN
			-- <Precursor>

feature -- Query

	expand_string (a_string: READABLE_STRING_8; a_table: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]; a_use_env: BOOLEAN; a_keep: BOOLEAN): STRING
			-- Expands a 8-bit string and replaces any variable values.
			--
			-- `a_string' : The string to expand.
			-- `a_table'  : A table of variables to use for replacement.
			-- `a_use_env': True to make use of environment variables, if `a_table' doesn't have a match;
			--              False to ignore.
			-- `a_keep'   : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'   : An expanded string with the match variable expanded.
		require
			a_string_attached: a_string /= Void
			a_table_attached: a_table /= Void
		local
			l_compare_objects: BOOLEAN
		do
			l_compare_objects := a_table.object_comparison
			if not l_compare_objects then
				a_table.compare_objects
			end
			table_8 := a_table
			use_environment_variables := a_use_env
			Result := expand_string_internal (a_string, a_keep)
			if not l_compare_objects then
				a_table.compare_references
			end
			table_8 := Void
		ensure
			table_detached: table_8 = Void
		end

	expand_string_32 (a_string: READABLE_STRING_32; a_table: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]; a_use_env: BOOLEAN; a_keep: BOOLEAN): STRING_32
			-- Expands a 32-bit string and replaces any variable values.
			--
			-- `a_string' : The string to expand.
			-- `a_table'  : A table of variables to use for replacement.
			-- `a_use_env': True to make use of environment variables, if `a_table' doesn't have a match;
			--              False to ignore.
			-- `a_keep'   : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'   : An expanded string with the match variable expanded.
		require
			a_string_attached: a_string /= Void
			a_table_attached: a_table /= Void
		local
			l_compare_objects: BOOLEAN
		do
			l_compare_objects := a_table.object_comparison
			if not l_compare_objects then
				a_table.compare_objects
			end
			table_32 := a_table
			use_environment_variables := a_use_env
			Result := expand_string_32_internal (a_string, a_keep)
			if not l_compare_objects then
				a_table.compare_references
			end
			table_32 := Void
		ensure
			table_detached: table_32 = Void
		end

feature {NONE} -- Query

	variable (a_id: READABLE_STRING_8): detachable STRING_8
			-- <Precursor>
		do
			if attached table_8 as l_table then
				if attached l_table.item (a_id) as l_value then
					check is_valid_as_string_8: l_value.is_valid_as_string_8 end
					create Result.make (l_value.count)
					Result.append (l_value)
				end
			else
				check compatible_table_set: False end
			end

			if not attached Result then
				Result := Precursor (a_id)
			end
		end

	variable_32 (a_id: READABLE_STRING_32): detachable STRING_32
			-- <Precursor>
		do
			if attached table_32 as l_table then
				if attached l_table.item (a_id) as l_value then
					create Result.make (l_value.count)
					Result.append (l_value)
				end
			else
				check compatible_table_set: False end
			end

			if not attached Result then
				Result := Precursor (a_id)
			end
		end

invariant
	table_8_compares_objects: (attached table_8 as l_table_8) implies l_table_8.object_comparison
	table_32_compares_objects: (attached table_32 as l_table_32) implies l_table_32.object_comparison

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
