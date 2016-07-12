note
	description: "A parser that processes strings to retrieve configutation data."
	date: "$Date$"
	revision: "$Revision$"

class CONF_STRING_PARSER

create
	make

feature {NONE} -- Creation

	make
			-- Initialize a new parser object.
		do
		end

feature -- Basic operations

	parse_target_settings (input: READABLE_STRING_32; settings: CONF_TARGET_SETTINGS)
			-- Update `settings' from `input' and set `error' accordingly.
		do
				-- Reset previous error message (if any).
			error := Void
		end

feature -- Status report

	error: detachable READABLE_STRING_32
			-- An error message if last parsing has completed with an error.
			-- `Void' otherwise.

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
