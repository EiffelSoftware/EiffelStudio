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
	SHARED_PIXMAPS
		rename
			resources as parsed_resources
		end;
	PREFERENCE_CATEGORY
		rename
			make as rc_make
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

feature -- Access

	resources: LINKED_LIST [PREFERENCE_RESOURCE]

feature -- Properties

	name: STRING is "Project tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := bm_Case_storage
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Case_storage
		end

feature -- User Interface

	display is
			-- Display Current
			--| This feature is used to initialize `resources'.
		do
			holder.set_selected (True);
			if been_displayed then
				manage
			else
				from
					resources.start
				until
					resources.after
				loop
					resources.item.display;
					resources.forth;
				end;
				been_displayed := True
			end
		end;

	undisplay is
			-- Undisplay Current.
			--| This only updates the pixmap on the button.
		do
			holder.set_selected (False);
			unmanage;
		end

feature {NONE} -- Properties

	been_displayed: BOOLEAN
			-- Has Current already been displayed?

feature {NONE} -- Resources

	int_width, int_height,
	int_feature_height, int_object_height,
	int_bottom_offset: INTEGER_PREF_RES;
	bool_command_bar, bool_format_bar,
	bool_raise_on_error: BOOLEAN_PREF_RES;
	debugger_show_all_callers: BOOLEAN_PREF_RES;
	debugger_do_flat_in_breakpoints: BOOLEAN_PREF_RES;

end -- class PROJECT_PREF_CAT
