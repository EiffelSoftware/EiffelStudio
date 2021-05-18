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
		redefine
			add_condition,
			set_conditions
		end

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
		do
		end

	is_cflag: BOOLEAN
			-- Is `Current' a C flag external?
		do
		end

	is_object: BOOLEAN
			-- Is `Current' an object external?
		do
		end

	is_library: BOOLEAN
			-- Is `Current' a library external?
		do
		end

	is_resource: BOOLEAN
			-- Is `Current' an external ressource?
		do
		end

	is_linker_flag: BOOLEAN
			-- Is `Current' a linker flag external?
		do
		end

	is_make: BOOLEAN
			-- Is `Current' a make external?
		do
		end

feature -- Access, stored in configuration file

	location: like internal_location
			-- The file location.
		local
			s: STRING_32
			p: READABLE_STRING_32
		do
			create s.make_from_string (internal_location)
			p := target.library_root.name
			s.replace_substring_all ({STRING_32} "$ECF_CONFIG_PATH", p)
			s.replace_substring_all ({STRING_32} "$(ECF_CONFIG_PATH)", p)
				-- There is no reason to have a location ending by backslash.
				-- Remove it to avoid confusion with escaped double quote `\"`.
			if s.count > 0 and then s [s.count] = {CHARACTER_32} '\' then
				s.remove_tail (1)
			end
			Result := s
		ensure
			Result_not_void: Result /= Void
		end

	description: detachable READABLE_STRING_32
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

feature {CONF_ACCESS} -- Status update

	add_condition (a_condition: CONF_CONDITION)
			-- Add `a_condition'.
		do
			Precursor (a_condition)
			if attached target as tgt then
				a_condition.set_target (tgt)
			end
		end

	set_conditions (a_conditions: like internal_conditions)
			-- Set `internal_conditions' to `a_conditions'.
		do
			Precursor (a_conditions)
			if
				attached target as tgt and
				a_conditions /= Void and then not a_conditions.is_empty
			then
				across
					a_conditions as ic
				loop
					ic.item.set_target (tgt)
				end
			end
		end

feature {CONF_ACCESS} -- Implementation

	internal_location: READABLE_STRING_32
			-- The file location.

invariant
	internal_location_not_void: internal_location /= Void
	target_not_void: target /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
