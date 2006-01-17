indexing
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
			value_range as range
		redefine
			initialize,
			set_value,
			is_in_default_state
		end

	EV_SHARED_APPLICATION
		undefine
			is_equal,
			copy,
			default_create
		end

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			disable_segmentation
		end

feature -- Status setting

	reset is
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

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Assign `a_range' to `range'.
			-- Set `value' to `a_range'.lower.
		require
			a_range_not_void: a_range /= Void
			a_range_not_empty: not a_range.is_empty
		do
			range.adapt (a_range)
			set_value (a_range.lower)
		ensure
			a_range_assigned: range.is_equal (a_range)
			value_assigned: value = a_range.lower
		end

	set_value (a_value: INTEGER) is
			-- Assign `a_value' to `value'.
		do
			Precursor (a_value)
		end

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := True
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_PERCENT_PROGRESS_BAR
