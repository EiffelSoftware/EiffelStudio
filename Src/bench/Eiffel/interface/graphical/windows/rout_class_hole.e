indexing

	description:	
		"Class Hole for a routine tool.";
	date: "$Date$";
	revision: "$Revision: "

class ROUT_CLASS_HOLE 

inherit

	HOLE
		redefine
			compatible, symbol, stone_type, name,
			full_symbol, transport_stone
		end

creation

	make

feature -- Properties

	transport_stone: STONE is
		local
			rt: ROUTINE_TEXT;
			fs: FEATURE_STONE;
		do
			rt ?= tool.text_window
			if (rt /= Void) then
				fs := rt.root_stone
				if (fs /= Void) then
					!CLASSC_STONE! Result.make (fs.e_class)
				end
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
	
feature {NONE} -- Properties

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				(dropped.stone_type = Class_type)
		end;

	name: STRING is
		do
			Result := l_Class
		end;

end -- class ROUT_CLASS_HOLE
