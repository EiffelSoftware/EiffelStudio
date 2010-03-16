note
	description: "Eiffel Vision vertical range. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_RANGE_IMP

inherit
	EV_VERTICAL_RANGE_I
		redefine
			interface
		end

	EV_RANGE_IMP
		redefine
			interface,
			minimum_height,
			minimum_width
		end

create
	make

feature {NONE} -- Layout

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 37 -- Hardcoded value, same as GTK+
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_RANGE note option: stable attribute end;

end -- class EV_VERTICAL_RANGE_IMP
