note
	description: "Error if an override itself is overriden."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_OVERRIDE

inherit
	CONF_ERROR_PARSE
		redefine
			text
		end

feature {NONE} -- Initialization

	text: STRING_32
			-- Error text.
		do
			if attached file as l_file then
				Result := {STRING_32} "Parse error in " + l_file + {STRING_32} ": An override was overriden"
			else
				Result := {STRING_32} "Parse error: An override was overriden"
			end
			if attached group as l_group then
				Result.append ({STRING_32} ": " + l_group)
			end
		end

feature -- Update

	set_group (a_group: detachable READABLE_STRING_GENERAL)
			-- Set the undefined group to `a_group'.
		do
			group := a_group
		end

feature {NONE} -- Implementation

	group: detachable READABLE_STRING_GENERAL;
			-- Group that is not defined.

note
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
