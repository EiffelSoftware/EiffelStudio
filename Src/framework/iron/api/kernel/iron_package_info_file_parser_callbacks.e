note
	description: "Summary description for {IRON_PACKAGE_INFO_FILE_PARSER_CALLBACKS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_PACKAGE_INFO_FILE_PARSER_CALLBACKS

feature -- Callbacks

	on_error (a_message: READABLE_STRING_32)
		do
		end

	on_comment (a_content: READABLE_STRING_32)
		do
		end

	on_package (a_name: READABLE_STRING_32)
		do
		end

	on_project (a_project_name: READABLE_STRING_32; a_path: READABLE_STRING_32)
		do
		end

	on_setup (a_setup_name: READABLE_STRING_32; a_op: READABLE_STRING_32)
		do
		end

	on_note (a_note_name: READABLE_STRING_32; a_value: READABLE_STRING_32)
		do
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
