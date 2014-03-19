note
	description: "Summary description for {IRON_REPOSITORY_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPOSITORY_ARGUMENTS

inherit
	IRON_ARGUMENTS

feature -- Access

	is_info: BOOLEAN
		deferred
		end

	is_listing: BOOLEAN
		deferred
		end

	is_cleaning: BOOLEAN
			-- Is cleaning current installation?
			-- i.e: removing package without any registered repository
		deferred
		end

	repository_url: detachable IMMUTABLE_STRING_32
		deferred
		end

	repository_to_add: detachable IMMUTABLE_STRING_32
		deferred
		end

	repository_to_remove: detachable IMMUTABLE_STRING_32
			-- Name or uri to unregister.
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
