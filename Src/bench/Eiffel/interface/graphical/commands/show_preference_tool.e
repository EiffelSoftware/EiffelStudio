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
	WINDOWS

creation
	make

feature {NONE} -- Execution

	work (arg: ANY) is
		do
			!! preference_tool.make ("Preference Tool", Project_tool.screen);
			!! spc.make (preference_tool);
			!! cpc.make (preference_tool);
			preference_tool.add_preference_category (spc);
			preference_tool.add_preference_category (cpc);
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

	cpc: CLASS_PREF_CAT
			-- A sample category


end -- class SHOW_PREFERENCE_TOOL
