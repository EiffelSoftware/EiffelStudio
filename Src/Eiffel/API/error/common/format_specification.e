note
	description: "Specification of a format used to format items specified in a format string of {COMPOSITE_FORMATTER}."

class
	FORMAT_SPECIFICATION

create {COMPOSITE_FORMATTER}
	make,
	make_default

feature {NONE} -- Creation

	make (s: READABLE_STRING_GENERAL)
			-- Create a new object using format specification `s'.
		do
			specification := s
		ensure
			specification_set: specification = s
		end

	make_default
			-- Create a new object with default format specification.
		do
			make (default_specification)
		ensure
			specification_set: specification = default_specification
			is_default: is_default
		end

feature -- Status report

	is_default: BOOLEAN
			-- Does current describe a default format specification.
		do
			Result := specification = default_specification
		end

feature -- Access

	item: READABLE_STRING_GENERAL
			-- Top-level format specification string.
		do
				-- TODO: Handle nested format specifications.
			Result := specification
		end

feature {NONE} -- Access

	specification: READABLE_STRING_GENERAL
			-- Format specification.

feature {NONE} -- Default specification

	default_specification: STRING_32 = ""
			-- Default format specification.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
