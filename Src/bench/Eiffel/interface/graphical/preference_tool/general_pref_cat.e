indexing

	description:
		"Resource category for the class tool.";
	date: "$Date$";
	revision: "$Revision$"

class GENERAL_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			General_resources as associated_category
		export
			{NONE} all
		end;
	PREFERENCE_CATEGORY
		redefine
			init_colors
		end;
	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	update_resources is
			-- Update `resources'.
		do
			!! regular_button.make (associated_category.regular_button);
			!! acrobat_reader.make (associated_category.acrobat_reader);
			!! text_mode.make (associated_category.text_mode);
			!! tab_step.make (associated_category.tab_step);
			!! editor.make (associated_category.editor);
			!! filter_path.make (associated_category.filter_path);
			!! profile_path.make (associated_category.profile_path);
			!! tmp_path.make (associated_category.tmp_path);
			!! shell_command.make (associated_category.shell_command);
			!! filter_name.make (associated_category.filter_name);
			!! filter_command.make (associated_category.filter_command);
			!! browsing_facilities.make (associated_category.browsing_facilities);
			!! history_size.make (associated_category.history_size);
			!! default_window_position.make (associated_category.default_window_position);
			!! window_free_list_number.make (associated_category.window_free_list_number);
			!! color_list.make (associated_category.color_list);
			if not Platform_constants.is_windows then
				!! print_shell_command.make (associated_category.print_shell_command);
			end

			resources.extend (regular_button);
			resources.extend (acrobat_reader);
			resources.extend (text_mode)
			resources.extend (tab_step);
			resources.extend (editor);
			resources.extend (filter_path);
			resources.extend (profile_path);
			resources.extend (tmp_path);
			resources.extend (shell_command);
			resources.extend (filter_name);
			resources.extend (filter_command);
			resources.extend (browsing_facilities);
			resources.extend (history_size);
			resources.extend (default_window_position);
			resources.extend (window_free_list_number);
			resources.extend (color_list)
			if not Platform_constants.is_windows then
				resources.extend (print_shell_command)
			end
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

	name: STRING is "General preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_General
		end;

feature {NONE} -- Resources

	tab_step: INTEGER_PREF_RES;
	acrobat_reader, editor, filter_path, profile_path, tmp_path: STRING_PREF_RES;
	shell_command: STRING_PREF_RES;
	print_shell_command: STRING_PREF_RES;
	filter_name: STRING_PREF_RES;
	filter_command: STRING_PREF_RES;
	regular_button, browsing_facilities, default_window_position: BOOLEAN_PREF_RES;
	history_size: INTEGER_PREF_RES;
	window_free_list_number: INTEGER_PREF_RES;
	color_list: ARRAY_PREF_RES
	text_mode: STRING_PREF_RES;

end -- class GENERAL_PREF_CAT
