note
	description: "Provide EiffelStudio release information "
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_RELEASE

create
	make

feature -- Access

	make (a_channel: READABLE_STRING_8; a_fn: READABLE_STRING_GENERAL; a_platform: READABLE_STRING_8; a_link: READABLE_STRING_8; a_number: READABLE_STRING_8; a_patch: NATURAL_32)
			-- create an object with channel `a_channel`, filename `fn`, platform `a_platform`, link `a_link`, number `a_number`, patch number `a_patch`.
		do
			set_number (a_number)
			set_patch_number (a_patch)
			set_filename (a_fn)
			set_platform (a_platform)
			set_link (a_link)
			set_channel (a_channel)
		ensure
			channel_set:  a_channel.same_string (channel)
			number_set:  a_number.same_string (number)
			patch_number_set : a_patch = patch_number
			filename_set: a_fn.same_string (filename)
			platform_set: a_platform.same_string (platform)
			link_set:     a_link.same_string (link)
		end

feature -- Access

	number: STRING_8
		do
			create Result.make (5)
			if major < 10 then
				Result.append_character ('0')
			end
			Result.append (major.out)
			Result.append_character ('.')
			if minor < 10 then
				Result.append_character ('0')
			end
			Result.append (minor.out)
		end

	full_version_number: STRING_8
		do
			create Result.make (5)
			if major < 10 then
				Result.append_character ('0')
			end
			Result.append (major.out)
			Result.append_character ('.')
			if minor < 10 then
				Result.append_character ('0')
			end
			Result.append (minor.out)
			Result.append_character ('.')
			Result.append (patch_number.out)
		end

	major, minor: NATURAL_16
			-- Major, minor number

	patch_number: NATURAL_32
			-- Build number.

	filename: IMMUTABLE_STRING_32
			-- EiffelStudio name.

	platform: IMMUTABLE_STRING_8
			-- Target platform.

	link: IMMUTABLE_STRING_8
			-- Link.

	channel: IMMUTABLE_STRING_8
			-- Release channel.

feature -- Status report

	is_greater (maj,min: NATURAL_16; a_patch: NATURAL_32): BOOLEAN
		do
			Result := True
			if major < maj then
				Result := False
			elseif major = maj then
				if minor < min then
					Result := False
				elseif minor = min then
					Result := patch_number > a_patch
				else
					check minor > min end
				end
			else
				check major > maj end
			end
		end

	is_greater_than (other: ES_UPDATE_RELEASE): BOOLEAN
		do
			Result := is_greater (other.major, other.minor, other.patch_number)
		end

	max (other: ES_UPDATE_RELEASE): ES_UPDATE_RELEASE
		do
			if is_greater_than (other) then
				Result := Current
			else
				Result := other
			end
		end

feature -- Element change

	set_number (a_number: READABLE_STRING_8)
			-- Set `number` with `a_number`.
		require
			a_number.occurrences ('.') = 1
		local
			i: INTEGER
		do
			i := a_number.index_of ('.', 1)
			if i > 0 then
				major := a_number.head (i - 1).to_natural_16
				minor := a_number.substring (i + 1, a_number.count).to_natural_16
			else
				major := 0
				minor := 0
			end
		end

	set_patch_number (n: NATURAL_32)
			-- Set `patch_number` with `n`.
		do
			patch_number := n
		ensure
			patch_number_set: n = patch_number
		end

	set_filename (a_filename: READABLE_STRING_GENERAL)
			-- Set `filename` with `a_filename`.
		do
			create filename.make_from_string_general (a_filename)
		ensure
			filename_set: a_filename.same_string (filename)
		end

	set_platform (a_platform: READABLE_STRING_8)
			-- Set `platform` with `a_platform`.
		do
			create platform.make_from_string (a_platform)
		ensure
			platform_set: a_platform.same_string (platform)
		end

	set_link (a_link: READABLE_STRING_8)
			-- Set `link` with `a_link`.
		do
			create link.make_from_string (a_link)
		ensure
			link_set: a_link.same_string (link)
		end

	set_channel (a_channel: READABLE_STRING_8)
			-- Set `channel` with `a_channel`.
		do
			create channel.make_from_string (a_channel)
		ensure
			channel_set: a_channel.same_string (channel)
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
