note
	description: "Eiffel Vision horizontal range. Cocoa implementation."
	author:	"Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_RANGE_IMP

inherit
	EV_HORIZONTAL_RANGE_I
		redefine
			interface
		end

	EV_RANGE_IMP
		redefine
			interface,
			minimum_width,
			minimum_height
		end

create
	make

feature {NONE} -- Layout

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 20 -- Hardcoded value
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_RANGE note option: stable attribute end;

end -- class EV_HORIZONTAL_RANGE_IMP
