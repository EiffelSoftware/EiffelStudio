indexing

	description:	
		"Hole for an existing class tool. Yes, I know, %
					%it's very funny.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_HOLE

inherit

	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, icon_symbol,
			name, stone_type, process_class, process_feature,
			process_class_syntax, process_classi,
			compatible, menu_name, accelerator, receive
		end

creation

	make

feature -- Properties

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

	icon_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Class_icon
		end;

	stone_type: INTEGER is
		do
			Result := Class_type
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

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				((dropped.stone_type = Class_type) or
				else (dropped.stone_type = Routine_type))
		end;

feature -- Update

	-- Actually we have two types of class holes. One type is
	-- displayed on the project window and the other type is
	-- used within the class and feature tool.
	-- When we drag a feature stone into the class hole of the project tool,
	-- we should bring up a class tool and highlight the feature.
	-- That's the intelligent stuff.

	process_class (st: CLASSC_STONE) is
		do
			if tool = Project_tool then
				create_class_tool (st)
			else
				tool.receive (st)
			end
		end;

	process_class_syntax (syn: CL_SYNTAX_STONE) is
		do
			if tool = Project_tool then
				create_class_tool (syn)
			else
				tool.receive (syn)
			end
		end

	process_classi (st: CLASSI_STONE) is
		do
			if tool = Project_tool then
				create_class_tool (st)
			else
				tool.receive (st)
			end
		end

	process_feature (st: FEATURE_STONE) is
		do
			if not st.is_valid then
				warner (Project_tool).gotcha_call (Warning_messages.w_Feature_not_compiled)
			else
				create_class_tool (st)
			end
		end

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'
		do
			if compatible (a_stone) and then a_stone.is_valid then
				a_stone.process (Current)
			end
		end;

feature {NONE} -- Implementation

	create_class_tool (a_stone: STONE) is
			-- Create a class tool and process `a_stone'.
		require
			valid_a_stone: a_stone /= Void and then a_stone.is_valid
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window
			new_tool.display
			new_tool.receive (a_stone)
		end

end -- class CLASS_HOLE
