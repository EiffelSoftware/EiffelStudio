class BG_STONE_CMD

inherit

	BG_COLOR_CMD
		redefine 
			work
		end

feature

	work (argument: ANY) is
		do
			context ?= argument;
			context_work;
		end;

end

