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
			init_colors, save_resources
		end;
	SYSTEM_CONSTANTS

create
	make

feature -- Access

	save_resources (file: PLAIN_TEXT_FILE) is
		-- Save the resources from Current in `file'.
		do
			Precursor {PREFERENCE_CATEGORY} (file)
			if associated_category.motif_1_2.actual_value then
				file.put_string ("motif_1_2: true%N")
			else
				file.put_string ("motif_1_2: false%N")
			end
		end


feature {NONE} -- Initialization

	update_resources is
			-- Update `resources'.
		do
			if Platform_constants.is_windows then
				create regular_button.make (associated_category.regular_button);
			end
			create close_button.make (associated_category.close_button)
			create acrobat_reader.make (associated_category.acrobat_reader);
			create text_mode.make (associated_category.text_mode);
			if Platform_constants.is_windows then
				create tab_step.make (associated_category.tab_step);
			end
			create editor.make (associated_category.editor);
			create filter_path.make (associated_category.filter_path);
			create profile_path.make (associated_category.profile_path);
			create tmp_path.make (associated_category.tmp_path);
			create shell_command.make (associated_category.shell_command);
			create filter_name.make (associated_category.filter_name);
			create filter_command.make (associated_category.filter_command);
			create history_size.make (associated_category.history_size);
			create default_window_position.make (associated_category.default_window_position);
			create window_free_list_number.make (associated_category.window_free_list_number);
			create color_list.make (associated_category.color_list);
			if not Platform_constants.is_windows then
				create print_shell_command.make (associated_category.print_shell_command);
			else
				create browsing_facilities.make (associated_category.browsing_facilities);
			end

			if Platform_constants.is_windows then
				resources.extend (regular_button);
			end
			resources.extend (close_button);
			resources.extend (acrobat_reader);
			resources.extend (text_mode)
			if Platform_constants.is_windows then
				resources.extend (tab_step);
			end
			resources.extend (editor);
			resources.extend (filter_path);
			resources.extend (profile_path);
			resources.extend (tmp_path);
			resources.extend (shell_command);
			resources.extend (filter_name);
			resources.extend (filter_command);
			resources.extend (history_size);
			resources.extend (default_window_position);
			resources.extend (window_free_list_number);
			resources.extend (color_list)
			if not Platform_constants.is_windows then
				resources.extend (print_shell_command)
			else
				resources.extend (browsing_facilities);
			end
		end;

	init_colors is
			-- Initialize the colors of the page.
		local
			att: WINDOW_ATTRIBUTES
		do
			create att;
			att.set_composite_attributes (Current)
		end

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Currrent's visual aspects.
		local
			button: EB_PREFERENCE_BUTTON;
			menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY
		do
			create button.make (Current, a_button_parent);
			create menu_entry.make (Current, a_menu);
			create holder.make (button, menu_entry);

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
	regular_button, browsing_facilities,
	close_button, default_window_position: BOOLEAN_PREF_RES;
	history_size: INTEGER_PREF_RES;
	window_free_list_number: INTEGER_PREF_RES;
	color_list: ARRAY_PREF_RES
	text_mode: STRING_PREF_RES;

end -- class GENERAL_PREF_CAT
