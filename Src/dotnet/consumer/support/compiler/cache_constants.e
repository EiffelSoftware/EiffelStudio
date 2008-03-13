indexing
	description: "Global cache constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_CONSTANTS

feature -- Access

	short_cache_name: STRING is "md"
			-- Short cache name.
			-- Note: this should be as short as possible given file name
			-- length restriction on Windows. This is name used when
			-- running in `conservative_mode'

	cache_bit_platform: STRING is
			-- Bit platform cache used under
		once
			if {PLATFORM_CONSTANTS}.is_64_bits then
				Result := x64_directory_name
			else
				Result := x86_directory_name
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	cache_name: STRING is "MetadataConsumer"
			-- Cache name.

	conservative_mode: BOOLEAN is True
			-- State to indicate if cache should be conservative when creating paths
			-- to cached contents

	cache_info_file: STRING is "eac.info"
			-- Name of file with information about what is stored in the cache.

	classe_info_file: STRING is "classes.info"
			-- Name of file which has informations about which classes exist in an assembly.

	referenced_assemblies_info_file: STRING is "referenced_assemblies.info"
			-- Name of file which has information about referenced assemblies.

	types_info_file: STRING is "types.info"
			-- Name of file which has information about the types in an assembly.

	null_key_string: STRING is "null"
			-- Null key string.

feature {NONE} -- Constants

	x64_directory_name: STRING = "x64"
	x86_directory_name: STRING = "x86"
			-- Bit platform directory names.

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

end -- class {CACHE_CONSTANTS}
