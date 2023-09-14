note
	description: "Summary description for {IL_RUNTIME_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_RUNTIME_INFO

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make,
	make_with_version_and_tfm

feature {NONE} -- Initialization

	make (loc: PATH; a_version: READABLE_STRING_32)
		require
			loc_set: loc /= Void
			version_set: a_version /= Void and then not a_version.is_whitespace
		do
			location := loc
			version := a_version
		end

	make_with_version_and_tfm (loc: PATH; a_version: READABLE_STRING_32; a_tfm: READABLE_STRING_32)
		require
			loc_set: loc /= Void
			version_set: a_version /= Void and then not a_version.is_whitespace
			tfm_set: a_tfm /= Void and then not a_tfm.is_whitespace
		do
			tfm := a_tfm
			make  (loc, a_version)
		end

feature -- Access

	location: PATH

	version: READABLE_STRING_32

	tfm: detachable READABLE_STRING_32

	full_version: READABLE_STRING_32
		do
			if attached tfm as l_tfm then
				Result := l_tfm + "/" + version
			else
				Result := version
			end
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		local
			l_other_tfm: like tfm
			v1,v2: IL_VERSION
		do
			l_other_tfm := other.tfm
			if attached tfm as l_tfm then
				if l_other_tfm = Void then
					Result := False
				else
					create v1.make_from_string (version)
					create v2.make_from_string (other.version)
					Result := v1 < v2
				end
			elseif l_other_tfm /= Void then
				Result := True
			else
				create v1.make_from_string (version)
				create v2.make_from_string (other.version)
				Result := v1 < v2
			end
		end

feature -- Status report

	debug_output: STRING_32
		do
			create Result.make_empty
			if attached tfm as l_tfm then
				Result.append (l_tfm)
				Result.append_character ('/')
			end
			Result.append (version)
			Result.append_character (' ')
			Result.append_character (':')
			Result.append_character ('%"')
			Result.append (location.name)
			Result.append_character ('%"')
		end

invariant

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
