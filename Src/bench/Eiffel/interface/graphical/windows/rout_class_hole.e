indexing

	description:	
		"Class Hole for a routine tool.";
	date: "$Date$";
	revision: "$Revision: "

class ROUT_CLASS_HOLE 

inherit

	EB_BUTTON_HOLE
		redefine
			symbol, stone_type, name,
			full_symbol, transported_stone,
			text_window
		end

creation

	make

feature -- Properties

	text_window: ROUTINE_TEXT;

	transported_stone: STONE is
		local
			fs: FEATURE_STONE;
		do
			fs ?= tool.stone;
			if (fs /= Void) then
				!CLASSC_STONE! Result.make (fs.e_class)
			end
		end;

	symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Class
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Class_dot
		end;

	stone_type: INTEGER is
		do
			Result := Class_type
		end;
	
	name: STRING is
		do
			Result := l_Class
		end;

end -- class ROUT_CLASS_HOLE
