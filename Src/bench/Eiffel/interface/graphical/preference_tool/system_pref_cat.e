indexing

	description:
		"Abstract notion of category of resources used for a UI.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			System_resources as associated_category
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

			!! parse_class_after_saving.make 
							(associated_category.parse_class_after_saving, Current)
			!! default_window_position.make (associated_category.default_window_position, Current);
			!! str_temporary_dir.make (associated_category.temporary_dir, Current);
			!! str_profiler_dir.make (associated_category.profiler_dir, Current);
			!! str_filter_dir.make (associated_category.filter_dir,	Current);
			!! int_history_size.make (associated_category.history_size, Current)

			resources.extend (default_window_position);
			resources.extend (parse_class_after_saving);
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

			button.set_selected (False);

			rc_make (name, a_parent)
		end

feature -- Properties

	name: STRING is "System preferences"
			-- Current's name

	symbol: PIXMAP is
			-- Current's symobl for being unselected
		once
			Result := bm_System
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'
		local
			full_path: FILE_NAME
		once
			Result := bm_System_dot
		end

feature {NONE} -- Resources

	parse_class_after_saving: BOOLEAN_PREF_RES;
	default_window_position: BOOLEAN_PREF_RES;
	str_temporary_dir: STRING_PREF_RES;
	str_profiler_dir: STRING_PREF_RES;
	str_filter_dir: STRING_PREF_RES;
	int_history_size: INTEGER_PREF_RES

end -- class SYSTEM_PREF_CAT
