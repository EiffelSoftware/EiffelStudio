indexing
	description: "[
		Utilities for parsing and formatting strings found in a code template file.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_FORMAT_UTILITIES

feature -- Parsing

	parse_version (a_version: !STRING_32; a_factory: !CODE_FACTORY): !CODE_VERSION
			-- Parses a code version string and creates a new code version.
			--
			-- `a_version': Version string to parse and create a version for.
			-- `a_factory': The factory used to create the code version.
			-- `Result': A code version related to the version specified.
		require
			not_a_version_is_empty: not a_version.is_empty
		local
			l_parts: LIST [STRING_32]
			l_part: STRING_32
			l_ver: NATURAL_16
			l_major: NATURAL_16
			l_minor: NATURAL_16
			l_revision: NATURAL_16
			l_qfe: NATURAL_16
			l_count, i, j: INTEGER
		do
			if version_regex.matches (a_version) then
					-- Valid numeric version, extract version parts
				l_parts := a_version.split ('.')
				from
					i := 1
					l_count := l_parts.count
				until
					i = l_count or j = 4
				loop
					l_part := l_parts.i_th (i)
					if l_part.is_natural_64 then
						l_ver := l_part.to_natural_64.as_natural_16
						inspect j
						when 0 then
							l_major := l_ver
						when 1 then
							l_minor := l_ver
						when 2 then
							l_revision := l_ver
						when 3 then
							l_qfe := l_ver
						end
						j := j + 1
					end
					 i := i + 1
				end
				Result := a_factory.create_code_numeric_version (l_major, l_minor, l_revision, l_qfe)
			else
				Result := a_factory.create_code_version (a_version)
			end
		end

	to_version_string (a_version: !CODE_VERSION): !STRING_32
			-- Converts a code version into a version string.
			--
			-- `a_version': The code version to convert to a string.
			-- `Result': A produced string representation of the supplied code version.
		do
			if {l_nv: !CODE_NUMERIC_VERSION} a_version then
				create Result.make (10)
				Result.append_natural_16 (l_nv.major)
				Result.append_character ('.')
				Result.append_natural_16 (l_nv.minor)
				Result.append_character ('.')
				Result.append_natural_16 (l_nv.revision)
				Result.append_character ('.')
				Result.append_natural_16 (l_nv.qfe)
			else
				Result := a_version.version.twin
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {CODE_VERSION} -- Access

	version_regex: !RX_PCRE_MATCHER
			-- Raw version regular expression
		once
			create Result.make
			Result.compile ("((^|[\.\-_])(([\d]+)){1,4})")
		ensure
			result_is_compiled: Result.is_compiled
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
