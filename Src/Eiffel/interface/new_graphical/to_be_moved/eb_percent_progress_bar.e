note
	description	: "Progress bar for displaying percentage information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PERCENT_PROGRESS_BAR

inherit

	EV_HORIZONTAL_PROGRESS_BAR
		rename
			value_range as range,
			set_value as set_widget_value,
			value as widget_value
		redefine
			initialize,
			is_in_default_state
		end

	EV_SHARED_APPLICATION
		undefine
			is_equal,
			copy,
			default_create
		end

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
				-- Update widget value when value range is updated.
			implementation.value_range.change_actions.extend (agent update_value_with_range)
			disable_segmentation
		end

feature -- Access

	value: INTEGER
		-- Value of `Current'.

feature -- Status setting

	reset
			-- Reset values for percentage.
		local
			l_range: like range
		do
			l_range := range
			if l_range.lower /= 0 or else l_range.upper /= 100 then
				l_range.adapt (0 |..| 100)
			end
		end

feature -- Element change

	reset_with_range (a_range: INTEGER_INTERVAL)
			-- Assign `a_range' to `range'.
			-- Set `value' to `a_range'.lower.
		require
			a_range_not_void: a_range /= Void
			a_range_not_empty: not a_range.is_empty
		do
			range.adapt (a_range)
			set_widget_value (a_range.lower)
			value := a_range.lower
		ensure
			a_range_assigned: range.is_equal (a_range)
			value_assigned: value = a_range.lower
		end

	set_value (a_value: INTEGER)
			-- Assign `a_value' to `value'.
		require
			not_destroyed: not is_destroyed
			value_in_range: range.has (a_value)
		local
			l_upper, l_value, l_new_value: INTEGER
		do
			l_upper := range.upper
			l_value := (value * 100) // l_upper
			l_new_value := (a_value * 100) // l_upper

			if (l_new_value // delta_value) /= (l_value // delta_value) then
					-- Update internal widget only if necessary.
				set_widget_value (a_value)
			end
			value := a_value
		end

feature {NONE} -- Implementation

	update_value_with_range
			-- Update `value' to match widget value.
		do
			value := widget_value
		end

	delta_value: INTEGER = 5
			-- Delta value for updating widget to prevent unnecessary callbacks during widget update

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := True
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class EB_PERCENT_PROGRESS_BAR
