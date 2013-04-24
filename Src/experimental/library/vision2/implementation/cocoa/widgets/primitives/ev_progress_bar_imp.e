note
	description: "Eiffel Vision Progress bar. Cocoa implementation."
	author:	"Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			make,
			set_value,
			set_range
		end

feature {NONE} -- Implementation

	make
		do
			create progress_indicator.make
			cocoa_view := progress_indicator
			Precursor {EV_GAUGE_IMP}
			disable_tabable_from
			enable_segmentation
			progress_indicator.set_indeterminate (False)
			set_is_initialized (True)
		end

	set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			Precursor {EV_GAUGE_IMP} (a_value)
			progress_indicator.set_double_value (a_value)
		end

	set_range
		do
			Precursor {EV_GAUGE_IMP}
			progress_indicator.set_min_value (value_range.lower)
			progress_indicator.set_max_value (value_range.upper)
		end

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display animated ?

feature -- Status setting

	enable_segmentation
			-- Display bar is animated
		do
			progress_indicator.start_animation
			is_segmented := True
		end

	disable_segmentation
			-- Display bar is not animated
		do
			progress_indicator.stop_animation
			is_segmented := False
		end

feature {EV_ANY_I} -- Implementation

	progress_indicator: NS_PROGRESS_INDICATOR

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PROGRESS_BAR note option: stable attribute end;

end -- class EV_PROGRESS_BAR_IMP
