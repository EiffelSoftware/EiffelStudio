indexing
	description: "[
			Same as EV_VERTICAL_SPLIT_AREA, except that when double click it'll set it's proportion to 50%.
			A decorator.
																										]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_VERTICAL_SPLIT_AREA

inherit
	EV_VERTICAL_SPLIT_AREA
		redefine
			initialize
		end

feature {NONE} -- Redefine

	initialize is
			-- Redefine
		do
			Precursor {EV_VERTICAL_SPLIT_AREA}
			pointer_double_press_actions.force_extend (agent set_proportion (0.5))
		end

end
