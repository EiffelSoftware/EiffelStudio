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
	INTERFACE_W;
	EB_CONSTANTS

creation
	make

feature {NONE} -- Execution

	work (arg: ANY) is
		local
			spc: SYSTEM_PREF_CAT; -- A sample category
			cwpc: CLASS_W_PREF_CAT -- Preference category for the class window
			ewpc: EXPLAIN_W_PREF_CAT -- Preference category for the explain window
			pwpc: PROJECT_PREF_CAT -- Preference category for the project window
			swpc: SYSTEM_W_PREF_CAT -- Preference category for the system window
			rwpc: ROUTINE_W_PREF_CAT -- Preference category for the routine window
			owpc: OBJECT_W_PREF_CAT -- Preference category for the object window
			grpc: GRAPHICAL_PREF_CAT -- Preference category for the graphical values
			mp: MOUSE_PTR;
			att: WINDOW_ATTRIBUTES
		do
			!! mp.set_watch_cursor;
			!! preference_tool.make (l_X_resourse_name, Project_tool.screen);
			!! spc.make (preference_tool);
			!! pwpc.make (preference_tool);
			!! ewpc.make (preference_tool);
			!! swpc.make (preference_tool);
			!! cwpc.make (preference_tool);
			!! rwpc.make (preference_tool);
			!! owpc.make (preference_tool);
			!! grpc.make (preference_tool);
			preference_tool.add_preference_category (spc);
			preference_tool.add_preference_category (pwpc);
			preference_tool.add_preference_category (ewpc);
			preference_tool.add_preference_category (swpc);
			preference_tool.add_preference_category (cwpc);
			preference_tool.add_preference_category (rwpc);
			preference_tool.add_preference_category (owpc);
			preference_tool.add_preference_category (grpc);
			preference_tool.build_interface;
				-- FIXME ****** Add to interface w
			set_default_position;
			preference_tool.set_title ("Preference tool");	
			!! att;
			att.set_composite_attributes (preference_tool);
			preference_tool.display;
			mp.restore;
		end

feature -- Properties

	name: STRING is "Options";

	symbol: PIXMAP is
		do
		end

feature {NONE} -- Properties

	preference_tool: PREFERENCE_TOOL;
			-- The preference tool

	set_default_position is
			-- Display the window at the cursor position.
			-- Try to display the window in the screen.
		local
			new_x, new_y: INTEGER;
			s: SCREEN
		do
			if not System_resources.default_window_position.actual_value then
				s := preference_tool.screen;
				new_x := s.x;
				new_y := s.y;
				if new_x + preference_tool.width > s.width then
					new_x := s.width - preference_tool.width
				end;
				if new_x < 0 then
					new_x := 0
				end;
				if new_y + preference_tool.height > s.height then
					new_y := s.height - preference_tool.height
				end;
				if new_y < 0 then
					new_y := 0
				end;
				preference_tool.set_x_y (new_x, new_y)
			end
		end;

end -- class SHOW_PREFERENCE_TOOL
