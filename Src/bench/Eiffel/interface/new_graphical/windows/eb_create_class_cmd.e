indexing
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_CLASS_CMD

inherit
	EB_TOOL_COMMAND
		redefine
			tool
		end

	EB_SHARED_INTERFACE_TOOLS

creation
	make

feature -- Properties

--	symbol: PIXMAP is
--			-- Icon for the class tool
--		once
--			Result := Pixmaps.bm_Class
--		end

--	full_symbol: PIXMAP is
--			-- Icon for the class tool
--		once
--			Result := Pixmaps.bm_Class_dot
--		end

--	icon_symbol: PIXMAP is
--			-- Icon for the class tool
--		once
--			Result := Pixmaps.bm_Class_icon
--		end

--	stone_type: INTEGER is
--		do
--			Result := Class_type
--		end

--	name: STRING is
--		do
--			Result := Interface_names.s_Class_stone
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_New_class
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

feature -- Access

--	compatible (dropped: STONE): BOOLEAN is
--			-- Can current accept `dropped'?
--		do
--			Result := dropped /= Void and then
--				((dropped.stone_type = Class_type) or
--				else (dropped.stone_type = Routine_type))
--		end

feature -- Update

	-- Actually we have two types of class holes. One type is
	-- displayed on the project window and the other type is
	-- used within the class and feature tool.
	-- When we drag a feature stone into the class hole of the project tool,
	-- we should bring up a class tool and highlight the feature.
	-- That's the intelligent stuff.

--	process_class (st: CLASSC_STONE) is
--		do
--			if tool = Project_tool then
--				create_class_tool (st)
--			else
--				tool.receive (st)
--			end
--		end

--	process_class_syntax (syn: CL_SYNTAX_STONE) is
--		do
--			if tool = Project_tool then
--				create_class_tool (syn)
--			else
--				tool.receive (syn)
--			end
--		end

--	process_classi (st: CLASSI_STONE) is
--		do
--			if tool = Project_tool then
--				create_class_tool (st)
--			else
--				tool.receive (st)
--			end
--		end

--	process_feature (st: FEATURE_STONE) is
--		local
--			wd: EV_WARNING_DIALOG
--		do
--			if not st.is_valid then
--				create wd.make_default (tool.parent_window, Interface_names.t_Warning,
--					Warning_messages.w_Feature_not_compiled)
--			else
--				create_class_tool (st)
--			end
--		end

--	receive (a_stone: STONE) is
--			-- Process dropped stone `a_stone'
--		do
--			if a_stone.is_valid and then compatible (a_stone) then
--				a_stone.process (Current)
--			end
--		end

feature {NONE} -- Implementation

	tool: EB_PROJECT_TOOL

	create_class_tool (a_stone: STONE) is
			-- Create a class tool and process `a_stone'.
		require
--			valid_a_stone: a_stone /= Void and then a_stone.is_valid
		local
			new_tool: EB_CLASS_TOOL
		do
			new_tool := tool_supervisor.new_class_tool
			new_tool.show
--			new_tool.receive (a_stone)
		end

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
			create_class_tool (Void)
		end

end -- class EB_CREATE_CLASS_CMD
