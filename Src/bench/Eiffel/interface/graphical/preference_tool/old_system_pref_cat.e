indexing

	description:
		"Abstract notion of category of resources used for a UI.";
	date: "$Date$";
	revision: "$Revision$"

class OLD_SYSTEM_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			System_resources as associated_category
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

	make (a_tool: PREFERENCE_TOOL) is
			-- Initialize Current with `a_tool' as `tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool;
			!! resources.make;

			!! default_window_position.make (associated_category.default_window_position);
			!! str_temporary_dir.make (associated_category.temporary_dir);
			!! str_profiler_dir.make (associated_category.profiler_dir);
			!! str_filter_dir.make (associated_category.filter_dir);
			!! int_history_size.make (associated_category.history_size)

			resources.extend (default_window_position);
			resources.extend (str_profiler_dir);
			resources.extend (str_filter_dir);
			resources.extend (str_temporary_dir);
			resources.extend (int_history_size);
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
			-- Initialize Current and `a_parent' as `parent'.
		local
			button: EB_PREFERENCE_BUTTON;
			menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY
		do
			!! button.make (Current, a_button_parent);
			!! menu_entry.make (Current, a_menu);
			!! holder.make (button, menu_entry);
			rc_make (name, a_parent)
		end

feature -- Properties

	name: STRING is "System preferences"
			-- Current's name

	symbol: PIXMAP is
			-- Current's symobl for being unselected
		once
			Result := Pixmaps.bm_System
		end;

feature {NONE} -- Resources

	default_window_position: BOOLEAN_PREF_RES;
	str_temporary_dir: STRING_PREF_RES;
	str_profiler_dir: STRING_PREF_RES;
	str_filter_dir: STRING_PREF_RES;
	int_history_size: INTEGER_PREF_RES

end -- class OLD_SYSTEM_PREF_CAT
