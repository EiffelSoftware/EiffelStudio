note
	description: "Eiffel Vision vertical progress bar. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR_IMP

inherit
	EV_VERTICAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			interface,
			minimum_height,
			minimum_width
		end

create
	make

feature {NONE} -- Implementation

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 80 -- Hardcode, same value as in GTK+
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := 22 -- Hardcode, same value as in GTK+
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_PROGRESS_BAR note option: stable attribute end;

end -- class EV_VERTICAL_PROGRESS_BAR_IMP
