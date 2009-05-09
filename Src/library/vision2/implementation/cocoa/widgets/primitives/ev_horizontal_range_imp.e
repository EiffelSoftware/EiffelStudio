note
	description: "Eiffel Vision horizontal range. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := 37 -- Hardcoded value
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_RANGE;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_HORIZONTAL_RANGE_IMP

