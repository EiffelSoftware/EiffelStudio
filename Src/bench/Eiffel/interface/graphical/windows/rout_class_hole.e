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
			transported_stone, process_feature,
			menu_name, accelerator
		end
	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, name, work, tool, stone_type,
			transported_stone, process_feature,
			menu_name, accelerator
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
			Result := Pixmaps.bm_Class
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Class_dot
		end;
	
	name: STRING is
		do
			Result := Interface_names.s_Class_stone
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_class
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
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
			classc: CLASSC_STONE;
			new_tool: CLASS_W
		do
			fs := tool.stone;
			if argument = control_button_three_action then
				if fs /= Void and then fs.e_class /= Void then
					new_tool := window_manager.class_window;
					new_tool.display;
					new_tool.process_feature (fs)
				end
			elseif argument = shift_button_three_action then
--Arnaud		create super_melt_cmd.do_nothing;
        		create classc.make (fs.e_class);
--Arnaud		super_melt_cmd.work (classc)
			else
				default_work (argument)
			end
		end;

feature -- Update

	process_feature (st: FEATURE_STONE) is
        do
		end

end -- class ROUT_CLASS_HOLE
