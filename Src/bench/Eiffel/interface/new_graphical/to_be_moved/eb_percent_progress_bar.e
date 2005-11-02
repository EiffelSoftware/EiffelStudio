indexing
	description	: "Progress bar for displaying percentage information"
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

end -- class EB_PERCENT_PROGRESS_BAR
