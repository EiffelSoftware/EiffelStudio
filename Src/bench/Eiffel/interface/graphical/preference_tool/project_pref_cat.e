indexing

	description:
		"Preference tool resoources for the project window.";
	date: "$Date$";
	revision: "$Revision$"

class PROJECT_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			Project_resources as associated_category
		export
			{NONE} all
		end;
	PREFERENCE_CATEGORY
		redefine
			init_colors
		end

creation
	make

feature {NONE} -- Initialization

	update_resources is
			-- Update `resources'.
		do
			!! tool_x.make (associated_category.tool_x);
			!! tool_y.make (associated_category.tool_y);
			!! tool_width.make (associated_category.tool_width);
			!! tool_height.make (associated_category.tool_height);
			!! debugger_feature_height.make (associated_category.debugger_feature_height);
			!! debugger_object_height.make (associated_category.debugger_object_height);
			!! bottom_offset.make (associated_category.bottom_offset);
			!! command_bar.make (associated_category.command_bar);
			!! format_bar.make (associated_category.format_bar);
			!! raise_on_error.make (associated_category.raise_on_error);
			!! debugger_show_all_callers.make (
				associated_category.debugger_show_all_callers);
			!! debugger_do_flat_in_breakpoints.make (
				associated_category.debugger_do_flat_in_breakpoints);
			!! graphical_output_disabled.make (
				associated_category.graphical_output_disabled);

			resources.extend (tool_x);
			resources.extend (tool_y);
			resources.extend (tool_width);
			resources.extend (tool_height);
			resources.extend (command_bar);
			resources.extend (format_bar);
			resources.extend (debugger_feature_height);
			resources.extend (debugger_object_height);
			resources.extend (debugger_show_all_callers);
			resources.extend (debugger_do_flat_in_breakpoints);
			resources.extend (bottom_offset);
			resources.extend (raise_on_error);
			resources.extend (graphical_output_disabled)
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
			make_row_column (name, a_parent)
		end

feature -- Properties

	name: STRING is "Project tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Preference_project
		end;

feature {NONE} -- Resources

	tool_x, tool_y, tool_width, tool_height,
	debugger_feature_height, debugger_object_height,
	bottom_offset: INTEGER_PREF_RES;
	command_bar, format_bar,
	raise_on_error: BOOLEAN_PREF_RES;
	debugger_show_all_callers: BOOLEAN_PREF_RES;
	debugger_do_flat_in_breakpoints: BOOLEAN_PREF_RES;
	graphical_output_disabled: BOOLEAN_PREF_RES;

end -- class PROJECT_PREF_CAT
