note
	description: "Provide EiffelStudio release information "
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_RELEASE

create
	make

feature -- Access

	make (a_channel: READABLE_STRING_8; a_fn: READABLE_STRING_GENERAL; a_platform: READABLE_STRING_8; a_link: READABLE_STRING_8; a_number: READABLE_STRING_8)
			-- create an object with channel `a_channel`, filename `fn`, platform `a_platform`, linnk `a_link`, number `a_number`.
		do
			set_number (a_number)
			set_filename (a_fn)
			set_platform (a_platform)
			set_link (a_link)
			set_channel (a_channel)
		ensure
			channel_set:  a_channel.same_string (channel)
			number_set :  a_number.same_string (number)
			filename_set: a_fn.same_string (filename)
			platform_set: a_platform.same_string (platform)
			link_set:     a_link.same_string (link)
		end

feature -- Access

	number: IMMUTABLE_STRING_8
			-- Release.

	filename: IMMUTABLE_STRING_32
			-- EiffelStudio name.

	platform: IMMUTABLE_STRING_8
			-- Target platform.

	link: IMMUTABLE_STRING_8
			-- Link.

	channel: IMMUTABLE_STRING_8
			-- Release channel.

feature -- Element change

	set_number (a_number: READABLE_STRING_8)
			-- Set `number` with `a_number`.
		do
			create number.make_from_string (a_number)
		ensure
			number_set: a_number.same_string (number)
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
