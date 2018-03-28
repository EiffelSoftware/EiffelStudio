note
	description: "Represent a FILE_PROPERTY with the replacements of a CONF_LOCATION"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_LOCATION_PROPERTY

inherit
	FILE_PROPERTY
		rename
			make as make_property
		redefine
			directory_location_value
		end

create
	make

feature {NONE} -- Creation

	make (n: like name; t: like target)
			-- initialize with property name `n` and target `t`.
		do
			target := t
			make_property (n)
		end

feature -- Access

	target: CONF_TARGET

feature {NONE} -- Implementation

	directory_location_value: STRING_32
			-- Directory location from value with replacements.
		local
			l_loc: CONF_FILE_LOCATION
		do
			check
				target_set: target /= Void
			end
			if attached value as v then
				create l_loc.make (v, target)
				Result := l_loc.evaluated_directory.name
			else
				create Result.make_empty
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
