indexing

	description:	
		"Class Hole for a routine tool.";
	date: "$Date$";
	revision: "$Revision: "

class ROUT_CLASS_HOLE

inherit

	EB_BUTTON_HOLE
		redefine
			text_window, transported_stone, stone_type
		end

creation

	make

feature -- Properties

	text_window: ROUTINE_TEXT;

	transported_stone: STONE is
		local
			fs: FEATURE_STONE
		do
			fs ?= tool.stone;
			if fs /= Void then
				!CLASSC_STONE! Result.make (fs.e_class)
			end
		end;

	stone_type: INTEGER is
		do
			Result := Class_type
		end;

end -- class ROUT_CLASS_CMD
