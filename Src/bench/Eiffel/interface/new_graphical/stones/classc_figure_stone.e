indexing
	description: "CLASSC_STONEs that originate from a CLASS_FIGURE."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASSC_FIGURE_STONE

inherit
	CLASSC_STONE
		rename
			make as make_with_class_c
		select
			classi_make
		end

	CLASSI_FIGURE_STONE
		undefine
			class_i, class_name, make,
			cluster, file_name, header, history_name,
			is_valid, stone_signature, synchronized_stone
		end

create
	make

feature {NONE} -- Initialization

	make (a_figure: CLASS_FIGURE) is
			-- Initialize with `a_figure'.
		do
			make_with_class_c (a_figure.class_i.compiled_class)
			source := a_figure
		end

end -- class CLASSC_FIGURE_STONE

