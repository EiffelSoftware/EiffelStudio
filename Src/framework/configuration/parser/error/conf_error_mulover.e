note
	description: "Error if a class is overriden by multiple classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_MULOVER

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_class, a_location, a_first, a_second: READABLE_STRING_GENERAL)
			-- Create.
		require
			a_class_not_void: a_class /= Void
			a_location_not_void: a_location /= Void
			a_first_not_void: a_first /= Void
			a_second_not_void: a_second /= Void
		do
			text := {STRING_32} "Found multiple overrides for class "+a_class+"%N"
						+"Original: "+a_location+"%N"
						+"First override: "+a_first+"%N"
						+"Second override:"+a_second+"%N"
		end

feature -- Access

	text: READABLE_STRING_32;
		-- Error text.

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
