note
	description: "Error if there was no class in a file where a class was expected."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_CLASSN

inherit
	CONF_ERROR

	SHARED_LOCALE
		undefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_file: READABLE_STRING_32; a_config: detachable READABLE_STRING_32)
			-- Create.
		require
			a_file_not_void: a_file /= Void
		do
			if a_config /= Void then
				text := locale.formatted_string (locale.translation ("Eiffel file without a class declaration in $1%NConfiguration: $2"), [a_file, a_config])
			else
				text := locale.formatted_string (locale.translation ("Eiffel file without a class declaration in $1"), [a_file])
			end
		end

feature -- Access

	text: READABLE_STRING_32
		-- Error text.

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
