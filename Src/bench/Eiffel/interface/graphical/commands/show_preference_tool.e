indexing

	description:
		"Put your description here.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PREFERENCE_TOOL

inherit
	ICONED_COMMAND;
	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize Current
		do
			init (a_text_window)
		end

feature {NONE} -- Execution

	work (arg: ANY) is
		do
			tool := Void;
			!! tool.make ("Preference Tool", Project_tool.screen);
			!! spc.make (tool);
			!! cpc.make (tool);
			tool.add_preference_category (spc);
			tool.add_preference_category (cpc);
			tool.display;
			tool.raise
		end

feature -- Properties

	name: STRING is "Options";

	symbol: PIXMAP is
		do
		end

feature {NONE} -- Properties

	tool: PREFERENCE_TOOL;
			-- The preference tool

	spc: SYSTEM_PREF_CAT;
			-- A sample category

	cpc: CLASS_PREF_CAT
			-- A sample category


end -- class SHOW_PREFERENCE_TOOL
