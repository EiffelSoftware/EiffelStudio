note
	description: "EiffelV ision horizontal progress bar. Cocoa implementation."
	author:	"Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_PROGRESS_BAR_IMP

inherit
	EV_HORIZONTAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			interface,
			minimum_height,
			minimum_width,
			cocoa_set_size
		end

create
	make

feature {NONE} -- Implementation

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 15 -- Hardcode
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := 150 -- Hardcode
		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32)
		local
			l_y_position: INTEGER
			l_height: INTEGER
		do
			if a_height <= 25 then
				l_y_position := a_y_position
				l_height := a_height
			else
				l_y_position := a_y_position + ((a_height - 25) // 2)
				l_height := 25
			end
			Precursor {EV_PROGRESS_BAR_IMP} (a_x_position, l_y_position, a_width, l_height)
		end


feature {EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_PROGRESS_BAR note option: stable attribute end;

end -- class EV_HORIZONTAL_PROGRESS_BAR_IMP
