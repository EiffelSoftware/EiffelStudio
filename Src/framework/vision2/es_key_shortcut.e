note
	description: "A key shortcut representation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_KEY_SHORTCUT

inherit
	HASHABLE
		redefine
			is_equal
		end

create
	make_with_key_combination,
	make_from_accelerator

convert
	as_ev_accelerator: {EV_ACCELERATOR}

feature{NONE} -- Initialization

	make_with_key_combination (a_key: EV_KEY; require_control, require_alt, require_shift: BOOLEAN)
			-- Create with `a_key' and modifiers.
		require
			a_key_not_void: a_key /= Void
		do
			set_key (a_key)
			if require_control then
				enable_control_required
			end
			if require_alt then
				enable_alt_required
			end
			if require_shift then
				enable_shift_required
			end
		ensure
			key_attached: key /= Void
		end

	make_from_accelerator (a_accelerator: EV_ACCELERATOR)
			-- Initialize with key combination from `a_accelerator'.
		require
			a_accelerator_attached: a_accelerator /= Void
		do
			make_with_key_combination (a_accelerator.key, a_accelerator.control_required, a_accelerator.alt_required, a_accelerator.shift_required)
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := key.code
		end

	key: EV_KEY
			-- Key of current shortcut

	text: STRING_32
			-- String representation of key combination.
		local
			a_key: STRING_32
		do
			create Result.make (0)
			if is_control_required then
				Result.append_string_general ("Ctrl+")
			end
			if is_alt_required then
				Result.append_string_general ("Alt+")
			end
			if is_shift_required then
				Result.append_string_general ("Shift+")
			end
			a_key := key.text
				--| We only need to convert the key to upper case if
				--| it is one character long such as 'a'. Other keys
				--| do not need to be converted.
			if a_key.count = 1 then
				a_key := a_key.as_upper
			end
			Result.append (a_key)
		end

feature -- Status report

	is_shift_required: BOOLEAN
			-- Must the shift key be pressed to make current shortcut triggered?

	is_alt_required: BOOLEAN
			-- Must the alt key be pressed to make current shortcut triggered?

	is_control_required: BOOLEAN
			-- Must the control key be pressed to make current shortcut triggered?

	is_triggered (a_key: EV_KEY; require_control, require_alt, require_shift: BOOLEAN): BOOLEAN
			-- Is current shortcut triggered by key combination defined by
			-- `a_key', `requre_control', `require_alt' and `require_shift'?
		require
			a_key_attached: a_key /= Void
		do
			Result :=
				key.is_equal (a_key) and then
				is_alt_required = require_alt and then
				is_shift_required = require_shift and then
				is_control_required = require_control
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' have the same key combination as `Current'?
		do
			Result := is_triggered (other.key, other.is_control_required, other.is_alt_required, other.is_shift_required)
		end

feature -- Status setting

	set_key (a_key: EV_KEY)
			-- Assign `a_key' to `key'.
		require
			a_key_not_void: a_key /= Void
		do
			key := a_key
		ensure
			key_assigned: key = a_key
		end

	enable_shift_required
			-- Make `is_shift_required' True.
		do
			is_shift_required := True
		ensure
			shift_required: is_shift_required
		end

	disable_shift_required
			-- Make `is_shift_required' False.
		do
			is_shift_required := False
		ensure
			not_shift_required: not is_shift_required
		end

	enable_alt_required
			-- Make `is_alt_required' True.
		do
			is_alt_required := True
		ensure
			alt_required: is_alt_required
		end

	disable_alt_required
			-- Make `is_alt_required' False.
		do
			is_alt_required := False
		ensure
			not_alt_required: not is_alt_required
		end

	enable_control_required
			-- Make `is_control_required' True.
		do
			is_control_required := True
		ensure
			control_required: is_control_required
		end

	disable_control_required
			-- Make `is_control_required' False.
		do
			is_control_required := False
		ensure
			not_control_required: not is_control_required
		end

feature -- Conversion

	as_ev_accelerator: EV_ACCELERATOR
			-- Convert current to {EV_ACCELERATOR}.
		do
			create Result.make_with_key_combination (key, is_control_required, is_alt_required, is_shift_required)
		ensure
			result_attached: Result /= Void
		end

invariant
	key_attached: key /= Void

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
