indexing

	description:
		"Preference tool resoources for the project window.";
	date: "$Date$";
	revision: "$Revision$"

class PROJECT_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			Project_tool_resources as associated_category
		export
			{NONE} all
		end;
	PREFERENCE_CATEGORY
		rename
			make as rc_make
		redefine
			init_colors
		end

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PREFERENCE_TOOL) is
			-- Initialize Current with `a_tool' as `tool'.
		do
			tool := a_tool;
			!! resources.make;
			!! int_width.make (associated_category.tool_width, Current);
			!! int_height.make (associated_category.tool_height, Current);
			!! int_feature_height.make (associated_category.debugger_feature_height, Current);
			!! int_object_height.make (associated_category.debugger_object_height, Current);
			!! int_bottom_offset.make (associated_category.bottom_offset, Current)	;
			!! bool_command_bar.make (associated_category.command_bar, Current);
			!! bool_format_bar.make (associated_category.format_bar, Current);
			!! bool_raise_on_error.make (associated_category.raise_on_error, Current);
			!! debugger_show_all_callers.make (
				associated_category.debugger_show_all_callers, Current);
			!! debugger_do_flat_in_breakpoints.make (
				associated_category.debugger_do_flat_in_breakpoints, Current);
			!! graphical_output_disabled.make (
				associated_category.graphical_output_disabled, Current);

			resources.extend (int_width);
			resources.extend (int_height);
			resources.extend (int_feature_height);
			resources.extend (int_object_height);
			resources.extend (debugger_show_all_callers);
			resources.extend (debugger_do_flat_in_breakpoints);
			resources.extend (int_bottom_offset);
			resources.extend (bool_command_bar);
			resources.extend (bool_format_bar);
			resources.extend (bool_raise_on_error)
		end;

	init_colors is
			-- Initialize the colors of the page.
		local
			att: WINDOW_ATTRIBUTES
		do
			!! att;
			att.set_composite_attributes (Current)
		end

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Currrent's visual aspects.
		local
			button: EB_PREFERENCE_BUTTON;
			menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY
		do
			!! button.make (Current, a_button_parent);
			!! menu_entry.make (Current, a_menu);
			!! holder.make (button, menu_entry);

			button.set_selected (False);

			rc_make (name, a_parent)
		end

feature -- Properties

	name: STRING is "Project tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Case_storage
		end;

	dark_symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Case_storage
		end

feature {NONE} -- Resources

	int_width, int_height,
	int_feature_height, int_object_height,
	int_bottom_offset: INTEGER_PREF_RES;
	bool_command_bar, bool_format_bar,
	bool_raise_on_error: BOOLEAN_PREF_RES;
	debugger_show_all_callers: BOOLEAN_PREF_RES;
	debugger_do_flat_in_breakpoints: BOOLEAN_PREF_RES;
	graphical_output_disabled: BOOLEAN_PREF_RES;

end -- class PROJECT_PREF_CAT
