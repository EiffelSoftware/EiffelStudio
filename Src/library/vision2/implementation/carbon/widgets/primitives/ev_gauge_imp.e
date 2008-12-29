note
	description: "Eiffel Vision gauge. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_IMP

inherit
	EV_GAUGE_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize
		end

	EV_GAUGE_ACTION_SEQUENCES_IMP

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- deferred creation
		do
			base_make ( an_interface )
		end

	initialize
		do
			Precursor {EV_PRIMITIVE_IMP}
			ev_gauge_imp_initialize
		end

	ev_gauge_imp_initialize
			-- Initialize without calling precursor.
			--| Separate function so it can be called from
			--| widgets that inherit twice from EV_WIDGET_IMP,
			--| so initialize does not have to be called again.
		do
			create value_range.make (0, 100)
			set_leap (10)
			set_step (1)
			value_range.change_actions.extend (agent set_range)
			set_range
		end


feature -- Access

	value: INTEGER
			-- Current value of the gauge.
		do
			Result := get_control32bit_value_external ( gauge_ptr )
		end

	step: INTEGER
			-- Value by which `value' is increased after `step_forward'.

	leap: INTEGER
			-- Value by which `value' is increased after `leap_forward'.

feature -- Status setting

	step_forward
			-- Increment `value' by `step' if possible.
		do
			set_value (value_range.upper.min (value + step))
		end

	step_backward
			-- Decrement `value' by `step' if possible.
		do
			set_value (value_range.lower.max (value - step))
		end

	leap_forward
			-- Increment `value' by `leap' if possible.
		do
			set_value (value_range.upper.min (value + leap))
		end

	leap_backward
			-- Decrement `value' by `leap' if possible.
		do
			set_value (value_range.lower.max (value - leap))
		end

feature -- Element change

	set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			set_control32bit_value_external ( gauge_ptr, a_value )
		ensure then
			step_same: step = old step
			leap_same: leap = old leap
			range_same: value_range.is_equal (old value_range)
		end

	set_step (a_step: INTEGER)
			-- Set `step' to `a_step'.
		do
			step := a_step
		ensure then
			value_same: value = old value
			leap_same: leap = old leap
			range_same: value_range.is_equal (old value_range)
		end

	set_leap (a_leap: INTEGER)
			-- Set `leap' to `a_leap'.
		do
			leap := a_leap
		end

	set_range
			-- Update widget range from `value_range'
		local
			temp_value: INTEGER
		do
			temp_value := value
			if temp_value > value_range.upper then
				temp_value := value_range.upper
			elseif temp_value < value_range.lower then
				temp_value := value_range.lower
			end
			set_control32bit_minimum_external ( gauge_ptr, value_range.lower )
			set_control32bit_maximum_external ( gauge_ptr, value_range.upper )

			set_value ( temp_value )
		end

feature {NONE} -- Implementation

	interface: EV_GAUGE

feature {NONE} -- Implementation

	gauge_ptr : POINTER
			-- Pointer to the real gauge control, c_object points to a userpane



feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	value_changed_handler
			-- Called when `value' changes.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call ([value])
			end
		end


note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_GAUGE_I

