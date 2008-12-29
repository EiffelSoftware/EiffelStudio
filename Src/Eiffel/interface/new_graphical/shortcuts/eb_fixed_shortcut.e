note
	description: "Objects represent shortcut that can not be changed by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FIXED_SHORTCUT

inherit
	MANAGED_SHORTCUT
		redefine
			set_values
		end

create
	make

feature -- Initialize

	make (a_name: STRING_GENERAL; a_key: EV_KEY; a_alt, a_ctrl, a_shift: BOOLEAN)
			-- Initialize.
		require
			a_name_not_void: a_name /= Void
			a_key_not_void: a_key /= Void
		do
			name := a_name
			key := a_key
			is_ctrl := a_ctrl
			is_alt := a_alt
			is_shift := a_shift
			is_fixed := True
		ensure
			name_set: name = a_name
			key_set: key = a_key
			is_ctrl_set: is_ctrl = a_ctrl
			is_alt_set: is_alt = a_alt
			is_shift_set: is_shift = a_shift
			is_fixed: is_fixed
		end

feature -- Access

	name: STRING_GENERAL

	key: EV_KEY

	is_ctrl: BOOLEAN

	is_alt: BOOLEAN

	is_shift: BOOLEAN;

feature {NONE} -- Implemetation

	set_values (a_key: EV_KEY; alt, ctrl, shift: BOOLEAN)
			-- Do nothing.
		do
		end

invariant
	name_set: name /= Void
	key_set: key /= Void

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
