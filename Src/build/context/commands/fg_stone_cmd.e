	-- Command used for the copy of
	-- the fg_color_name attribute
	-- using an attrib_stone from a context editor

class FG_STONE_CMD

inherit

	FG_COLOR_CMD
		redefine 
			work
		end

feature

	work (argument: ANY) is
		do
			context ?= argument;
			context_work
		end;

end

