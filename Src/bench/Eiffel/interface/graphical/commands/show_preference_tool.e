indexing

	description:
		"Put your description here.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PREFERENCE_TOOL

inherit
	WINDOWS;
	EB_CONSTANTS;
	ISE_COMMAND

creation
	make

feature {NONE} -- Initalization

	make (a_category: like category) is
			-- Initialize command with `a_category'.
		do
			category := a_category
		end

feature {NONE} -- Access

	category: RESOURCE_CATEGORY
			-- Category to be displayed

feature {NONE} -- Execution

	work (arg: ANY) is
		local
			gpc: GENERAL_PREF_CAT; -- A general category
			cwpc: CLASS_PREF_CAT; -- Preference category for the class window
			ewpc: EXPLAIN_PREF_CAT; -- Preference category for the explain window
			pwpc: PROJECT_PREF_CAT; -- Preference category for the project window
			swpc: SYSTEM_PREF_CAT; -- Preference category for the system window
			rwpc: ROUTINE_PREF_CAT; -- Preference category for the routine window
			owpc: OBJECT_PREF_CAT; -- Preference category for the object window
			grpc: GRAPHICAL_PREF_CAT; -- Preference category for the graphical values
			prpc: PROFILE_PREF_CAT; -- Preference category for the profile tool
			mp: MOUSE_PTR;
			p_tool: EB_PREFERENCE_TOOL
		do
			!! mp.set_watch_cursor;
			if preference_tool = Void then
				!! p_tool.make;
				!! gpc.make (p_tool);
				!! pwpc.make (p_tool);
				!! ewpc.make (p_tool);
				!! swpc.make (p_tool);
				!! cwpc.make (p_tool);
				!! rwpc.make (p_tool);
				!! owpc.make (p_tool);
				!! prpc.make (p_tool);
				!! grpc.make (p_tool);
				p_tool.add_preference_category (gpc);
				p_tool.add_preference_category (pwpc);
				p_tool.add_preference_category (ewpc);
				p_tool.add_preference_category (swpc);
				p_tool.add_preference_category (cwpc);
				p_tool.add_preference_category (rwpc);
				p_tool.add_preference_category (owpc);
				p_tool.add_preference_category (prpc);
				p_tool.add_preference_category (grpc);
				p_tool.build_interface (Project_tool.screen);
				preference_tool_cell.put (p_tool)
			end;
			preference_tool.show_page_number (category.page_number);
			preference_tool.display;
			mp.restore
		end

feature -- Properties

	name: STRING is 
		do
			Result := Interface_names.f_Preferences
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Preferences
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

invariant

	valid_category: category /= Void

end -- class SHOW_PREFERENCE_TOOL
