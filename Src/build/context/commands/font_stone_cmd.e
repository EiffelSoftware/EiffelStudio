-- Command used for the copy of
-- the font_name attribute
-- using an attrib_stone from a context editor

class FONT_STONE_CMD 

inherit

	FONT_CMD
		redefine 
			work
		end

feature 

	work (argument: CONTEXT) is
		do
			context := argument;
			if context.is_fontable then
				context_work
			else
				failed := True
			end
		end;

end
