note
	description: "Eiffel Vision scrollbar. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR_IMP

inherit
	EV_SCROLL_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			set_default_minimum_size,
			set_value
		redefine
			interface,
			make
		end

feature {NONE} -- Implementation

	make
		do
			Precursor {EV_GAUGE_IMP}
			disable_tabable_from
			disable_tabable_to
		end

feature {EV_ANY_I} -- Setter

	set_value (a_value: INTEGER)
		-- Set `value' to `a_value'.
	do
		Precursor {EV_GAUGE_IMP} (a_value)
		scroller.set_double_value (proportion)
	end

feature {EV_ANY_I} -- Implementation

	scroller: NS_SCROLLER

	interface: detachable EV_SCROLL_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_SCROLL_BAR_IMP

