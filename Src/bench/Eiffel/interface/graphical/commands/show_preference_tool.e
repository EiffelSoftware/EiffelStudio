indexing

	description:
		"Put your description here.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PREFERENCE_TOOL

inherit
	PIXMAP_COMMAND
		rename
			init as make
		end;
	WINDOWS;
	INTERFACE_W

creation
	make

feature {NONE} -- Execution

	work (arg: ANY) is
		do
			!! preference_tool.make (l_X_resourse_name, Project_tool.screen);
			!! spc.make (preference_tool);
			!! pwpc.make (preference_tool);
			!! ewpc.make (preference_tool);
			!! swpc.make (preference_tool);
			!! cwpc.make (preference_tool);
			!! rwpc.make (preference_tool);
			!! owpc.make (preference_tool);
			preference_tool.add_preference_category (spc);
			preference_tool.add_preference_category (pwpc);
			preference_tool.add_preference_category (ewpc);
			preference_tool.add_preference_category (swpc);
			preference_tool.add_preference_category (cwpc);
			preference_tool.add_preference_category (rwpc);
			preference_tool.add_preference_category (owpc);
			preference_tool.display;
			preference_tool.raise
		end

feature -- Properties

	name: STRING is "Options";

	symbol: PIXMAP is
		do
		end

feature {NONE} -- Properties

	preference_tool: PREFERENCE_TOOL;
			-- The preference tool

	spc: SYSTEM_PREF_CAT;
			-- A sample category

	cwpc: CLASS_W_PREF_CAT
			-- Preference category for the class window

	ewpc: EXPLAIN_W_PREF_CAT
			-- Preference category for the explain window

	pwpc: PROJECT_PREF_CAT
			-- Preference category for the project window

	swpc: SYSTEM_W_PREF_CAT
			-- Preference category for the system window

	rwpc: ROUTINE_W_PREF_CAT
			-- Preference category for the routine window

	owpc: OBJECT_W_PREF_CAT
			-- Preference category for the object window

end -- class SHOW_PREFERENCE_TOOL
