indexing

	description:	
		"Class Hole for a routine tool.";
	date: "$Date$";
	revision: "$Revision: "

class ROUT_CLASS_HOLE

inherit

	DEFAULT_HOLE_COMMAND
		rename
			work as default_work
		redefine
			symbol, full_symbol, name, tool, stone_type,
			transported_stone
		end
	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, name, work, tool, stone_type,
			transported_stone
		select
			work
		end

creation

	make

feature -- Properties

	tool: ROUTINE_W;
			-- Associated tool

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
	
	name: STRING is
		do
			Result := l_Class
		end;

	stone_type: INTEGER is
		do
			Result := Class_type
		end;

	transported_stone: STONE is
		local
			fs: FEATURE_STONE
		do
			fs := tool.stone;
			if fs /= Void then
				!CLASSC_STONE! Result.make (fs.e_class)
			end
		end;

feature -- Execution

	work (argument: ANY) is
			-- Execute the command for associated hole.
		local
			fs: FEATURE_STONE;
			super_melt_cmd: SUPER_MELT;
			classc: CLASSC_STONE
		do
			fs := tool.stone;
			if argument = control_button_three_action then
				if fs /= Void and then fs.e_class /= Void then
					!! classc.make (fs.e_class);
					Project_tool.receive (classc)
				end
			elseif argument = shift_button_three_action then
				!! super_melt_cmd.do_nothing;
				!! classc.make (fs.e_class);
				super_melt_cmd.work (classc)
			else
				default_work (argument)
			end
		end;

end -- class ROUT_CLASS_HOLE
