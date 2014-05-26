note
	description: "Summary description for {IRON_INSTALL_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_INSTALL_ARGUMENTS

inherit
	IRON_ARGUMENTS

feature -- Access

	installing_all: BOOLEAN
			-- Install all available packages?
		deferred
		end

	setup_execution_enabled: BOOLEAN
			-- Allowing execution of scripts during installation?
		deferred
		end

	ignoring_cache: BOOLEAN
			-- Ignore cache and always redownload the archive?
		deferred
		end

	dependencies_included: BOOLEAN
			-- Include the dependencies?
		deferred
		end

	resources: LIST [IMMUTABLE_STRING_32]
		deferred
		end

	files: LIST [IMMUTABLE_STRING_32]
		deferred
		end

	for_ecf_file: detachable PATH
			-- Install package for ecf `Result' if any.
		deferred
		end

	target_name: detachable READABLE_STRING_32
			-- Optional target name information in addition to `for_ecf_file'.
		require
			for_ecf_file_attached: for_ecf_file /= Void
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
