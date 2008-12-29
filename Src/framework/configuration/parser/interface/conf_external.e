note
	description: "Objects that represent an external."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_EXTERNAL

inherit
	CONF_CONDITIONED

create
	make

feature {NONE} -- Initialization

	make (a_location: like internal_location; a_target: like target)
			-- Create with `a_location'.
		require
			a_location_not_void: a_location /= Void
			target_not_void: a_target /= Void
		do
			internal_location := a_location
			target := a_target
		ensure
			location_set: internal_location = a_location
			target_set: target = a_target
		end

feature -- Status

	is_include: BOOLEAN
			-- Is `Current' an include external?
		once
		end

	is_object: BOOLEAN
			-- Is `Current' an object external?
		once
		end

	is_library: BOOLEAN
			-- Is `Current' a library external?
		once
		end

	is_make: BOOLEAN
			-- Is `Current' a make external?
		once
		end

	is_resource: BOOLEAN
			-- Is `Current' an external ressource?
		once
		end

feature -- Access, stored in configuration file

	location: like internal_location
			-- The file location.
		local
			l_path: STRING
		do
			Result := internal_location.twin
			l_path := target.library_root.twin
				-- remove trailing directory separator
			if not l_path.is_empty and then l_path.item (l_path.count) = operating_environment.directory_separator then
				l_path.remove_tail (1)
			end
			Result.replace_substring_all ("$ECF_CONFIG_PATH", l_path)
		ensure
			Result_not_void: Result /= Void
		end

	description: STRING
			-- A description about the external.

	target: CONF_TARGET
			-- Target where the external is written in.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_location (a_location: like internal_location)
			-- Set `location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			internal_location := a_location
		ensure
			location_set: internal_location = a_location
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

feature {CONF_ACCESS} -- Implementation

	internal_location: STRING
			-- The file location.

invariant
	internal_location_not_void: internal_location /= Void
	target_not_void: target /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
