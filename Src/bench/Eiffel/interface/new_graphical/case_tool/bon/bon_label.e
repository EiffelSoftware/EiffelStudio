indexing
	description: "Temporary class just here to cope with wrong results of `width' from EV_FIGURE_TEXT"
	date: "$Date$"
	revision: "$Revision$"

class
	BON_LABEL

inherit
	EV_FIGURE_TEXT
		redefine
			bounding_box
		end

create
	default_create,
	make_with_text

feature {NONE} -- Implementation

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangle `Current' fits in.
		do
			create Result.make (point.x_abs - 4, point.y_abs, width + 8, height)
		end

end -- class BON_LABEL
