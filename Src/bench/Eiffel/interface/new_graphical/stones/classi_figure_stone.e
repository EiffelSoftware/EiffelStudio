indexing
	description: "CLASSI_STONEs that originate from a CLASS_FIGURE."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASSI_FIGURE_STONE

inherit
	CLASSI_STONE
		rename
			make as make_with_class_i
		end

create
	make

feature {NONE} -- Initialization

	make (a_figure: CLASS_FIGURE) is
			-- Initialize with `a_figure'.
		do
			make_with_class_i (a_figure.class_i)
			source := a_figure
		end

feature -- Access

	source: CLASS_FIGURE
			-- Source this stone was picked from.

end -- class CLASSI_FIGURE_STONE

