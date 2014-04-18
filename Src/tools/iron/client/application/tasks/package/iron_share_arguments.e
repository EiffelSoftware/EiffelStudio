note
	description: "Summary description for {IRON_SHARE_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_SHARE_ARGUMENTS

inherit
	IRON_ARGUMENTS

feature -- Access

	configuration_file: detachable PATH
			-- Configuration ini file, that may contain `username', `password', `repository' settings.
		deferred
		end

	username: detachable IMMUTABLE_STRING_32
		deferred
		end

	password: detachable IMMUTABLE_STRING_32
		deferred
		end

	package_file: detachable PATH
			-- package.iron file location if any.
		deferred
		end

	package_name: detachable IMMUTABLE_STRING_32
		deferred
		end

	package_title: detachable IMMUTABLE_STRING_32
		deferred
		end

	package_description: detachable IMMUTABLE_STRING_32
		deferred
		end

	package_archive_file: detachable PATH
		deferred
		end

	package_archive_source: detachable PATH
		deferred
		end

	package_indexes: detachable LIST [IMMUTABLE_STRING_32]
		deferred
		end

	is_forcing: BOOLEAN
		deferred
		end

	is_create: BOOLEAN
		deferred
		end

	is_update: BOOLEAN
		deferred
		end

	is_archive: BOOLEAN
		deferred
		end

	is_delete: BOOLEAN
		deferred
		end

	data_file: detachable PATH
		deferred
		end

	operation: detachable IMMUTABLE_STRING_32
		deferred
		end

	repository: detachable IMMUTABLE_STRING_32
		deferred
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
