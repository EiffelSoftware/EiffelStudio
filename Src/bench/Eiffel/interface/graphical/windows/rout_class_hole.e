
-- Hole for an existing class tool.
-- Yes, I know, it's very funny.
-- No it's not you sick frog

class ROUT_CLASS_HOLE 

inherit

	HOLE
		redefine
			compatible, symbol, stone_type, command_name,
			full_symbol, transport_stone
		end

creation

	make

feature 

	transport_stone: STONE is
		local
			rt: ROUTINE_TEXT;
			fs: FEATURE_STONE;
		do
			rt ?= tool.text_window
			if (rt /= Void) then
				fs := rt.root_stone
				if (fs /= Void) then
					Result := fs.e_class.stone
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

	stone_type: INTEGER is do Result := Class_type end;
	
feature {NONE}

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				(dropped.stone_type = Class_type)
		end;

	command_name: STRING is do Result := l_Class end;

end
